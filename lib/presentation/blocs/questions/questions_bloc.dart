import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/question_model.dart';
import 'package:leet/domain/usecases/fetch_questions_usecase.dart';
import 'package:leet/domain/usecases/search_questions_usecase.dart';

// Events
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

// States
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

// Bloc
class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final FetchQuestionsUseCase _fetchQuestionsUseCase;
  final SearchQuestionsUseCase _searchQuestionsUseCase;

  QuestionsBloc({
    required FetchQuestionsUseCase fetchQuestionsUseCase,
    required SearchQuestionsUseCase searchQuestionsUseCase,
  })  : _fetchQuestionsUseCase = fetchQuestionsUseCase,
        _searchQuestionsUseCase = searchQuestionsUseCase,
        super(QuestionsInitial()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<SearchQuestions>(_onSearchQuestions);
  }

  Future<void> _onLoadQuestions(
      LoadQuestions event, Emitter<QuestionsState> emit) async {
    if (event.offset == 0) {
      emit(QuestionsLoading());
    }
    
    try {
      final response = await _fetchQuestionsUseCase(
        skip: event.offset,
        difficulty: event.difficulty,
        status: event.status,
        tags: event.tags,
        query: event.searchQuery,
      );

      final currentQuestions = (state is QuestionsLoaded && event.offset > 0)
          ? (state as QuestionsLoaded).questions
          : <Question>[];

      emit(QuestionsLoaded(
        questions: currentQuestions + response.data.problemsetQuestionList.questions,
        totalCount: response.data.problemsetQuestionList.total,
        hasMore: (currentQuestions.length + response.data.problemsetQuestionList.questions.length) < response.data.problemsetQuestionList.total,
      ));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  Future<void> _onSearchQuestions(
      SearchQuestions event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    try {
      final response = await _searchQuestionsUseCase(keyword: event.query);
      emit(SearchQuestionsLoaded(
        questions: response.data.problemsetQuestionListV2.questions,
        totalCount: response.data.problemsetQuestionListV2.totalLength,
      ));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }
}
