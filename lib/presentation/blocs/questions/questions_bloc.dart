import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/question_model.dart';
import 'package:leet/domain/usecases/fetch_questions_usecase.dart';
import 'package:leet/domain/usecases/search_questions_usecase.dart';

part 'questions_event.dart';
part 'questions_state.dart';

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
        limit: event.offset == 0 ? 1500 : 50, // Load 1500 initially, then 50 per page
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
    print('SearchQuestions event received: ${event.query}'); // DEBUG
    emit(QuestionsLoading());
    try {
      final response = await _searchQuestionsUseCase(keyword: event.query);
      print('Search response received. Count: ${response.data.problemsetQuestionListV2.questions.length}'); // DEBUG
      emit(SearchQuestionsLoaded(
        questions: response.data.problemsetQuestionListV2.questions,
        totalCount: response.data.problemsetQuestionListV2.totalLength,
      ));
    } catch (e) {
      print('Search error: $e'); // DEBUG
      emit(QuestionsError(e.toString()));
    }
  }
}
