# V2_DEFERRED.md

**What we have committed to but are deliberately not building in v1.**

Each item below is a real product expansion we believe in. None of them ship in v1. This document exists so the deferral is structured rather than vague — when we get to month 4-5 and start v2 planning, we don't have to re-derive what we meant.

The standing rule from V1_SCOPE applies: ideas that arise during the v1 build go *here*, not into the build.

---

## 1. The guru-style Q&A — *the most important v2 feature*

### What it is

A bounded question-and-answer surface where the user asks a real life question ("my mother is dying, what does the tradition say about anticipatory grief?", "I'm considering leaving my marriage, how does the tradition think about this?", "I keep failing at the same kind of thing, why?") and Sandhya responds in voice with:

- A short framing of the question type
- Two or three perspectives from different schools of Sanatan thought, attributed to source and school
- Where the schools differ, the difference is named explicitly rather than synthesized away
- Where the schools agree, the convergence is noted
- One concrete practice grounded in the user's question
- A close that returns the question to the user — Sandhya does not adjudicate; the tradition presents the options, the user decides

### Why it is deferred

Because the failure mode of building this badly is *catastrophic for the brand*. The current market is full of Hindu-GPT wrappers that do shallow RAG over scripture and produce confidently wrong, school-flattened, single-perspective answers. If our Q&A reads like one of those for even one viral query, our positioning ("we treat the tradition with the respect every other app fails to") is dead permanently.

Building it right requires:

- A curated archetype taxonomy of ~200 question types (dharma-vs-artha conflict, anticipatory grief, ego inflation, decision under uncertainty, parental conflict, attachment-suffering, fear, despair, pride, envy, disillusionment, success-that-feels-empty, etc.)
- For each archetype, a pre-mapped library of 5-15 scriptural anchors with school-attributed commentaries, vetted by a scholar
- A retrieval system that classifies the question into archetype first, then assembles multi-school response from the pre-vetted commentary corpus
- A scholar-in-the-loop review of every shipped response template
- A safety routing layer for crisis questions (suicidality, abuse, severe depression) that bypasses philosophy and surfaces real helplines

This is 3-4 months of focused work. Not v1.

### What we will not do (when we eventually build it)

- **Not naive RAG over "all the philosophy books."** That produces school-flattened answers that read profound on first query and fail on second. Aggregator-style retrieval is the wrong approach.
- **Not "ask any question."** The Q&A is bounded — the user picks from the archetype taxonomy or describes their situation, and the system maps to archetype, not to free-form generation.
- **Not single-perspective answers.** Where schools genuinely disagree (which is often), Sandhya names the disagreement; it does not synthesize away differences for false coherence.
- **Not crisis-blind.** Hard safety routing for suicidality, abuse, severe depression. The tradition is not a substitute for professional help.

### Pricing

Likely a higher tier — Sandhya Plus or Sandhya Sangha at ₹399-499/month including unlimited Q&A. Tested in beta. The Q&A becomes the upgrade story for users already on the daily product.

### Timeline

Architecture design: month 4. Corpus curation: months 4-6 with scholar. Beta: month 6-7. Public launch: month 7-8.

---

## 2. Bhakti poetry corpus

Mira, Kabir, Tulsidas, Surdas, Akka Mahadevi, Basavanna, Allama Prabhu, Lal Ded, Tukaram, Jnaneshwar, Eknath, Andal, Kanaka Dasa, Purandara Dasa.

Deferred because:
- Translation copyright complexity (most beautiful translations are under copyright — A.K. Ramanujan's *Speaking of Siva*, Hoskote's *I, Lalla*, Chitre's Tukaram, Jack Hawley's Sur Sagar)
- Quality matters lyrically here in a way it doesn't for prose stories — a bad translation of a Mira bhajan is offensive in a way a paraphrased Hitopadesha story is not
- Requires either licensing fees per book (₹5-10k/book typical) or commissioned fresh translations from a scholar (work-for-hire, clean IP)

Ships in v2 with proper licensing or commissioned translations. Adds enormous depth to the morning lesson and evening reflection slots.

---

## 3. Scholar reviewer on retainer

A part-time Sanatan scholar — retired or active Sanskrit/philosophy professor, or working pandit with academic background — at ₹15-20k/month for review-only work, ~5 hours/week.

Job: review and approve content batches before they ship. Flag errors, school-attribution mistakes, mistranslations, school-confusion. Not to produce content — to validate it.

Skipped in v1 because canonical public-domain sources are inherently scholar-vetted (the 19th and early 20th century academic translations we use). Added in v2 the moment we expand into Bhakti poetry, regional traditions, or Q&A — all places where my output is unreliable without review.

The single highest-leverage spend in the project budget after launch.

---

## 4. Regional language expansion

v1 ships in English, Hinglish, Hindi.

v2 adds:

