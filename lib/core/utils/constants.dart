class AppConstants {
  static const String baseUrl = 'https://leetcode.com/';
  static const String graphqlEndpoint = '${baseUrl}graphql';
  static const String referer = 'https://leetcode.com/';
  
  // Alfa LeetCode API
  static const String alfaApiBaseUrl = 'https://alfa-leetcode-api.onrender.com';
  static const String alfaContestsEndpoint = '$alfaApiBaseUrl/contests';
  static const String alfaUpcomingContestsEndpoint = '$alfaApiBaseUrl/contests/upcoming';
  
  // Timeout
  static const int connectTimeout = 30000; // 30s
  static const int receiveTimeout = 30000; // 30s
  
  // Shared Preferences Keys
  static const String keyUsername = 'username';
}
