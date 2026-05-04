# Sandhya — V1 Scope

**Status:** Locked, drafted [date of writing]. Working name pending domain/trademark verification.
**Owners:** Founder + Claude (drafter, technical builder).
**Purpose:** The single source of truth for what is and is not in v1. Every scope dispute gets resolved by re-reading this document, not by re-arguing.

---

## 1. The Product, in one paragraph

Sandhya is a daily Sanatan Dharma companion delivered as a hybrid of WhatsApp messages and a lightweight web/PWA. Every morning at the user's local sunrise, a WhatsApp message arrives containing a personalised Vedic snapshot of the day — auspicious and inauspicious windows, a colour to wear, a mantra, do's and don'ts — all computed against the user's exact birth chart. The message links to three things on the web app: a 100-word reading composed in voice, a short story or anecdote with a teaching, and one deep philosophical principle from the breadth of Indian thought. An evening WhatsApp asks how the day went and offers a sleep mantra. Content rotates across schools and traditions over 30-day windows. There are no streaks, no consultation upsells, no fear marketing, and no predictions about life events. The product respects the tradition's actual gravity — which means it can name hard things honestly when the day's chart calls for it — but it refuses to manufacture anxiety to drive transactions.

---

## 2. Audience

The average Indian who opens WhatsApp first thing in the morning, ages roughly 28–55, plus the NRI variant of the same person. Reads English, Hinglish, or Hindi comfortably. Smartphone-native. Has tried mainstream astro apps (AstroTalk, Astrosage) and found them embarrassing or scammy. Has tried Western wellness apps (Calm, Headspace) and found them culturally hollow. Considers themselves spiritual but is past the bumper-sticker phase. Would pay a small monthly fee for something honest and beautiful that fits their existing morning rhythm rather than asking them to build a new one.

This is not the Bangalore seeker minority. It's the mass-market Indian household-spirituality audience that the existing market either talks down to or scams.

---

## 3. The Six-Point Wedge

Sandhya is the only daily Sanatan companion that delivers all six of these together:

1. **Personalised to the user's exact birth chart**, not sun-sign — which requires real engine investment competitors do not make for free or low tiers.
2. **Integrated daily structure** — morning snapshot, story, principle, evening reflection, sleep mantra — in one product instead of four.
3. **Editorial quality in Hindi and English** — voice-locked, written for adults, no translation-house clichés.
4. **Refusal of dark patterns** — no streaks, no pandit upsells, no fake urgency, no engineered FOMO. Tough love when the tradition calls for it; never manufactured fear to sell.
5. **Cultural pluralism of Sanatan itself** — multi-school (Advaita, Yoga, Bhakti, Sant Mat, Tantra-philosophical, Samkhya), multi-regional (North, South, East, West, folk), full breadth rather than the flattened Vaishnava-Vedanta default of every competitor.
6. **Beautiful, modern, mobile production values** — typography that respects Devanagari, restrained design system, no clip-art deities, no 2008-era UI.

Each one alone is weak. Together they describe a product that does not currently exist in market and that competitors structurally cannot copy without becoming a different company.

---

## 4. What's IN v1

### 4.1 Onboarding
- Birth date, time, place (geocoded).
- Language preference: English / Hinglish / Hindi (Devanagari).
- Phone number for WhatsApp delivery.
- Optional: name, gender, current life focus (one chip from a small list — career, health, family, study, peace).
- One-screen disclaimer: this is a contemplative tool, not medical/legal/financial advice.

### 4.2 The Morning WhatsApp Message (sent at user's local sunrise)
A short structured message containing:
- Greeting using the user's name in their chosen register.
- One-line summary of today's emphasis from the chart.
- Auspicious window (e.g. "best between 7:42–9:18 AM").
- One window to be cautious in (rahu kalam or relevant choghadiya).
- Suggested colour.
- Suggested mantra (with a one-tap audio link).
- One do, one don't — drawn from the day's panchang × user's chart.
- Three links: today's reading, today's story, today's principle.

