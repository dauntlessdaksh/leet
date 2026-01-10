import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyCbtmCV4RBgTxhs6P5EqlyoqD6iPnsucCw';
  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.9,
        maxOutputTokens: 1024,
      ),
    );
  }

  Future<String> sendMessage(String message, {List<String>? conversationHistory}) async {
    try {
      final prompt = _buildPrompt(message, conversationHistory);
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      return response.text ?? 'Sorry, I could not generate a response.';
    } catch (e) {
      throw Exception('Failed to get AI response: $e');
    }
  }

  String _buildPrompt(String message, List<String>? history) {
    final systemPrompt = '''You are a helpful LeetCode coding assistant. Your role is to:
- Help users understand coding problems and algorithms
- Provide hints without giving away complete solutions
- Explain code and algorithms clearly
- Suggest optimizations and best practices
- Answer questions about data structures and algorithms

Keep responses concise and code-focused. Use markdown for code blocks.
''';

    if (history != null && history.isNotEmpty) {
      return '$systemPrompt\n\nConversation history:\n${history.join('\n')}\n\nUser: $message\nAssistant:';
    }
    
    return '$systemPrompt\n\nUser: $message\nAssistant:';
  }

  Stream<String> sendMessageStream(String message) async* {
    try {
      final content = [Content.text(message)];
      final response = _model.generateContentStream(content);
      
      await for (final chunk in response) {
        if (chunk.text != null) {
          yield chunk.text!;
        }
      }
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
