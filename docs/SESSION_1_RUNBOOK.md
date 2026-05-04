# Session 1 Runbook

**Goal:** End this session with a working chart engine in a fresh repo, deployed to Vercel, with Mohit's chart computed and verified against RajYog output.

**Time budget:** 4–5 hours, with a hard checkpoint at hour 2 and hour 4.

**Working principle:** Follow the runbook. If something is unclear, ask. Don't improvise architecture.

---

## Phase 0 — Environment verification (15 minutes)

Open a terminal. Run each command. Report back what each returns.

```bash
node --version          # Need: v20.x or higher. If lower, install latest LTS from nodejs.org
git --version           # Need: any 2.x. If missing: brew install git (mac) or apt install git (linux)
claude --version        # Need: any version. If "command not found": npm install -g @anthropic-ai/claude-code
gh --version            # Need: any. If missing: brew install gh OR we use github.com web UI
```

**If anything fails:** stop, paste output, we fix before continuing.

**If all green:**
```bash
claude auth status      # Verifies Anthropic API key is set
gh auth status          # Verifies GitHub login
```

If `claude auth` is not authenticated, run `claude auth login` and follow the prompts. If `gh auth` is not authenticated, run `gh auth login` (use HTTPS, login via browser).

**Checkpoint 0:** All five commands above return success. Move to Phase 1.

---

## Phase 1 — Trademark and domain check (15 minutes)

While Mohit handles environment verification, Claude runs:

1. Web search Indian Trademark Registry (ipindia.gov.in) for "Sandhya" in classes 9 (software), 41 (education), 42 (technology services), 45 (spiritual services).
2. Check domain availability: `sandhya.app`, `sandhya.in`, `sandhya.co`, `sandhya.com`, `getsandhya.com`, `sandhya.co.in`.
3. Check Play Store and App Store for existing apps named "Sandhya" in spiritual/wellness categories.

**Decision rule:**
- Trademark clean + at least one premium domain available → lock Sandhya.
- Trademark conflict in spiritual/wellness category → fall back to Nitya.
- Nitya conflicts → fall back to Tithi.
- Tithi conflicts → Smriti.

**Output:** updated BRAND.md with name locked or replaced.

**Buy the domain immediately upon decision.** Don't wait — domain squatters watch trademark searches. ₹1500–3000 for the year, paid by Mohit on Namecheap or Google Domains.

---

## Phase 2 — Account provisioning (20 minutes)

