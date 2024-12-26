const { searchTracks, getAuthURL } = require("../spotify/auth");
const request = require("supertest");
const app = require("../app");

describe("Spotify API Integration", () => {
  // Test Search Functionality
  describe("Search Feature", () => {
    test("searchTracks returns formatted results", async () => {
      const response = await searchTracks("beethoven symphony");
      expect(response).toHaveProperty("tracks");
      expect(response.tracks[0]).toHaveProperty("name");
      expect(response.tracks[0]).toHaveProperty("artist");
    });

    test("Search endpoint returns 200", async () => {
      const response = await request(app).get("/api/spotify/search").query({ q: "beethoven symphony" });
      expect(response.status).toBe(200);
      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  // Test Authentication
  describe("Authentication", () => {
    test("getAuthURL returns valid Spotify URL", () => {
      const url = getAuthURL();
      expect(url).toContain("accounts.spotify.com/authorize");
      expect(url).toContain("client_id");
      expect(url).toContain("redirect_uri");
    });
  });
});
