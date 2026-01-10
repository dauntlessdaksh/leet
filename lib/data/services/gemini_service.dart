import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeminiService {
  static const String _backendUrlKey = 'backend_url';
  static const String _defaultBackendUrl = 'https://leet-backend-xqth.onrender.com';
  
  late final Dio _dio;
  String _backendUrl = _defaultBackendUrl;

  GeminiService() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrl = prefs.getString(_backendUrlKey);
    _backendUrl = savedUrl ?? _defaultBackendUrl;
    
    // Save the default URL if nothing is saved yet
    if (savedUrl == null) {
      await prefs.setString(_backendUrlKey, _defaultBackendUrl);
    }
  }

  static Future<void> saveBackendUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_backendUrlKey, url);
  }
  
  static Future<String?> getBackendUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_backendUrlKey);
  }

  Future<String> sendMessage(String message, {List<String>? conversationHistory}) async {
    try {
      final response = await _dio.post(
        '$_backendUrl/api/chat',
        data: {
          'message': message,
          'history': conversationHistory,
        },
      );

      if (response.statusCode == 200 && response.data['response'] != null) {
        return response.data['response'];
      } else {
        throw Exception('Invalid response from server');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please check your backend server.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Cannot connect to backend server. Make sure it\'s running at $_backendUrl');
      } else if (e.response?.statusCode == 500) {
        throw Exception('Server error. Please check your backend logs.');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get AI response: $e');
    }
  }

  Stream<String> sendMessageStream(String message) async* {
    try {
      final response = await sendMessage(message);
      yield response;
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