Mohit creates accounts (Claude can't do this for you):

1. **Vercel** — vercel.com, "Sign up with GitHub." Free tier. ~3 min.
2. **Supabase** — supabase.com, "Sign up with GitHub." Free tier. Create new project: name `sandhya-prod`, region `Mumbai (ap-south-1)`, generate strong DB password (save in password manager). Wait ~2 minutes for project to spin up. ~5 min total.
3. **Anthropic Console** — console.anthropic.com, verify you have an API key with credits. If not, create one and add a small credit balance ($10 is plenty for development). ~3 min.
4. **(Defer) Razorpay, Stripe, Meta WhatsApp** — not needed today. We'll set these up in week 8.

**Save these in a single password manager note titled "Sandhya credentials":**
- GitHub repo URL (added in Phase 3)
- Vercel project URL (added in Phase 3)
- Supabase project URL + anon key + service role key + DB password
- Anthropic API key

---

## Phase 3 — Repo scaffold (45 minutes)

Open Claude Code in a fresh directory:

```bash
mkdir -p ~/projects/sandhya
cd ~/projects/sandhya
claude
```

In Claude Code, give it this exact prompt to scaffold:

> "Create a fresh Next.js 14 project with TypeScript, Tailwind CSS, and shadcn/ui in this directory. App Router, not Pages Router. Add Vitest for testing. Add ESLint with strict TypeScript rules. Add a `.github/workflows/ci.yml` that runs `tsc --noEmit`, `vitest run`, and `next build` on every push and PR. Initialize git, make the first commit. Then push to a new private GitHub repo named 'sandhya'. Show me the file structure when done."

**Verify Claude Code did what was asked:**
- `package.json` has Next 14, TypeScript, Tailwind, vitest, shadcn deps
- `app/` directory exists (App Router, not `pages/`)
- `.github/workflows/ci.yml` runs three checks
- Git history clean: one initial commit
- Pushed to GitHub successfully

**Connect to Vercel:**
- vercel.com → Add New → Project → Import the `sandhya` repo
- Framework: Next.js (auto-detected)
- Deploy with default settings
- First deploy should succeed within 2 minutes
- Verify the deployed URL shows the default Next.js page

**Connect to Supabase:**
- In the repo, install Supabase: `npm install @supabase/supabase-js @supabase/ssr`
- Create `.env.local` with the Supabase URL + anon key (from the Supabase dashboard)
- Add the same env vars in Vercel project settings → Environment Variables
- Create `lib/supabase/client.ts` and `lib/supabase/server.ts` using standard Supabase Next.js patterns
- Commit and push

**Checkpoint 1 (Hour 2):** Repo exists, GitHub CI is green on first push, Vercel deployment is live, Supabase is connected. Take a 10-minute break before Phase 4.

---

## Phase 4 — Database schema (30 minutes)

In Claude Code:

> "Create a Supabase migration for the v1 schema. We need these tables, all with RLS enabled from creation:
>
> 1. `birth_data` — user_id (FK auth.users), name, birth_datetime (timestamptz), latitude, longitude, location_name, timezone_offset, ayanamsa_type (default 'Lahiri'), created_at. RLS: users read/write own rows only.
>
> 2. `chart_cache` — birth_data_id (FK), computed_at, ayanamsa_used, planetary_positions (jsonb), house_cusps (jsonb), vargas (jsonb), dashas (jsonb), engine_version (text). RLS: users read own via birth_data join.
>
> 3. `daily_messages` — id, user_id, date (date), morning_payload (jsonb), evening_payload (jsonb), reading_text (text), story_id, principle_id, sent_morning_at, sent_evening_at, opened_morning_at, opened_evening_at. RLS: users read own only.
>
> 4. `journal_entries` — id, user_id, date, reflection_response (text), day_rating (smallint), created_at. RLS: users read/write own only.
>
> 5. `corpus_entries` — id, type (story/principle/anecdote/mantra enum), source_text (text), source_url (text), source_verse_ref (text), original_excerpt (text), sandhya_text_en (text), sandhya_text_hi (text), themes (text[]), schools (text[]), tone (text), reviewed_at, reviewed_by. RLS: read for all authenticated, write only for service role.
>
> 6. `corpus_embeddings` — corpus_id (FK), embedding (vector(1536)). pgvector. Same RLS as corpus_entries.
>
> 7. `school_rotation_state` — user_id, school_seen_count (jsonb mapping school name to last_seen_date). RLS: users read own only.
>
> Enable pgvector extension first. Write the migration file in supabase/migrations/. Then add a Vitest invariant test that asserts every table has rowsecurity = true."

Apply the migration using Supabase CLI or the dashboard SQL editor.

Verify the invariant test passes: `npm test`.

Commit and push. CI should be green.

---

## Phase 5 — Engine port begins (90 minutes)

This is the core of session one. We port four files from the existing RajYog repo into `lib/jyotish/` of the new repo.

**Order matters.** We go from least-dependent to most-dependent.

### 5.1 Port `astro-constants.ts` (15 minutes)

Source file is in the existing RajYog repo at `supabase/functions/_shared/astro-constants.ts`.

In Claude Code:

> "I'm going to give you the contents of an existing file from a prior project. Port it to `lib/jyotish/astro-constants.ts` in this repo. The file has zero dependencies — it's all static data (rashi maps, sign lords, exaltations, friendships, nakshatra constants, benefic/malefic lists). Convert any Deno-specific imports to standard Node/TypeScript. Do not change any of the actual constant values — those are mathematically and astrologically meaningful."

Mohit pastes the file contents (or shares the existing repo zip with Claude Code if there's a way to extract the file directly).

After port:
- Add a small Vitest test that imports the constants and asserts a few known values (RASHI_MAP[0] === "Aries", SIGN_LORDS["Aries"] === "Mars", etc.).
- Commit: "port: astro-constants from RajYog engine, verified by invariants test."

### 5.2 Port `sweph.ts` (40 minutes)

This is the hardest file. WASM integration with integrity check, Swiss Ephemeris bindings, true-obliquity ascendant math. ~600 lines.

In Claude Code:

> "Port `supabase/functions/_shared/sweph.ts` from the prior project to `lib/jyotish/sweph.ts`. Convert Deno-specific imports (esm.sh, etc.) to npm packages. The sweph-wasm@2.6.9 package is on npm. Keep the WASM SHA-256 integrity verification logic — it's a real security control. Keep the true-obliquity Meeus formula and the RAMC-based ascendant calculation exactly as-is — those are mathematically validated. Add types where any is used loosely. Add a Vitest test that computes the ascendant for one known birth (we'll provide it next) and asserts the result matches a hand-verified value."

Provide the test case using Mohit's chart — Aug 23 1975, 16:16 IST, Ajmer (lat 26.4499, lon 74.6399). Get the expected ascendant value from the existing RajYog system.

**Checkpoint 2 (Hour 4):** sweph.ts ported, test passes against Mohit's known ascendant value. If this fails, we don't proceed — engine accuracy is non-negotiable.

### 5.3 Port `vedic-engine.ts` (30 minutes)

Vargas (D1, D9, D10, D24), chara karakas, Vimshottari dasha, nakshatra logic.

> "Port `supabase/functions/_shared/vedic-engine.ts` to `lib/jyotish/vedic-engine.ts`. Keep all classical computation logic intact. Skip porting the Argala/Arudha/Jaimini sections for now — we marked those out-of-scope for v1. Add Vitest tests asserting that for Mohit's birth, the D1 sign of each planet, the current dasha lord, and the moon's nakshatra all match the values from the prior RajYog system."

### 5.4 Port `chart-parser.ts` (20 minutes)

Assembles the planetary data into a structured chart object.

> "Port `supabase/functions/_shared/chart-parser.ts` to `lib/jyotish/chart-parser.ts`. Connect it to the ported sweph and vedic-engine modules. Add a single end-to-end Vitest test: given Mohit's birth, produce a complete chart object and assert key values match RajYog ground truth."

Commit each file as its own commit with a clear message.

---

## Phase 6 — End-of-session verification (15 minutes)

Create a temporary test endpoint at `app/api/test-chart/route.ts` that takes Mohit's birth and returns the computed chart as JSON.

In a browser, visit the deployed Vercel URL `/api/test-chart`. Verify:
- Lagna (ascendant sign and degree)
- Sun sign
- Moon sign + nakshatra + pada
- Current Vimshottari mahadasha lord
- Current antardasha lord

Match all five against what the RajYog system shows for the same birth.

**If all five match exactly:** session one is a success. The engine is verified, the foundation is deployed, the CI is green. We're ready for Phase 2 of the build (panchang + transits).

**If any value disagrees:** halt. Don't proceed to Phase 2. We diagnose the discrepancy in session two before building anything else on top.

Delete the temporary test endpoint before final commit (it's a debug tool, not a feature).

---

## Phase 7 — Wrap-up (15 minutes)

Final commits:
- All ported engine code in `lib/jyotish/`
- Tests in `tests/jyotish/`
- Schema migration in `supabase/migrations/`
- CI green on main

Update README.md with:
- Project name (Sandhya, or fallback)
- One-line description
- Setup instructions for new dev (Mohit's future hire, or just future-Mohit)
- Link to the foundation docs (V1_SCOPE, VOICE, BRAND, CONTENT_SOURCES, V2_DEFERRED)

Push all foundation docs to a `/docs` folder in the repo so they live with the code.

End-of-session log entry in `docs/SESSION_LOG.md`:
- Date
- What was built
- Any deviations from runbook (and why)
- Open questions for session two

---

## Things that will go wrong (predicted)

Naming these now so we recognize them when they happen, rather than panicking:

1. **WASM integrity check will probably bypass on first run.** The existing RajYog code had a bypass mode for development. It's fine; we re-enable for production in week 8.

2. **First Vercel deploy might fail** with a Supabase env var issue. Common. Add the env vars in Vercel dashboard, redeploy, fixed.

3. **One of the dashas might disagree by a day or two.** Vimshottari calculation is sensitive to exact birth-time precision and how the system computes the moon's nakshatra-fraction at birth. If the disagreement is small (<7 days) and the dasha *lord* matches, we accept it and tune in session two. If the lord itself disagrees, we halt.

4. **Mohit's existing RajYog repo might be hard to extract files from in Claude Code's context.** If so, plan B: I (Claude) read the file from the existing zip in this conversation's context (which I have access to from earlier), summarize the relevant code, and you let me reproduce it in the new repo from my reading. Slightly slower but works.

5. **shadcn install will ask interactive questions** that Claude Code can't answer in non-interactive mode. Mohit may need to run `npx shadcn-ui@latest init` manually once and answer the prompts (we want: TypeScript yes, default style, slate base color, CSS variables yes).

---

## What we are NOT doing in session one

To prevent scope creep:

- **No content sprint work in session one.** That starts session two in parallel.
- **No UI components beyond the test endpoint.** Birth data form is session two.
- **No WhatsApp setup.** Week 7.
- **No paywall.** Week 8.
- **No composer prompt design.** Weeks 5–6.
- **No fancy README, no logo, no landing page.** Week 8 polish.
- **No Hindi voice spec finalization.** Mohit's homework, finalized in session two.

If a temptation to do any of the above arises mid-session, log it in `docs/SESSION_LOG.md` as "deferred to session N" and move on.

---

## After session one

If session one succeeds: session two builds the panchang engine + transit computation + signal extractor. We're on schedule for week-by-week plan from V1_SCOPE.

If session one stalls: we diagnose and fix in session two. The foundation docs don't change. The plan absorbs slippage.

---

*Owner: Mohit + Claude. Reviewed: not yet — Mohit reads this once before we begin.*
