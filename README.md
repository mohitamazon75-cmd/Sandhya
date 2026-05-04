# Sandhya

A daily companion in the tradition.

> **Working name. Pending domain & trademark verification — see `docs/BRAND.md`.**

---

## What this is

Sandhya is a daily Sanatan Dharma companion — delivered as a hybrid of WhatsApp + lightweight web/PWA — that gives users a personalised Vedic snapshot of each day, a story or anecdote with a teaching, and one deep philosophical principle, all written in a locked editorial voice across the breadth of Indian thought.

**Read `docs/V1_SCOPE.md` for what's in v1.**

---

## Quickstart for the founder (Mohit)

You should not need to run any of these commands manually during normal sessions — Claude Code does it. They're here for emergencies and reference.

### First-time setup on your Mac

```bash
# Clone (after pushing to GitHub)
git clone https://github.com/<your-github>/sandhya.git
cd sandhya

# Install deps
npm install

# Copy env template
cp .env.example .env.local
# Then fill in NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY
# from your Supabase project's API settings.
```

### Local dev

```bash
npm run dev          # http://localhost:3000
```

### Verification before committing

```bash
npm run typecheck
npm run lint
npm run test
npm run build
```

CI runs all four. Local pass before push saves time.

---

## Architecture

- **Frontend:** Next.js 14 (App Router) + TypeScript + Tailwind + shadcn/ui
- **Backend:** Supabase (Postgres + Auth + RLS + pgvector)
- **AI:** Anthropic Claude (Sonnet 4.7 for composer, Haiku 4.5 for selector)
- **Messaging:** WhatsApp Business API (week 7+)
- **Payments:** Razorpay (India), Stripe (international) (week 8+)
- **Hosting:** Vercel (web), Supabase (backend)

---

## Working with Claude Code

Open Claude Code in the project root. It will read `CLAUDE.md` automatically and know the rules of engagement.

### Rules of engagement

- Small, reviewable steps. One file at a time.
- The astrology engine is **ported** from `cosmic-karma-decoder`, not regenerated.
- Voice rules in `docs/VOICE.md` apply to every shipped string.
- Content provenance is non-negotiable (`docs/CONTENT_SOURCES.md`).
- See `CLAUDE.md` for the full list.

### What's in `docs/`

- `V1_SCOPE.md` — what we're building, what we're not, week-by-week plan
- `VOICE.md` — editorial spec, forbidden vocabulary, fear/tough-love rules
- `BRAND.md` — name, tagline, audience, anti-positioning
- `V2_DEFERRED.md` — features cut from v1, with structured plans
- `CONTENT_SOURCES.md` — public-domain canonical sources for the content corpus
- `SESSION_1_RUNBOOK.md` — the literal first-session sequence

---

## Contact

Founder: Mohit Mathur
Build partner: Claude (Anthropic)

Status: pre-launch, foundation phase.
