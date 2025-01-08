class ApiConstants {
  // Base URL for the IGDB API
  static const String baseUrl = "https://api.igdb.com/v4/";
  static const String imageBaseUrl = "https://images.igdb.com";

  // Endpoints
  static const String gamesEndpoint = "games";

  // Authentication
  static const String clientId = "9b0zpg1fsbrvhqs36tktonpdx07utw";
  static const String bearerToken = "xkm6k14e8s3v64kv8uz9bu61yjlk1h";

  // Common Queries
  static const String fields = "fields id, name, cover.url, summary, rating;";
  static const int defaultLimit = 20;
}
