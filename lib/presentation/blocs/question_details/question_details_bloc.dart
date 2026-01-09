import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

// Events
abstract class QuestionDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuestionDetails extends QuestionDetailsEvent {
  final String titleSlug;
  LoadQuestionDetails(this.titleSlug);
  
  @override
  List<Object> get props => [titleSlug];
}

// States
abstract class QuestionDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionDetailsInitial extends QuestionDetailsState {}

class QuestionDetailsLoading extends QuestionDetailsState {}

class QuestionDetailsLoaded extends QuestionDetailsState {
  final String content; // HTML content
  
  QuestionDetailsLoaded(this.content);
  
  @override
  List<Object> get props => [content];
}

class QuestionDetailsError extends QuestionDetailsState {
  final String message;
  QuestionDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

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
