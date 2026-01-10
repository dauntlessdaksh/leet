part of 'question_details_bloc.dart';

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
