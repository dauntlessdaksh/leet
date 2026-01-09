import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_daily_challenge_usecase.dart';

// Events
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

// States
abstract class CalendarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final UserProfileCalendarResponse? calendar;
  final DailyCodingChallengeResponse? dailyChallenges;
  final int? selectedYear;

  CalendarLoaded({
    this.calendar,
    this.dailyChallenges,
    this.selectedYear,
  });

  @override
  List<Object?> get props => [calendar, dailyChallenges, selectedYear];
}

class CalendarError extends CalendarState {
  final String message;
  CalendarError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final FetchCalendarUseCase _fetchCalendarUseCase;
  final FetchDailyChallengeUseCase _fetchDailyChallengeUseCase;

  CalendarBloc({
    required FetchCalendarUseCase fetchCalendarUseCase,
    required FetchDailyChallengeUseCase fetchDailyChallengeUseCase,
  })  : _fetchCalendarUseCase = fetchCalendarUseCase,
        _fetchDailyChallengeUseCase = fetchDailyChallengeUseCase,
        super(CalendarInitial()) {
    on<LoadCalendar>(_onLoadCalendar);
  }

  Future<void> _onLoadCalendar(
      LoadCalendar event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      final now = DateTime.now();
      final year = event.year ?? now.year;
      final month = event.month ?? now.month;

      final results = await Future.wait([
        _fetchCalendarUseCase(event.username, year),
        _fetchDailyChallengeUseCase(year, month),
      ]);

      emit(CalendarLoaded(
        calendar: results[0] as UserProfileCalendarResponse?,
        dailyChallenges: results[1] as DailyCodingChallengeResponse?,
        selectedYear: year,
      ));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }
}
