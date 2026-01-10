part of 'compare_bloc.dart';

abstract class CompareState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompareInitial extends CompareState {}

class CompareLoading extends CompareState {}

class CompareLoaded extends CompareState {
  final UserQuestionStatusData? user1Stats;
  final UserQuestionStatusData? user2Stats;
  final UserContestRankingResponse? user1Contest;
  final UserContestRankingResponse? user2Contest;
  final UserProfileCalendarResponse? user1Calendar;
  final UserProfileCalendarResponse? user2Calendar;

  CompareLoaded({
    this.user1Stats,
    this.user2Stats,
    this.user1Contest,
    this.user2Contest,
    this.user1Calendar,
    this.user2Calendar,
  });

  @override
  List<Object?> get props => [
        user1Stats,
        user2Stats,
        user1Contest,
        user2Contest,
        user1Calendar,
        user2Calendar,
      ];
}

class CompareError extends CompareState {
  final String message;
  CompareError(this.message);

  @override
  List<Object> get props => [message];
}
