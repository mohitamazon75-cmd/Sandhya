/**
 * Test fixtures for jyotish engine port verification.
 *
 * Each fixture is a (birth input, expected output) pair. Expected outputs come
 * from running the input through the existing RajYog engine BEFORE the port,
 * and recording the values here. After the port, the new engine must produce
 * the same outputs to within tolerance.
 *
 * Tolerance: 4 decimal places on planetary longitudes; exact match on rashi,
 * nakshatra, pada, and dasha lord identities.
 *
 * Add more fixtures as we expand the test corpus. Mohit's chart is the
 * primary fixture because it's our ground truth for development.
 */

export interface BirthFixture {
  id: string;
  description: string;
  input: {
    name?: string;
    birthDateTime: string; // ISO-8601, IST or UTC explicit
    latitude: number;
    longitude: number;
    timezone: string; // IANA tz name
    locationName: string;
  };
  // Expected values to be filled in when we run the existing engine.
  // Leave as null until verified against RajYog output.
  expected: {
    ascendant: {
      sign: string | null;
      degreeInSign: number | null;
    };
    sun: { sign: string | null; nakshatra: string | null };
    moon: { sign: string | null; nakshatra: string | null; pada: number | null };
    currentMahadashaLord: string | null;
  };
}

export const fixtures: BirthFixture[] = [
  {
    id: "founder-mohit",
    description: "Founder chart — primary verification fixture.",
    input: {
      name: "Mohit Mathur",
      birthDateTime: "1975-08-23T16:16:00+05:30",
      latitude: 26.4499,
      longitude: 74.6399,
      timezone: "Asia/Kolkata",
      locationName: "Ajmer, Rajasthan, India",
    },
    expected: {
      ascendant: { sign: null, degreeInSign: null },
      sun: { sign: null, nakshatra: null },
      moon: { sign: null, nakshatra: null, pada: null },
      currentMahadashaLord: null,
    },
  },
];
