part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final LeetCodeUserInfo? userProfile;
  final UserQuestionStatusData? userStats;
  final UserContestRankingResponse? contestRanking;
  final UserRecentAcSubmissionResponse? recentSubmissions;

  UserDetailsLoaded({
    this.userProfile,
    this.userStats,
    this.contestRanking,
    this.recentSubmissions,
  });

  @override
  List<Object?> get props => [userProfile, userStats, contestRanking, recentSubmissions];
}

class UserDetailsError extends UserDetailsState {
  final String message;
  UserDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
