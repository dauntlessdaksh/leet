part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCalendar extends CalendarEvent {
  final String username;
  final int? year;
  final int? month; // For daily challenges

  LoadCalendar({
    required this.username,
    this.year,
    this.month,
  });
  
  @override
  List<Object?> get props => [username, year, month];
}

class NextMonth extends CalendarEvent {}

class PreviousMonth extends CalendarEvent {}
