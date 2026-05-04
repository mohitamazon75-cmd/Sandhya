-- ============================================================
-- Sandhya v1 schema — initial migration
-- ============================================================
-- Every user-data table has RLS enabled from creation.
-- corpus_entries are read-public (authenticated), write-service-role-only.
-- See docs/V1_SCOPE.md §4.12 for stack and §4.7 for journal/archive design.
-- ============================================================

-- Required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "vector";

-- ------------------------------------------------------------
-- birth_data
-- One row per user. Stores birth inputs for chart computation.
-- Lahiri ayanamsa is the default; we may eventually allow per-user override.
-- ------------------------------------------------------------
CREATE TABLE public.birth_data (
  id              uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            text,
  birth_datetime  timestamptz NOT NULL,
  latitude        numeric(8,5) NOT NULL,
  longitude       numeric(8,5) NOT NULL,
  location_name   text NOT NULL,
  timezone        text NOT NULL DEFAULT 'Asia/Kolkata',
  ayanamsa_type   text NOT NULL DEFAULT 'Lahiri',
  language        text NOT NULL DEFAULT 'en' CHECK (language IN ('en', 'hi', 'hinglish')),
  phone_e164      text, -- for WhatsApp delivery; null while WhatsApp is deferred (week 7)
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT one_birth_per_user UNIQUE (user_id)
);

ALTER TABLE public.birth_data ENABLE ROW LEVEL SECURITY;

CREATE POLICY birth_data_select_own ON public.birth_data
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY birth_data_insert_own ON public.birth_data
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY birth_data_update_own ON public.birth_data
  FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY birth_data_delete_own ON public.birth_data
  FOR DELETE USING (auth.uid() = user_id);

-- ------------------------------------------------------------
-- chart_cache
-- Computed chart per birth_data. Recompute when engine_version changes.
-- ------------------------------------------------------------
CREATE TABLE public.chart_cache (
  id                    uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  birth_data_id         uuid NOT NULL REFERENCES public.birth_data(id) ON DELETE CASCADE,
  computed_at           timestamptz NOT NULL DEFAULT now(),
  ayanamsa_used         text NOT NULL,
  engine_version        text NOT NULL,
  planetary_positions   jsonb NOT NULL,
  house_cusps           jsonb NOT NULL,
  vargas                jsonb NOT NULL,
  dashas                jsonb NOT NULL,
  CONSTRAINT one_cache_per_birth UNIQUE (birth_data_id)
);

ALTER TABLE public.chart_cache ENABLE ROW LEVEL SECURITY;

CREATE POLICY chart_cache_select_own ON public.chart_cache
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.birth_data b
      WHERE b.id = chart_cache.birth_data_id AND b.user_id = auth.uid()
    )
  );
-- Writes: service-role only (chart computation runs server-side).

-- ------------------------------------------------------------
-- corpus_entries
-- The content corpus: stories, principles, anecdotes, mantras.
-- Curated from public-domain canonical sources (see docs/CONTENT_SOURCES.md).
-- Every row has a verifiable source.
-- ------------------------------------------------------------
CREATE TYPE corpus_type AS ENUM ('story', 'principle', 'anecdote', 'mantra');
CREATE TYPE corpus_tone AS ENUM ('gentle', 'hard', 'uplifting', 'contemplative');

