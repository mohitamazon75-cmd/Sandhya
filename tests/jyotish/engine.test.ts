import { describe, it, expect } from "vitest";
import { JYOTISH_ENGINE_VERSION } from "@/lib/jyotish";
import { fixtures } from "./fixtures";

describe("jyotish engine — pre-port sanity", () => {
  it("module is importable", () => {
    expect(JYOTISH_ENGINE_VERSION).toBe("0.0.0-pre-port");
  });

  it("fixture corpus has at least the founder chart", () => {
    const founderFixture = fixtures.find((f) => f.id === "founder-mohit");
    expect(founderFixture).toBeDefined();
    expect(founderFixture?.input.locationName).toContain("Ajmer");
  });

  it.todo("ascendant matches RajYog output for founder chart");
  it.todo("planetary longitudes match RajYog output to 4 decimal places");
  it.todo("Vimshottari mahadasha lord matches RajYog output");
  it.todo("D9 (navamsa) sign of moon matches RajYog output");
});
