# Session Log

A running log of what gets built each session, what deviates from the plan, and open questions for next time. Append at the end of every working session — never edit prior entries.

---

## Session 0 — Scaffold (done in claude.ai sandbox)

**Date:** 2026-05-02
**Driver:** Mohit (founder) + Claude (claude.ai conversation)
**Goal:** Produce a starter project with foundation docs baked in, ready to handoff to Claude Code on Mohit's Mac.

**Built:**
- Next.js 14 App Router scaffold (TypeScript, Tailwind, shadcn-ready)
- `docs/` populated with V1_SCOPE, VOICE, BRAND, V2_DEFERRED, CONTENT_SOURCES, SESSION_1_RUNBOOK
- `CLAUDE.md` with working rules
- Initial Supabase migration (`00000000000001_initial_schema.sql`) with RLS on every user-data table, pgvector enabled, corpus and journal schemas
- `lib/jyotish/index.ts` placeholder with port instructions
- `tests/jyotish/fixtures.ts` with founder chart as ground-truth fixture (expected values null until verified against RajYog)
- GitHub Actions CI (`typecheck + lint + test + build`)
- Restrained earth-tone design tokens in `app/globals.css`
- README, .env.example, .gitignore

**Deviations from plan:** None. Scaffold matches V1_SCOPE.

**Open questions for session 1:**
- Domain & trademark verification for "Sandhya" — Mohit to check `instantdomainsearch.com` and Indian trademark registry
- Hindi voice register samples — Mohit to provide 2–3 in-voice and 2–3 out-of-voice examples (VOICE.md §2)
- Pricing validation — placeholder ₹149/month in V1_SCOPE; revisit after closed beta

**Handoff notes:**
- Zip is ready at `/mnt/user-data/outputs/sandhya-starter.zip`
- Mohit unzips on Mac, runs `npm install`, opens Claude Code in directory
- Claude Code reads `CLAUDE.md` and waits for direction
- Session 1 task = environment verification + GitHub push + Vercel deploy + Supabase connect (no engine code yet)

---

<!-- New entries below this line -->
