import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/badges_model.dart';
import 'package:leet/data/models/submission_model.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_badges_usecase.dart';
import 'package:leet/domain/usecases/fetch_recent_submissions_usecase.dart';
import 'package:leet/domain/usecases/fetch_daily_challenge_usecase.dart';

// Events
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  final String username;
  LoadHomeData(this.username);
  
  @override
  List<Object> get props => [username];
}

class RefreshHomeData extends HomeEvent {
    final String username;
  RefreshHomeData(this.username);
  
  @override
  List<Object> get props => [username];
}

// States
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserQuestionStatusData? userStats;
  final UserProfileCalendarResponse? calendar;
  final UserContestRankingResponse? contestRanking;
  final ContestRatingHistogramResponse? contestHistogram;
  final UserBadgesResponse? badges;
  final UserRecentAcSubmissionResponse? recentSubmissions;

  HomeLoaded({
    this.userStats,
    this.calendar,
    this.contestRanking,
    this.contestHistogram,
    this.badges,
    this.recentSubmissions,
  });

  @override
  List<Object?> get props => [
        userStats,
        calendar,
        contestRanking,
        contestHistogram,
        badges,
        recentSubmissions,
      ];
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchUserStatsUseCase _fetchUserStatsUseCase;
  final FetchCalendarUseCase _fetchCalendarUseCase;
  final FetchContestRatingUseCase _fetchContestRatingUseCase;
  final FetchBadgesUseCase _fetchBadgesUseCase;
  final FetchRecentSubmissionsUseCase _fetchRecentSubmissionsUseCase;

  HomeBloc({
    required FetchUserStatsUseCase fetchUserStatsUseCase,
    required FetchCalendarUseCase fetchCalendarUseCase,
    required FetchContestRatingUseCase fetchContestRatingUseCase,
    required FetchBadgesUseCase fetchBadgesUseCase,
    required FetchRecentSubmissionsUseCase fetchRecentSubmissionsUseCase,
  })  : _fetchUserStatsUseCase = fetchUserStatsUseCase,
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
        _fetchUserStatsUseCase(username),
        _fetchCalendarUseCase(username),
        _fetchContestRatingUseCase.getUserRanking(username),
        _fetchContestRatingUseCase.getHistogram(),
        _fetchBadgesUseCase(username),
        _fetchRecentSubmissionsUseCase(username),
      ]);

      emit(HomeLoaded(
        userStats: results[0] as UserQuestionStatusData?,
        calendar: results[1] as UserProfileCalendarResponse?,
        contestRanking: results[2] as UserContestRankingResponse?,
        contestHistogram: results[3] as ContestRatingHistogramResponse?,
        badges: results[4] as UserBadgesResponse?,
        recentSubmissions: results[5] as UserRecentAcSubmissionResponse?,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
