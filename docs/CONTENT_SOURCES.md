# CONTENT_SOURCES.md

**The canonical public-domain sources we draw from for v1 content.**

Every piece of content shipped in Sandhya v1 traces to a source in this list. Aggregator websites are off-limits as primary sources (see V1_SCOPE §6). Discovery via aggregators is fine; shipped text always comes from canonical translations below.

---

## 1. Operating principle

**The source link goes in the database.** Every story, every principle, every shloka stored in our content corpus has a `source_url` field pointing to the canonical text we drafted from. This is for:

- Verification (founder review pass)
- Future scholar review (v2)
- Defending against accuracy challenges if they arise post-launch
- Building a corrigenda pipeline if errors are found

When I (Claude) draft content, I retrieve from these sources via web_fetch first, then compose against the retrieved text. I do not work from memory.

---

## 2. The Itihasa (Mahabharata + Ramayana)

### Mahabharata
- **Primary source:** Kisari Mohan Ganguli's complete English translation, 1883-1896
- **URL:** https://www.sacred-texts.com/hin/maha/
- **License:** Public domain (US and India)
- **Coverage:** Complete — all 18 parvas, ~5,800 pages
- **Use for:** Stories from Adi Parva (origin tales), Sabha Parva (the dice game, Draupadi's humiliation), Vana Parva (forest exile tales, Yaksha-Yudhishthira dialogue), Udyoga Parva (peace embassies), Bhishma Parva (Gita), Karna Parva, Shanti Parva (Bhishma's instruction to Yudhishthira on dharma — gold mine), Anushasana Parva
- **Notes:** Ganguli translation is occasionally Victorian-flowery; we re-render in voice. The substance is reliable.

### Ramayana (Valmiki)
- **Primary source 1:** Manmatha Nath Dutt prose translation, 1892-94
- **URL:** https://archive.org/details/RamayanaOfValmikiVolI/
- **License:** Public domain
- **Primary source 2:** Ralph T.H. Griffith verse translation, 1870-74
- **URL:** https://www.sacred-texts.com/hin/rama/index.htm
- **License:** Public domain
- **Coverage:** Complete (both translations cover all seven kandas)
- **Use for:** Stories from Bala Kanda (Rama's youth), Ayodhya Kanda (the exile decision, Bharata's renunciation), Aranya Kanda (forest tales, Sita's abduction), Sundara Kanda (Hanuman's leap, the most-recited section in devotional contexts), Yuddha Kanda, Uttara Kanda

---

## 3. The Puranas

### Bhagavata Purana (Srimad Bhagavatam)
- **Primary source 1:** J.M. Sanyal translation, early 20th century
- **URL:** https://archive.org/details/SrimadBhagavatamSanyalVol1
- **License:** Public domain (older editions)
- **Primary source 2:** Bibek Debroy's Penguin translation
- **License:** *Copyrighted — do not ship from this source.* Use for cross-reference only.
- **Coverage:** Sanyal covers all 12 cantos but is occasionally archaic
- **Use for:** Krishna's childhood and Brindavan stories (Canto 10, the most loved section), Prahlada's devotion (Canto 7), Dhruva's tapasya (Canto 4), the Avatara stories (Canto 1-3), Markandeya's vision (Canto 12), Uddhava Gita (Canto 11)

### Vishnu Purana
- **Primary source:** H.H. Wilson translation, 1840
- **URL:** https://www.sacred-texts.com/hin/vp/
- **License:** Public domain
- **Use for:** Cosmological framings, Dhruva story (alternate version), Prahlada (alternate), Vamana avatar

### Shiva Purana
- **Primary source:** J.L. Shastri translation (Motilal Banarsidass, mid-20th century — *check copyright status before ship*)
- **Alternative:** Older partial translations on archive.org
- **Use for:** Shiva mythology, Daksha-Sati story, Markandeya-Yama (the Mahamrityunjaya origin), Nataraja stories
- **Note:** Stricter copyright environment — verify each excerpt before drafting

