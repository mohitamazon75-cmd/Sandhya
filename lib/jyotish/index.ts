/**
 * Sandhya jyotish engine.
 *
 * This module will be populated in session 2 by porting the following
 * files from the existing RajYog / cosmic-karma-decoder repo:
 *
 *   - astro-constants.ts  (rashi maps, sign lords, exaltations, nakshatras)
 *   - sweph.ts            (Swiss Ephemeris WASM with integrity check, ascendant)
 *   - vedic-engine.ts     (vargas, charakarakas, Vimshottari dasha)
 *   - chart-parser.ts     (chart assembly)
 *
 * Source: https://github.com/<founder>/cosmic-karma-decoder
 *
 * Verification: every ported function gets a Vitest invariant test that asserts
 * its output matches the existing engine's output to 4 decimal places against
 * a fixed set of test charts (see tests/jyotish/fixtures.ts).
 *
 * Do NOT regenerate this engine from training. It is mathematically validated
 * against classical Vedic astronomy and any drift will silently corrupt
 * downstream readings.
 */

export const JYOTISH_ENGINE_VERSION = "0.0.0-pre-port";
