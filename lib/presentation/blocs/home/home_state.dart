part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final LeetCodeUserInfo? userInfo;
  final UserQuestionStatusData? userStats;
  final UserProfileCalendarResponse? calendar;
  final UserContestRankingResponse? contestRanking;
  final ContestRatingHistogramResponse? contestHistogram;
  final UserBadgesResponse? badges;
  final UserRecentAcSubmissionResponse? recentSubmissions;

  HomeLoaded({
    this.userInfo,
    this.userStats,
    this.calendar,
    this.contestRanking,
    this.contestHistogram,
    this.badges,
    this.recentSubmissions,
  });

  @override
  List<Object?> get props => [
        userInfo,
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
