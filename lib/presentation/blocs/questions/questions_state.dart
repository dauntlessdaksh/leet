part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;
  final int totalCount;
  final bool hasMore;

  QuestionsLoaded({
    required this.questions,
    required this.totalCount,
    required this.hasMore,
  });

  @override
  List<Object> get props => [questions, totalCount, hasMore];
}

class SearchQuestionsLoaded extends QuestionsState {
  final List<SearchQuestionNode> questions;
  final int totalCount;

  SearchQuestionsLoaded({
    required this.questions,
    required this.totalCount,
  });

  @override
  List<Object> get props => [questions, totalCount];
}

class QuestionsError extends QuestionsState {
  final String message;
  QuestionsError(this.message);

  @override
  List<Object> get props => [message];
}