CREATE TABLE public.corpus_entries (
  id                  uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  type                corpus_type NOT NULL,
  source_text         text NOT NULL,        -- e.g. "Mahabharata, Ganguli translation"
  source_url          text NOT NULL,        -- canonical source URL
  source_verse_ref    text,                 -- e.g. "Book 5, Section 33"
  original_excerpt    text,                 -- the source passage being adapted
  sandhya_text_en     text NOT NULL,        -- voice-locked English version
  sandhya_text_hi     text,                 -- voice-locked Hindi (added later)
  themes              text[] NOT NULL DEFAULT '{}',
  schools             text[] NOT NULL DEFAULT '{}',
  tone                corpus_tone NOT NULL DEFAULT 'contemplative',
  reviewed_at         timestamptz,
  reviewed_by         text,
  created_at          timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.corpus_entries ENABLE ROW LEVEL SECURITY;

CREATE POLICY corpus_select_authenticated ON public.corpus_entries
  FOR SELECT USING (auth.role() = 'authenticated');
-- Writes: service-role only.

CREATE INDEX corpus_themes_gin ON public.corpus_entries USING gin (themes);
CREATE INDEX corpus_schools_gin ON public.corpus_entries USING gin (schools);
CREATE INDEX corpus_type_idx ON public.corpus_entries (type);

-- ------------------------------------------------------------
-- corpus_embeddings
-- Vector embeddings for semantic content selection.
-- 1536-dim is OpenAI text-embedding-3-small / Voyage equivalent.
-- ------------------------------------------------------------
CREATE TABLE public.corpus_embeddings (
  corpus_id   uuid PRIMARY KEY REFERENCES public.corpus_entries(id) ON DELETE CASCADE,
  embedding   vector(1536) NOT NULL,
  model       text NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.corpus_embeddings ENABLE ROW LEVEL SECURITY;

CREATE POLICY corpus_embeddings_select_authenticated ON public.corpus_embeddings
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE INDEX corpus_embeddings_ivfflat
  ON public.corpus_embeddings USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

-- ------------------------------------------------------------
-- daily_messages
-- One row per user per day. Records what was sent and how the user engaged.
-- ------------------------------------------------------------
CREATE TABLE public.daily_messages (
  id                  uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id             uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date                date NOT NULL,
  morning_payload     jsonb NOT NULL,         -- panchang snapshot, color, mantra, do/dont
  evening_payload     jsonb,                  -- reflection prompt + sleep mantra
  reading_text_en     text NOT NULL,
  reading_text_hi     text,
  story_id            uuid REFERENCES public.corpus_entries(id),
  principle_id        uuid REFERENCES public.corpus_entries(id),
  selected_signals    jsonb NOT NULL,         -- which signals drove today's reading
  schools_used        text[] NOT NULL DEFAULT '{}',  -- for rotation tracking
  sent_morning_at     timestamptz,
  sent_evening_at     timestamptz,
  opened_morning_at   timestamptz,
  opened_evening_at   timestamptz,
  created_at          timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT one_msg_per_user_per_day UNIQUE (user_id, date)
);

ALTER TABLE public.daily_messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY daily_msg_select_own ON public.daily_messages
  FOR SELECT USING (auth.uid() = user_id);
-- Writes: service-role only (composer pipeline runs server-side).

CREATE INDEX daily_msg_user_date_idx ON public.daily_messages (user_id, date DESC);

-- ------------------------------------------------------------
-- journal_entries
-- User reflections in response to evening prompts.
-- ------------------------------------------------------------
CREATE TABLE public.journal_entries (
  id                    uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id               uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date                  date NOT NULL,
  reflection_response   text,
  day_rating            smallint CHECK (day_rating BETWEEN 1 AND 5),
  created_at            timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT one_entry_per_user_per_day UNIQUE (user_id, date)
);

ALTER TABLE public.journal_entries ENABLE ROW LEVEL SECURITY;

CREATE POLICY journal_select_own ON public.journal_entries
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY journal_insert_own ON public.journal_entries
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY journal_update_own ON public.journal_entries
  FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY journal_delete_own ON public.journal_entries
  FOR DELETE USING (auth.uid() = user_id);

-- ------------------------------------------------------------
-- school_rotation_state
-- Tracks which philosophical schools each user has been exposed to and when.
-- Drives the 30-day rotation logic in the composer.
-- ------------------------------------------------------------
CREATE TABLE public.school_rotation_state (
  user_id             uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  school_last_seen    jsonb NOT NULL DEFAULT '{}'::jsonb,  -- {"advaita": "2026-05-01", ...}
  updated_at          timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.school_rotation_state ENABLE ROW LEVEL SECURITY;

CREATE POLICY rotation_select_own ON public.school_rotation_state
  FOR SELECT USING (auth.uid() = user_id);
-- Writes: service-role only.

-- ============================================================
-- Invariants (verified by tests/db/rls.test.ts in a later session)
-- ============================================================
-- 1. Every table in the public schema with user data has rowsecurity = true.
-- 2. corpus_entries.source_url is non-null on every row (no unsourced content).
-- 3. daily_messages.reading_text_en is non-null (we never ship an empty reading).
-- ============================================================