The message is composed by the system, not boilerplated. Each field is computed against the user's chart; the prose is generated via the composer prompt in the locked voice.

### 4.3 The Web/PWA Daily Reading
The full 100-word composed reading. Voice-locked. Names what the day asks, why (in plain language, with the astrological reasoning available on tap-to-expand for users who want it), and one practice — a contemplation, a breath, a journaling prompt, a single-line sankalpa.

### 4.4 The Daily Story
A 60–90 second story drawn from the public-domain canonical sources (see CONTENT_SOURCES.md). Voice-rewritten in Easwaran register. Themed to the day's emphasis. Ends without a stated moral; lets the story land.

### 4.5 The Daily Principle
One philosophical teaching, 80–120 words, sourced from a real classical text with attribution. Rotates across schools over 30-day windows so a user is exposed to Advaita, Yoga, Bhakti, Sant Mat, Tantra-philosophical, and Samkhya teachings without being told the rotation is happening.

### 4.6 The Evening WhatsApp Message (sent at user's local dusk/sandhya)
- A reflection prompt that varies by tradition framing (Vedantic, Yogic, Bhakti, Karma-yoga registers).
- A sleep mantra with audio link.
- Optional one-tap response (good day / hard day / mixed) that gets logged to the journal.

### 4.7 The Journal / Wisdom Archive
- Every reading, story, principle, and reflection logged to the user's history.
- Timeline view.
- Pattern view: most-emphasised themes over time, dasha-period visualisation, a simple "what your year has been" view.
- Monthly auto-generated wisdom letter — Claude composes a 200-word reflection on the user's last 30 days from their logged content. This is the retention moat.

### 4.8 Astrology Engine (ported from existing repo)
- Swiss Ephemeris WASM with SHA-256 integrity verification.
- True obliquity / RAMC ascendant math.
- Lahiri ayanamsa, Lagna boundary warnings within 1° of cusp.
- Vargas: D1, D9, D10, D24.
- Vimshottari Dasha (mahadasha → antardasha → pratyantardasha).
- Nakshatra logic with pada and dispositor.
- Panchang engine: tithi, nakshatra, yoga, karana, vara, choghadiya, rahu kalam.
- Daily transit computation against user's natal positions.
- Festival calendar.

### 4.9 Composition Layer (new build, the IP)
- **Signal selector** (Claude Haiku): given today's panchang × user's natal × current dasha + transits, choose the 1–2 signals that should drive today's reading from the 8–10 candidates. Rules-based scoring + LLM tie-breaking.
- **Composer** (Claude Sonnet): given selected signals, compose the morning message + reading + practice in the locked voice. School-rotation enforced via a calendar that tracks which philosophical register each user has seen recently.
- **Story selector**: matches today's theme to a curated story from the corpus.
- **Principle selector**: matches today's theme to a curated principle, respecting the school rotation.

### 4.10 Paywall and Pricing (placeholder, validate in beta)
**Free tier:** morning snapshot delivered via WhatsApp. Web access to today's reading only — no story, no principle, no journal, no archive.
**Paid tier:** full daily experience + journal + archive + monthly wisdom letter. Suggested price ₹149/month or ₹1,499/year. *To be validated with closed beta cohort before locking.* International tier ₹399/$4.99 monthly for NRI / non-Indian users via Stripe.

### 4.11 Languages in v1
English, Hinglish (Roman script), Hindi (Devanagari). Voice spec for English locked; Hindi voice spec to be co-developed with founder review (see VOICE.md).

### 4.12 Stack
- Next.js 14 App Router + Tailwind + shadcn/ui (web/PWA).
- Supabase: Postgres + auth + RLS + pgvector.
- WhatsApp Business API (via Meta directly or via a BSP — to be decided week 1).
- Claude Sonnet 4.5 for composer; Claude Haiku for signal selection; embeddings for content retrieval.
- Razorpay (India), Stripe (international).
- PostHog analytics, Sentry errors.
- Vercel hosting for web, Supabase Edge Functions for backend.

