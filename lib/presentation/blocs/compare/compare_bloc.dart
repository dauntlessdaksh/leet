import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';

part 'compare_event.dart';
part 'compare_state.dart';

// Bloc
class CompareBloc extends Bloc<CompareEvent, CompareState> {
  final FetchUserStatsUseCase _fetchUserStatsUseCase;
  final FetchContestRatingUseCase _fetchContestRatingUseCase;
  final FetchCalendarUseCase _fetchCalendarUseCase;

  CompareBloc({
    required FetchUserStatsUseCase fetchUserStatsUseCase,
    required FetchContestRatingUseCase fetchContestRatingUseCase,
    required FetchCalendarUseCase fetchCalendarUseCase,
  })  : _fetchUserStatsUseCase = fetchUserStatsUseCase,
        _fetchContestRatingUseCase = fetchContestRatingUseCase,
        _fetchCalendarUseCase = fetchCalendarUseCase,
        super(CompareInitial()) {
    on<CompareUsers>(_onCompareUsers);
  }

  Future<void> _onCompareUsers(
      CompareUsers event, Emitter<CompareState> emit) async {
    emit(CompareLoading());
    try {
      final results = await Future.wait([
        _fetchUserStatsUseCase(event.username1),
        _fetchUserStatsUseCase(event.username2),
        _fetchContestRatingUseCase.getUserRanking(event.username1),
        _fetchContestRatingUseCase.getUserRanking(event.username2),
        _fetchCalendarUseCase(event.username1),
        _fetchCalendarUseCase(event.username2),
      ]);

      emit(CompareLoaded(
        user1Stats: results[0] as UserQuestionStatusData?,
        user2Stats: results[1] as UserQuestionStatusData?,
        user1Contest: results[2] as UserContestRankingResponse?,
        user2Contest: results[3] as UserContestRankingResponse?,
        user1Calendar: results[4] as UserProfileCalendarResponse?,
        user2Calendar: results[5] as UserProfileCalendarResponse?,
      ));
    } catch (e) {
      emit(CompareError(e.toString()));
    }
  }
}
