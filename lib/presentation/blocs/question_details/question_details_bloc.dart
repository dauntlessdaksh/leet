import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

part 'question_details_event.dart';
part 'question_details_state.dart';

// Bloc
class QuestionDetailsBloc extends Bloc<QuestionDetailsEvent, QuestionDetailsState> {
  final LeetCodeRepository _repository;

  QuestionDetailsBloc(this._repository) : super(QuestionDetailsInitial()) {
    on<LoadQuestionDetails>(_onLoadQuestionDetails);
  }

  Future<void> _onLoadQuestionDetails(
      LoadQuestionDetails event, Emitter<QuestionDetailsState> emit) async {
    emit(QuestionDetailsLoading());
    try {
      final content = await _repository.fetchQuestionDetails(event.titleSlug);
      emit(QuestionDetailsLoaded(content));
    } catch (e) {
      emit(QuestionDetailsError(e.toString()));
    }
  }
}
