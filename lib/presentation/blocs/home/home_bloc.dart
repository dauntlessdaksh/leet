import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/badges_model.dart';
import 'package:leet/data/models/submission_model.dart';
import 'package:leet/domain/usecases/fetch_user_profile_usecase.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_badges_usecase.dart';
import 'package:leet/domain/usecases/fetch_recent_submissions_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchUserProfileUseCase _fetchUserProfileUseCase;
  final FetchUserStatsUseCase _fetchUserStatsUseCase;
  final FetchCalendarUseCase _fetchCalendarUseCase;
  final FetchContestRatingUseCase _fetchContestRatingUseCase;
  final FetchBadgesUseCase _fetchBadgesUseCase;
  final FetchRecentSubmissionsUseCase _fetchRecentSubmissionsUseCase;

  HomeBloc({
    required FetchUserProfileUseCase fetchUserProfileUseCase,
    required FetchUserStatsUseCase fetchUserStatsUseCase,
    required FetchCalendarUseCase fetchCalendarUseCase,
    required FetchContestRatingUseCase fetchContestRatingUseCase,
    required FetchBadgesUseCase fetchBadgesUseCase,
    required FetchRecentSubmissionsUseCase fetchRecentSubmissionsUseCase,
  })  : _fetchUserProfileUseCase = fetchUserProfileUseCase,
        _fetchUserStatsUseCase = fetchUserStatsUseCase,
        _fetchCalendarUseCase = fetchCalendarUseCase,
        _fetchContestRatingUseCase = fetchContestRatingUseCase,
        _fetchBadgesUseCase = fetchBadgesUseCase,
        _fetchRecentSubmissionsUseCase = fetchRecentSubmissionsUseCase,
        super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
      HomeEvent event, Emitter<HomeState> emit) async {
    final username = (event is LoadHomeData) ? event.username : (event as RefreshHomeData).username;
    
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        _fetchUserProfileUseCase(username),
        _fetchUserStatsUseCase(username),
        _fetchCalendarUseCase(username),
        _fetchContestRatingUseCase.getUserRanking(username),
        _fetchContestRatingUseCase.getHistogram(),
        _fetchBadgesUseCase(username),
        _fetchRecentSubmissionsUseCase(username),
      ]);

      emit(HomeLoaded(
        userInfo: results[0] as LeetCodeUserInfo?,
        userStats: results[1] as UserQuestionStatusData?,
        calendar: results[2] as UserProfileCalendarResponse?,
        contestRanking: results[3] as UserContestRankingResponse?,
        contestHistogram: results[4] as ContestRatingHistogramResponse?,
        badges: results[5] as UserBadgesResponse?,
        recentSubmissions: results[6] as UserRecentAcSubmissionResponse?,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
