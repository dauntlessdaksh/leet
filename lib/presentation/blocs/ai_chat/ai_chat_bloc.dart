import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/chat_message_model.dart';
import 'package:leet/data/services/gemini_service.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

// BLoC
class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  final GeminiService _geminiService;
  final List<ChatMessage> _messages = [];

  AiChatBloc({required GeminiService geminiService})
      : _geminiService = geminiService,
        super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<ClearChat>(_onClearChat);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<AiChatState> emit) async {
    // Add user message
    final userMessage = ChatMessage(content: event.message, isUser: true);
    _messages.add(userMessage);
    
    emit(ChatLoading(List.from(_messages)));
    
    try {
      // Get conversation history for context
      final history = _messages
          .map((m) => '${m.isUser ? "User" : "Assistant"}: ${m.content}')
          .toList();
      
      // Get AI response
      final response = await _geminiService.sendMessage(
        event.message,
        conversationHistory: history.length > 10 ? history.sublist(history.length - 10) : history,
      );
      
      // Add AI message
      final aiMessage = ChatMessage(content: response, isUser: false);
      _messages.add(aiMessage);
      
      emit(ChatLoaded(List.from(_messages)));
    } catch (e) {
      emit(ChatError(e.toString(), List.from(_messages)));
      // Revert to loaded state after showing error
      await Future.delayed(const Duration(seconds: 2));
      emit(ChatLoaded(List.from(_messages)));
    }
  }

  void _onClearChat(ClearChat event, Emitter<AiChatState> emit) {
    _messages.clear();
    emit(ChatInitial());
  }
}
