part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final UserProfileCalendarResponse? calendar;
  final DailyCodingChallengeResponse? dailyChallenges;
  // Hold the current displayed month
  final DateTime? currentMonth;

  CalendarLoaded({
    this.calendar,
    this.dailyChallenges,
    this.currentMonth,
  });

  @override
  List<Object?> get props => [calendar, dailyChallenges, currentMonth];
}

class CalendarError extends CalendarState {
  final String message;
  CalendarError(this.message);

  @override
  List<Object> get props => [message];
}