- **Marathi** (large diaspora, strong devotional tradition)
- **Tamil** (large diaspora, distinct philosophical tradition — Saiva Siddhanta, Tamil Bhakti, Alvars and Nayanmars)
- **Bengali** (large urban audience, distinct Shakta and Vaishnava traditions)
- **Telugu** (large diaspora, Annamacharya / Tyagaraja tradition)
- **Kannada** (Lingayat / Vachana tradition, distinct philosophical heritage)
- **Gujarati** (large urban audience, distinct Vaishnava and Jain-influenced Sanatan)
- **Punjabi** (large diaspora, Sant tradition)
- **Malayalam** (large diaspora, distinct temple-tradition heritage)

Each language requires:
- Native writer in voice
- Regional cultural-content curation (Tamil Bhakti is not Hindi Bhakti translated)
- Calendar adaptation (regional festivals, Tamil/Telugu/Kannada/Bengali/Malayalam new years, regional auspicious days)

Cannot be done by translation alone. Months 6+ as separate launch tracks per language.

---

## 5. Family accounts and kundli matching

For committed couples and families:

- **Family account** at one bundled price covering 2-4 family members, each with their own chart and personalized readings
- **Kundli matching** for partners — done seriously, not as a marriage-market gate. Shows the gunas, named honestly, with the tradition's actual interpretation, not the panicked "doshas detected!" framing
- **Family ritual reminders** — anniversaries (in panchang dates, not Gregorian), parent's death-anniversaries (shraddha), shared festival observances

Months 6-8. Important for retention and for word-of-mouth — the user who pays for themselves recommends the family account to their spouse and parents.

---

## 6. Audio meditations and longer practices

v1 has ~40 short practices (under 5 minutes). v2 adds:

- 20-minute guided meditations in voice (Yoga-nidra style, but Sanatan-rooted)
- Mantra recitation tracks (10-minute, 20-minute, 108-bead japa cycles)
- Selected pravachan-style audio (Easwaran-register English, Premchand-register Hindi)
- Festival-specific extended practices (Maha Shivratri all-night structure, Navratri 9-day arc, Diwali sequence)

Production: needs a real voice artist, real audio engineer. Ships month 6+.

---

## 7. Festival deep-dives with regional variants

v1 acknowledges festivals in the daily reading. v2 builds dedicated festival surfaces:

- 7-day arc leading into major festivals with daily preparatory readings
- Regional variants displayed honestly (Diwali in Bengal vs. Maharashtra vs. North India is different — we show the version the user is closest to, with optional exposure to others)
- Festival-specific practices, recipes (yes, recipes — the tradition is embodied, food matters), historical and philosophical context

Months 4+ as we approach major festival seasons. Built incrementally festival by festival.

---

## 8. Native iOS / Android apps

v1 is web/PWA. v2 considers native if PWA signal warrants and the WhatsApp-first hypothesis proves out.

Native gives us:
- Better notification reliability than PWA
- Better offline support
- App Store / Play Store discovery
- Audio playback control (matters for the meditations track)

Native costs us:
- Real app development effort
- App Store review process
- Two more codebases to maintain

Decision in month 9 based on data. Not before.

---

## 9. Sangha — the careful community feature

A small-group community feature. Not a public feed.

If built, structured as:

- Small groups (5-15 people), formed around shared dasha period or shared life stage or shared sankalpa (vow)
- Members anonymous to each other within the group, identified by chosen name only
- No likes, no metrics, no upvotes
- Async-only — no live chat, no DMs
- Single posting prompt per day, tied to that day's reading or evening reflection
- Group dissolves after a defined period (40 days for sankalpa-groups, a year for dasha-companion groups)

This is the most dangerous v2 feature because community features become engagement-trap features the moment we start optimizing them. Built last, or not at all if we cannot hold the integrity line.

Decision deferred to month 12+.

---

## 10. The pandit feature *(the deliberate refusal that may eventually require revisiting)*

If after a year there is genuine, repeated, unprompted user demand for actual human pandit consultation — through Sandhya — we revisit.

Not because consultations are wrong (the tradition has always had teachers and the asking of questions is sacred). Because the *commercial structure* of consultation upsells in Indian astro-tech is what corrupts the products. If we can build a non-commercial-pressure version (fixed monthly fee for unlimited messaging with a real scholar, no per-minute pressure, scholar paid a flat retainer not per-call), it could be a real v3 feature.

Deliberate decision deferred to month 18+, only if the underlying integrity line can be held.

---

## 11. The standing rule

**Each item here is a commitment.** We are not deferring these because they are bad ideas — we are deferring because doing them right requires foundations that do not yet exist (scholar relationships, beta data, proven daily-product retention, brand trust earned over months).

Build v1. Earn the right to build v2 by shipping v1 well.

---

*Locked: end of foundation conversation, before code.*
*Owner: Founder + Claude.*
