part of 'ai_chat_bloc.dart';

abstract class AiChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessage extends AiChatEvent {
  final String message;
  SendMessage(this.message);
  
  @override
  List<Object> get props => [message];
}

class ClearChat extends AiChatEvent {}