---

## 5. What is OUT of v1 (explicit kill list)

These are temptations. Each one has been considered and rejected for v1. They may return in v2 or never.

- **No "ask Sandhya" guru-style Q&A.** Deferred to v2 with proper archetype-taxonomy architecture (see V2_DEFERRED.md).
- **No yoga catalogue display.** Yogas are computed and used as context inside readings when relevant. They are never shown as a scoreboard ("you have 23 yogas").
- **No 130-yoga detection engine port.** Out of scope for v1 reading composition.
- **No health engine, lifespan estimation, disease risk, AyurArogya.** Not in v1, not in v2, not ever in this product.
- **No decision engine** (the existing repo's "should I do X" feature). Out of scope.
- **No 2-pass yoga interpreter.**
- **No Sudarshan Chakra component.**
- **No role-persona system** (vyapaari, naukri, etc.). Interesting but premature.
- **No PDF report export in v1.** May return in v2 as a paid extra.
- **No virtual puja booking.** Refused on positioning grounds.
- **No pandit consultation marketplace.** Refused on positioning grounds.
- **No live satsang, video calls, or 1:1 features.**
- **No public feed, community, comments, likes, or social metrics.**
- **No streak counter, no badges, no gamification.**
- **No notification beyond morning + evening WhatsApp messages.** No festival blasts, no "you missed a day" nags, no marketing pushes.
- **No date-stamped life-event predictions.** ("Promotion window opens October." "Marriage in April.") Banned.
- **No fear-marketing ("your dosha is dangerous, click here for remedy").** Tough love is allowed; manufactured fear is banned. See VOICE.md *On Fear and Tough Love*.
- **No regional Indian languages beyond Hindi in v1.** Marathi, Tamil, Bengali, Telugu, etc. → v2 if traction supports it.
- **No native iOS or Android app.** PWA only in v1.
- **No Bhakti poetry corpus** (Mira, Kabir, Tulsi, Akka Mahadevi, Lal Ded, Tukaram). Deferred to v2 because the best translations are copyrighted; ships when we've licensed or commissioned clean translations.
- **No scholar reviewer in v1.** Public-domain canonical sources are already scholar-vetted (19th–early 20th century academic translations). Scholar reviewer added in v2 when corpus expands.
- **No AI chatbot of any kind in v1.** (The composer is invisible infrastructure, not a chat surface.)
- **No frontend code from the existing RajYog repo is reused.** Engine logic only.

---

## 6. Engine Port Plan (Weeks 1–2)

**Source:** existing RajYog repo (cosmic-karma-decoder).
**Target:** new `lib/jyotish/` module in fresh Next.js repo, fully owned, fully tested.

**Port:**
- `supabase/functions/_shared/sweph.ts` → Swiss Ephemeris integration with WASM integrity check.
- `supabase/functions/_shared/astro-constants.ts` → rashi maps, sign lords, exaltations, friendships, nakshatra constants.
- `supabase/functions/_shared/vedic-engine.ts` → vargas, charakarakas, Vimshottari, nakshatra logic. Skip the Argala/Arudha sections for v1 (used by features we're not building).
- `supabase/functions/_shared/chart-parser.ts` → chart structure assembly.

**Don't port:**
- `yoga-engine.ts` (1170 lines, not used in v1).
- `health-engine` directory (entire feature killed).
- `decision-engine` directory (feature killed).
- `interpret-yoga` directory (feature killed).
- All frontend.

**Verification:** for the first 5 test charts (real birth data, varied), run both the existing engine and the new ported engine. Assert identical outputs to 4 decimal places on planetary longitudes, identical sign and nakshatra assignments, identical dasha periods. This catches port errors. Vitest invariants pin behaviour.

**Estimated effort:** 5–7 working days for a focused build with Claude Code drafting and founder review.

---

## 7. Content Seeding Plan (Weeks 1–3, parallel to engine port)

See CONTENT_SOURCES.md for full source list and license notes.

**Target:** 100–120 verified content pieces for v1 launch buffer.
- ~35 stories from Mahabharata, Ramayana, Bhagavata, Hitopadesha, Panchatantra, Jataka.
- ~35 philosophical principles from Bhagavad Gita (with classical commentaries), Yoga Sutras, key Upanishads.
- ~35 morning lessons / anecdotes — shorter, motivation-flavoured, drawn from same sources.
- ~15 mantras with audio (reusable across days, mapped to themes).

**Workflow per piece:**
1. Claude fetches the canonical text from the named public-domain source via web_fetch.
2. Claude drafts a Sandhya-voice version with explicit source link and verse reference.
3. Founder reviews in batches of 5–7 per day (~30–45 minutes/day).
4. Approved pieces go into the corpus database with full provenance metadata.

**Database schema for content:** id, type (story/principle/anecdote/mantra), source_text_id, source_url, source_verse_ref, original_excerpt, sandhya_version_en, sandhya_version_hi, themes (array), schools (array), tone (gentle/hard/uplifting/contemplative), reviewed_at, reviewed_by.

**No aggregator websites used as sources.** Speaking Tree, generic blogs, modern paraphrase sites — all banned. Discovery use only; primary text always from canonical public-domain editions.

---

## 8. Week-by-Week Build Plan

### Weeks 1–2: Foundations
- Repo scaffold (Next.js 14, Tailwind, shadcn/ui, Supabase project provisioned).
- Auth flow (email + Google), RLS schema for `users`, `birth_data`, `daily_messages`, `journal_entries`, `corpus_entries`.
- Engine port from RajYog repo into `lib/jyotish/`.
- Vitest invariants pinning engine outputs against existing engine.
- Geocoding + timezone handling.
- Birth data form.
- **Parallel:** Content seeding sprint begins.

**End of week 2 deliverable:** can submit a birth and get a clean computed chart in JSON. First 30 content pieces approved.

### Weeks 3–4: Panchang, transits, and signal infrastructure
- Daily panchang engine (tithi, nakshatra, yoga, karana, vara, choghadiya, rahu kalam).
- Today's transits against user's natal positions.
- Festival calendar.
- Dasha lookup for any given date.
- Signal extractor: given (user, date), produce structured bundle of 8–10 candidate signals.
- **Parallel:** Content seeding continues.

**End of week 4 deliverable:** can ask the system "what's happening for user X on date D" and get a structured signal bundle. ~80 content pieces approved.

### Weeks 5–6: Composition layer (the IP)
- Signal selector prompt (Haiku, rules-augmented).
- Composer prompt (Sonnet, voice-locked, school-rotation-aware).
- Story selector and principle selector.
- Per-user school-rotation tracking.
- End-to-end pipeline: birth data → today's full output (morning message + reading + story + principle + evening + sleep mantra).
- Iteration on composer prompt against ~20 hand-curated test cases.

**End of week 6 deliverable:** full daily experience generates correctly for any test user on any day. 120 content pieces approved.

### Week 7: Journal and archive
- Save every output to user history.
- Timeline view.
- Pattern view (themes, dasha visualisation).
- Monthly wisdom letter generator.

### Weeks 7–8: WhatsApp integration
- Meta Business API setup or BSP integration.
- Morning + evening message templates approved.
- Sunrise/sunset computation per user location.
- Cron / scheduled function infrastructure.
- Delivery testing across timezones.
- Fallback to web-only if WhatsApp delivery fails.

### Weeks 8–9: Polish, paywall, landing
- Razorpay + Stripe integration.
- Free vs paid gating.
- Landing page (no fake date-stamped predictions; methodology section prominent; voice-locked copy throughout).
- Privacy policy serious about birth data (RLS, encryption, no third-party sharing).
- PWA install prompt, offline reading of cached content.
- PostHog and Sentry instrumentation.
- Performance budget: main JS chunk under 300KB gzipped.

### Weeks 9–10: Closed beta
- 50 hand-recruited users (founder's network — mix of Indian urban, NRI, varying age and gender).
- Daily feedback collection.
- Composer prompt iteration against real reactions.
- Bug fixes.
- Pricing validation.

### Weeks 11–12: Public soft launch
- Cultural Twitter, Instagram, founder's network.
- Goal: 200 paying users by end of week 12.
- Daily metrics review: morning message open rate, web link click-through, paywall conversion, day-7 retention, day-30 retention.

---

## 9. Success Metrics for v1 (90-day post-launch view)

These are targets, not promises. We learn more than we prove in the first 90 days.

- **Morning WhatsApp open rate:** >70% (industry benchmark for transactional WhatsApp is 80%+; spiritual content typically lower).
- **Link click-through to web:** >25% (one of three links opened).
- **Day-7 retention:** >50% of signups still receiving and opening morning messages.
- **Day-30 retention:** >30%.
- **Free → paid conversion:** >5% within 30 days of signup.
- **Net Promoter Score:** >50, measured via in-app prompt at day 30.
- **Cancellation rate:** <8% monthly.

If any of these are dramatically off after 60 days post-launch, we re-examine the wedge — not by adding features but by sharpening positioning.

---

## 10. What v2 Looks Like (for context, not commitment)

See V2_DEFERRED.md for full list. High-level v2 candidates, in rough priority:

1. The "ask Sandhya" guru feature with archetype taxonomy and school-attributed commentary.
2. Bhakti poetry corpus expansion (Mira, Kabir, Tulsi, Akka Mahadevi, Lal Ded, Tukaram) with licensed or commissioned translations.
3. Regional language expansion (Marathi, Tamil, Bengali first).
4. Scholar reviewer on retainer.
5. Family / partner accounts.
6. Native iOS and Android apps.
7. Audio readings narrated by a real voice actor in voice-locked register.

v2 work begins after v1 has 5,000+ paying users and 90-day retention >30%.

---

## 11. What Sandhya is Not — for clarity

This product is not:
- An astrology consultation marketplace.
- A daily horoscope app.
- A mindfulness app with Indian aesthetics painted on top.
- A scripture-search chatbot.
- A virtual puja platform.
- An astrology academy or course.
- A social network for spiritual people.
- A wellness tracker.
- A guru personality cult.

It is one thing only: a daily companion that helps a user start and end each day with the tradition's actual wisdom, beautifully composed, honestly delivered, accurately computed against their own chart. Anything that makes it more than that in v1 makes it less.

---

## 12. Decision Log (this document supersedes all earlier conversation)

- Working name: Sandhya, pending domain/trademark check (next session, first task).
- Voice: Eknath Easwaran register (English). Hindi register: draft to be co-developed.
- Audience: WhatsApp-native average Indian + NRI variant, 28–55, mass-market.
- Delivery: hybrid WhatsApp + web/PWA.
- Engine source: ported from existing RajYog repo (founder has absolute rights).
- Content sourcing: Option A only (canonical public-domain). No aggregator-site content.
- Scholar reviewer: deferred to v2.
- Guru Q&A: deferred to v2.
- Bhakti poetry corpus: deferred to v2.
- Stack: Next.js 14 + Supabase + Claude API + WhatsApp Business API + Razorpay/Stripe.
- Pricing: ₹149/month placeholder, validated in beta. International ₹399/$4.99.
- Timeline: 10–12 weeks to public soft launch.
- Fear in content: allowed when honest tradition-based tough love. Banned when manufactured for transactions. (See VOICE.md *On Fear and Tough Love*.)

---

*This document is the contract between founder and builder for v1. It is revised only by explicit agreement, with the change logged at the bottom of this file. Adding a feature here without removing another is forbidden.*
