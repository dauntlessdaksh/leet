part of 'ai_chat_bloc.dart';

abstract class AiChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitial extends AiChatState {}

class ChatLoading extends AiChatState {
  final List<ChatMessage> messages;
  ChatLoading(this.messages);
  
  @override
  List<Object> get props => [messages];
}

class ChatLoaded extends AiChatState {
  final List<ChatMessage> messages;
  ChatLoaded(this.messages);
  
  @override
  List<Object> get props => [messages];
}

class ChatError extends AiChatState {
  final String message;
  final List<ChatMessage> messages;
  
  ChatError(this.message, this.messages);
  
  @override
  List<Object> get props => [message, messages];
}
