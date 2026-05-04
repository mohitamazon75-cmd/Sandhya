# CLAUDE.md — Working Rules for Sandhya

> **You are working on Sandhya, a daily Sanatan Dharma companion app.** Mohit is a non-technical founder. He is working with another Claude (in claude.ai) as the product/architecture partner. That Claude has produced the plan in `docs/`. Your job is to execute that plan carefully, in small reviewable steps, under Mohit's direction.
>
> **Read all files in `docs/` before making any non-trivial change.** They are the contract.

---

## The Project, in one paragraph

Sandhya is a daily companion delivered as a hybrid of WhatsApp messages and a lightweight web/PWA. Every morning at the user's local sunrise, a WhatsApp message arrives containing a personalised Vedic snapshot of the day — auspicious and inauspicious windows, a colour, a mantra, do's and don'ts — all computed against the user's exact birth chart. The message links to three things on the web app: a 100-word reading composed in voice, a short story with a teaching, and one deep philosophical principle. An evening WhatsApp asks how the day went and offers a sleep mantra. Content rotates across schools and traditions over 30-day windows.

**Read `docs/V1_SCOPE.md` for full scope.**

---

## Working Rules — Non-Negotiable

These are not preferences. They are the lessons learned from a previous app that fell into a 6-month audit loop. We do not repeat them.

### 1. Small reviewable steps

- One file or one focused change per response. Not "build the feature." Not "scaffold the app." Not "implement the engine."
- After every step, stop and tell Mohit in plain English what was created or changed. Wait for confirmation before continuing.
- If you find yourself about to create or modify more than 3 files in one response, stop. Ask first.

### 2. No improvisation on architecture

- The stack is locked: Next.js 14 App Router, TypeScript, Tailwind, shadcn/ui, Supabase (Postgres + Auth + RLS + pgvector), Vitest, GitHub Actions CI, Vercel hosting, Anthropic API for composer, WhatsApp Business API for messaging.
- Do not propose alternative stacks. Do not silently substitute libraries. Do not add new top-level dependencies without asking.
- Do not introduce new patterns ("let's use a server action here," "let's use trpc," "let's use Drizzle") without an explicit conversation about why.

### 3. The jyotish engine is ported, not regenerated

- The astrology engine in `lib/jyotish/` is being ported file-by-file from an existing repo: `cosmic-karma-decoder` (a.k.a. RajYog). Mohit owns it under license.
- **You do not regenerate astronomy code from training.** Wait for Mohit to paste or point you at the source file. Then port it carefully, preserving all logic, especially the Meeus obliquity formula, the RAMC ascendant calculation, the Lahiri ayanamsa lock, and the WASM SHA-256 integrity check.
- Every ported function gets a Vitest invariant test (`tests/jyotish/`) that asserts output matches the existing engine's output to 4 decimal places against the founder's chart fixture.
- Files to port (in this order, in session 2): `astro-constants.ts`, `sweph.ts`, `vedic-engine.ts`, `chart-parser.ts`. Skip `yoga-engine.ts`, `health-engine`, `decision-engine`, `interpret-yoga` — these are out of scope for v1.

### 4. Database changes go through migrations

- Schema is in `supabase/migrations/`. RLS is enabled on every user-data table from creation, never as an afterthought.
- Do not write code that touches the database from the Supabase service role unless the operation truly requires it (chart computation, content seeding, scheduled jobs). Default to `auth.uid()`-scoped reads.
- Any new table requires a migration file with RLS policies in the same migration.

### 5. Voice rules apply to ALL text that ships

- Read `docs/VOICE.md` before writing any user-facing string. This includes UI labels, error messages, paywall copy, push notifications, and the composer prompt.
- Forbidden vocabulary: *energy, energies, vibration, vibrations, manifestation, manifest, attract, the universe is telling you, the cosmos, cosmic, frequencies, high vibe, low vibe, blessed, abundance, alignment (new-age sense), spiritual journey, awakening, ascension.*
- No exclamation marks. No emoji. Ever.
- See `docs/VOICE.md` §3 *On Fear and Tough Love* for the most important rule in the whole spec.

### 6. Content has provenance or it doesn't ship