### Devi Bhagavatam / Markandeya Purana (for Devi Mahatmya)
- **Primary source:** F. Eden Pargiter, *The Markandeya Purana*, 1904
- **URL:** https://archive.org/details/markandeyapurana00pargrich
- **License:** Public domain
- **Use for:** Devi Mahatmya stories (Durga slaying Mahishasura, Kali's emergence, Saraswati legends)

### Other Puranas (Skanda, Padma, Garuda, Brahmanda)
- **Source:** Sacred-texts.com and archive.org public-domain editions
- **Use sparingly** — these are larger, less consistent in quality. Pull specific stories as needed.

---

## 4. The Niti / Story collections

### Hitopadesha
- **Primary source:** Charles Wilkins translation, 1787
- **URL:** Available on Project Gutenberg + archive.org
- **License:** Public domain
- **Backup source:** Edwin Arnold, *The Book of Good Counsels*, 1861
- **URL:** https://archive.org/details/bookofgoodcounse00arnoiala
- **Use for:** Animal-fable wisdom stories. Five-minute reads. Great for the morning lesson slot.

### Panchatantra
- **Primary source:** Arthur W. Ryder translation, 1925
- **URL:** https://archive.org/details/panchatantra00ryde
- **License:** Public domain (US)
- **Backup source:** Stanley Rice retelling (older)
- **Use for:** Same as Hitopadesha — fable-form wisdom, easy to render in 90-second story slot

### Jataka tales (Buddhist Sanatan-adjacent — used carefully)
- **Primary source:** E.B. Cowell (ed.), *The Jataka, or Stories of the Buddha's Former Births*, 6 volumes, 1895-1907
- **URL:** https://www.sacred-texts.com/bud/j1/
- **License:** Public domain
- **Use for:** Stories that embody dharmic principles; the Sanatan and Buddhist story-traditions overlap heavily in this corpus
- **Frame carefully:** When we use a Jataka tale, we attribute it as Buddhist-Indian heritage, not Hindu-Sanatan. The reader benefits from the breadth. We do not pretend it is something it is not.

---

## 5. The Yoga-Vedanta classical canon

### Bhagavad Gita
- **Primary source 1 (English):** Edwin Arnold, *The Song Celestial*, 1885 — verse, beautiful
- **URL:** https://www.sacred-texts.com/hin/gita/
- **License:** Public domain
- **Primary source 2 (English):** Annie Besant translation
- **URL:** https://archive.org/details/bhagavadgitaorlo00besarich
- **License:** Public domain
- **Sanskrit text:** Sacred-texts.com Devanagari version
- **Commentaries (public domain):**
  - **Adi Shankara's Gita Bhashya:** A.M. Sastri translation
  - **URL:** https://archive.org/details/bhagavadgitawith00shanuoft
  - **Ramanuja's Gita Bhashya:** A. Govindacharya translation
  - **Tilak's Gita Rahasya:** Bhalchandra Sitaram Sukthankar translation, 1935
- **Use for:** Daily principle slot. The Gita is the most-quoted text in the world for a reason. We will rotate through commentaries to show multi-school plurality (Shankara's Advaita reading vs. Ramanuja's Vishishtadvaita reading vs. Tilak's karma-yoga emphasis vs. Easwaran's contemporary devotional).

### Yoga Sutras of Patanjali
- **Primary source 1:** James Haughton Woods translation, 1914
- **URL:** https://archive.org/details/yogasystemofpata00wooduoft
- **License:** Public domain
- **Primary source 2:** Charles Johnston translation, 1912
- **URL:** https://www.sacred-texts.com/hin/ysp/
- **License:** Public domain
- **Vyasa Bhashya (commentary):** Available in Woods edition
- **Use for:** Principle slot — the Yoga Sutras handle psychological precision (chitta-vritti, samskaras, kleshas) more rigorously than the Gita

### Principal Upanishads
- **Primary source 1:** Max Müller, *Sacred Books of the East* Vol 1 and 15, 1879-1884
- **URL:** https://www.sacred-texts.com/hin/upan/
- **License:** Public domain
- **Primary source 2:** Robert Ernest Hume, *The Thirteen Principal Upanishads*, 1921
- **URL:** https://archive.org/details/thirteenprincipa028442mbp
- **License:** Public domain
- **Coverage:** Isha, Kena, Katha, Prashna, Mundaka, Mandukya, Aitareya, Taittiriya, Brihadaranyaka, Chandogya, Shvetashvatara, Kaushitaki, Maitri
- **Use for:** Principle slot — the Upanishads are the mystical heart of the tradition. Katha (Nachiketa-Yama dialogue) is especially rich for stories.

### Yoga Vasistha
- **Primary source:** Vihari Lala Mitra translation, 1891-99
- **URL:** https://archive.org/details/yogavasishthamah00mitr
- **License:** Public domain
- **Use for:** Both story slot and principle slot — the Yoga Vasistha is unique in interweaving narrative and philosophy. The Story of Lavana, the Hundred Rudras, Queen Chudala — all gold for the morning lesson slot.

### Ashtavakra Gita
- **Primary source:** John Richards translation
- **URL:** https://www.sacred-texts.com/hin/avg/
- **License:** Public domain
- **Use for:** Principle slot — the most uncompromising Advaita text, useful for "no-frills jnana" days

---

## 6. Tantra and Shakta sources (used carefully, smaller share in v1)

### Devi Mahatmya / Saptashati
- **Primary source:** Frederick Eden Pargiter (in Markandeya Purana, see §3)
- **License:** Public domain
- **Use for:** Devi-emphasis days, Navratri readings, Shakta principle slot

### Soundarya Lahari (attributed to Adi Shankara)
- **Primary source:** Public-domain editions on archive.org
- **Use for:** Bhakti-Shakta crossover, principle slot — the most beautiful short Devi text in classical Sanskrit

### Vijnana Bhairava Tantra
- **Primary source:** Older public-domain partial translations; modern complete translations (Dyczkowski, Singh) are *under copyright*
- **Use sparingly in v1** — limited to verses available in public domain editions. Full coverage waits for v2 with proper licensing.

---

## 7. Bhakti and regional poetry — *deferred to v2*

The following sources are *important* but ship in v2 with proper licensing or commissioned translations. Listed here so we have the working list ready when v2 corpus work begins:

- Mira (translations: Andrew Schelling, A.J. Alston, Robert Bly + Jane Hirshfield — all under copyright)
- Kabir (translations: Tagore — public domain — and modern Bly, Hess + Singh, Linda Hess — modern copyrighted)
- Tulsidas Ramcharitmanas (translations: F.S. Growse 1877 — public domain — and modern R.C. Prasad, A.G. Atkins — copyrighted)
- Surdas (translations: K.N. Bhatnagar, John Stratton Hawley — copyrighted)
- Akka Mahadevi vachanas (A.K. Ramanujan's *Speaking of Siva* — Penguin, copyrighted)
- Lal Ded vakhs (Sir George Grierson 1920 — public domain — and Ranjit Hoskote *I, Lalla* — HarperCollins, copyrighted)
- Tukaram abhangs (Dilip Chitre *Says Tuka* — copyrighted; older translations partial in public domain)
- Jnaneshwar (older translations partial in public domain)
- Andal Tiruppavai and Nachiyar Tirumozhi (older Tamil translations, public domain partial)
- Annamacharya (modern translations under copyright)

For v2, decision tree:
1. Use older public-domain translations where lyrically acceptable
2. License modern translations where the lyrical quality matters more (Hoskote's Lal Ded, Ramanujan's vachanas)
3. Commission fresh translations from scholar-on-retainer for things we want owned cleanly

---

## 8. Sanskrit shloka sources

For mantras, shlokas, and scriptural verses quoted in readings:

### Devanagari source-of-truth
- **GRETIL** (Göttingen Register of Electronic Texts in Indian Languages): http://gretil.sub.uni-goettingen.de/
- **License:** Free for non-commercial scholarly use; review per-text licensing for commercial deployment
- **Coverage:** Most major Sanskrit texts in critical editions

### Mantra collections
- **Mantra Pushpam** (Ramakrishna Math editions, older volumes public domain)
- **Brihat Stotra Ratnakara** (older public-domain editions)
- **Sacred-texts.com mantra section:** https://www.sacred-texts.com/hin/

### Mantra audio
- **Production approach for v1:** Record fresh audio with a trained Sanskrit reciter. ₹500-1000 per mantra recording, hire a Vedic scholar/priest for a 2-day session to record the ~30 v1 mantras
- **Pronunciation reference:** Established recitations from Sringeri Math, Kanchi Math, Ramakrishna Math (educational reference, not for direct use)

---

## 9. Festival and panchang reference

### Panchang computation
- **Source:** Our own engine (ported Swiss Ephemeris) — not a third-party panchang source
- **Validation reference:** Drik Panchang (drikpanchang.com) — for cross-checking our computations
- **Classical reference:** Surya Siddhanta, Burgess translation, 1860, public domain

### Festival database
- **Primary source:** Hindu Festivals reference compendia in the public domain
- **Cross-reference:** State government tourism + cultural ministry sources for regional variants (Tamil Nadu HR&CE, Kerala tourism, Maharashtra Tourism, Bengal Tourism, etc.)
- **Build approach:** Hand-curated festival database, ~100 festivals with classical references, regional variants, and panchang dates computed by our engine

---

## 10. Drafting workflow

For every piece of v1 content:

1. **Discovery:** Identify the story / principle / shloka we want — via aggregator-site browsing or memory or recommendation, but treated as a *pointer*, not a source
2. **Retrieve canonical text:** Use web_fetch to pull the actual passage from the canonical source above
3. **Extract verbatim:** Save the canonical text to the content database as `source_text`, with `source_url` and `source_translator` and `license_status`
4. **Voice render:** Compose the Sandhya-voice version against the canonical text. Save as `rendered_text`.
5. **Founder review:** Founder reads the rendered version against the source text. Approves, edits, or rejects.
6. **Ship:** Approved content goes into the live corpus with full source metadata.

The workflow is slower than scrape-and-paste. It is also the workflow that protects us when someone challenges accuracy — *we have the source link, we have the original passage, we can defend any rendering choice.*

---

## 11. License posture summary

| Source category | License | Action |
|---|---|---|
| 19th-century English translations (Ganguli, Müller, Wilson, Cowell, Wilkins, Griffith, Dutt, Arnold, Besant) | Public domain | Use freely, attribute |
| Early 20th-century scholarly translations (Hume, Ryder, Woods, Sastri, Mitra, Pargiter) | Public domain | Use freely, attribute |
| Modern Penguin / Oxford / HarperCollins translations | Copyrighted | Do not ship; cross-reference only |
| Motilal Banarsidass mid-20th century editions | Mixed — verify per book | Verify before ship; substitute older edition where copyrighted |
| GRETIL Sanskrit critical editions | Scholarly free | Verify commercial-use clause per text |
| Modern Bhakti translations (deferred to v2) | Copyrighted | License or commission fresh translation |

---

## 12. The standing rule

**No shipped text without a canonical source.** Every story, every principle, every shloka in the live corpus has its `source_url` populated. If a piece of content arrives in the corpus without a verifiable source, it does not ship. This is the rule that prevents the "ship and don't get caught" failure mode.

When in doubt, slower. When still in doubt, drop the piece and pick a different one.

---

*Locked: end of foundation conversation, before code.*
*Owner: Founder + Claude.*
