part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadQuestions extends QuestionsEvent {
  final int offset;
  final String? difficulty;
  final String? status;
  final List<String>? tags;
  final String? searchQuery;

  LoadQuestions({
    this.offset = 0,
    this.difficulty,
    this.status,
    this.tags,
    this.searchQuery,
  });
  
  @override
  List<Object?> get props => [offset, difficulty, status, tags, searchQuery];
}

class SearchQuestions extends QuestionsEvent {
  final String query;
  SearchQuestions(this.query);

  @override
  List<Object> get props => [query];
}
