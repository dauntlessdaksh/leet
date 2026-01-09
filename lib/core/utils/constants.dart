class AppConstants {
  static const String baseUrl = 'https://leetcode.com/';
  static const String graphqlEndpoint = '${baseUrl}graphql';
  static const String referer = 'https://leetcode.com/';
  
  // Timeout
  static const int connectTimeout = 30000; // 30s
  static const int receiveTimeout = 30000; // 30s
  
  // Shared Preferences Keys
  static const String keyUsername = 'username';
}
