import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_daily_challenge_usecase.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

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
    on<NextMonth>(_onNextMonth);
    on<PreviousMonth>(_onPreviousMonth);
  }

  Future<void> _onLoadCalendar(
      LoadCalendar event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      final now = DateTime.now();
      final year = event.year ?? now.year;
      final month = event.month ?? now.month;
      
      final currentMonthDate = DateTime(year, month);

      final results = await Future.wait([
        _fetchCalendarUseCase(event.username, year),
        _fetchDailyChallengeUseCase(year, month),
      ]);

      emit(CalendarLoaded(
        calendar: results[0] as UserProfileCalendarResponse?,
        dailyChallenges: results[1] as DailyCodingChallengeResponse?,
        currentMonth: currentMonthDate,
      ));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  Future<void> _onNextMonth(
      NextMonth event, Emitter<CalendarState> emit) async {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      final currentMonth = currentState.currentMonth ?? DateTime.now();
      final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      
      await _changeMonth(nextMonth, currentState, emit);
    }
  }

  Future<void> _onPreviousMonth(
      PreviousMonth event, Emitter<CalendarState> emit) async {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      final currentMonth = currentState.currentMonth ?? DateTime.now();
      final prevMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      
      await _changeMonth(prevMonth, currentState, emit);
    }
  }

  Future<void> _changeMonth(DateTime newMonth, CalendarLoaded currentState, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      // Fetch daily challenges for the new month
      final dailyChallenges = await _fetchDailyChallengeUseCase(newMonth.year, newMonth.month);
      
      // If year changed, we might want to fetch heatmap again, but for now assuming heatmap is already covering recent years
      // or we can just keep existing heatmap.

      emit(CalendarLoaded(
        calendar: currentState.calendar,
        dailyChallenges: dailyChallenges,
        currentMonth: newMonth,
      ));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }
}