- Every `corpus_entries` row needs `source_url` populated with a verifiable canonical public-domain source. See `docs/CONTENT_SOURCES.md`.
- Do not generate spiritual content from your training. Wait for Mohit to provide source text or point you at a URL to fetch.
- Aggregator websites (Speaking Tree, generic blogs, modern paraphrase sites) are banned as primary sources.

### 7. Refusal of dark patterns

We do not implement: streak counters, consultation-upsell flows, fake urgency, fake scarcity, FOMO push notifications, infinite scroll, public engagement metrics, prediction-style life-event copy, lifespan estimation. If you find yourself coding any of these, stop. Read `docs/V1_SCOPE.md` §5.

### 8. Tests matter

- Every meaningful function gets a Vitest test. Run `npm run test` before claiming work is done.
- Run `npm run typecheck` and `npm run lint` before claiming work is done.
- CI runs all four checks (typecheck, lint, test, build). They must be green on every push.

### 9. When in doubt, stop

- Don't try to recover silently from errors.
- Don't "fix" something Mohit didn't ask you to fix.
- Don't expand scope. Don't optimise prematurely. Don't refactor that-thing-you-noticed-while-passing-by.
- "I noticed X is bad — should I fix it?" is the right question. Acting on it without asking is the wrong action.

---

## Where Things Live

```
.
├── app/                          Next.js 14 App Router
│   ├── globals.css               Tailwind + design tokens
│   ├── layout.tsx                Root layout
│   └── page.tsx                  Placeholder home
├── lib/
│   ├── jyotish/                  Astrology engine (porting in session 2)
│   └── supabase/                 client.ts, server.ts
├── tests/
│   └── jyotish/                  Engine invariants (founder chart as fixture)
├── supabase/migrations/          DB schema with RLS
├── docs/                         The plan — read before non-trivial changes
│   ├── V1_SCOPE.md               What's in v1, what's out, week-by-week
│   ├── VOICE.md                  Editorial register, forbidden vocabulary
│   ├── BRAND.md                  Name, tagline, audience, anti-positioning
│   ├── V2_DEFERRED.md            What's not in v1 and why
│   ├── CONTENT_SOURCES.md        Public-domain sources for content corpus
│   └── SESSION_1_RUNBOOK.md      The literal sequence for session 1
└── .github/workflows/ci.yml      Typecheck + lint + test + build
```

---

## Session-by-Session Plan (high level)

| Session | Goal |
|---|---|
| 1 | Verify environment, push to GitHub, deploy to Vercel, connect Supabase, apply initial migration. NO engine code yet. |
| 2 | Port `astro-constants.ts` and `sweph.ts` from RajYog. Verify ascendant on founder fixture. |
| 3 | Port `vedic-engine.ts` and `chart-parser.ts`. Verify dasha + nakshatra. |
| 4 | Panchang engine (tithi, nakshatra, yoga, karana, vara, choghadiya, rahu kalam). |
| 5 | Today's transits + signal extractor. |
| 6 | Composer prompt v1 (signal selector + composer + story/principle pickers). |
| 7 | Journal + archive + monthly wisdom letter. |
| 8 | WhatsApp integration. |
| 9 | Polish, paywall, landing. |
| 10 | Closed beta. |

Mohit drives the cadence. Don't run ahead.

---

## What to Do Right Now (first prompt of every fresh session)

1. Read this file (you just did).
2. Read `docs/V1_SCOPE.md` if you haven't this session.
3. Tell Mohit: "I've read CLAUDE.md and the scope. I see we're at session N (based on git log / docs/SESSION_LOG.md). What's today's task?"
4. Then stop and wait.

Do not start editing files. Do not "get a head start." Wait for direction.

---

## What Mohit Needs from You

- Slow down. He is not a developer. He cannot review 400 lines of generated code.
- One file at a time. One change at a time. Plain-English explanation after each.
- When something fails, paste the actual error and stop. Do not try fixes without confirmation.
- Treat him with respect. He has good judgment about the product. His weakness is the technical translation layer; bridge it patiently.

---

*Last updated: scaffold session. Update `docs/SESSION_LOG.md` at the end of each working session with: what was built, deviations from the plan, and open questions for next time.*
