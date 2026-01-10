part of 'question_details_bloc.dart';

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
