import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/domain/usecases/fetch_user_profile_usecase.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_recent_submissions_usecase.dart';
import 'package:leet/data/models/submission_model.dart';

// Events
abstract class UserDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserDetails extends UserDetailsEvent {
  final String username;
  LoadUserDetails(this.username);
  
  @override
  List<Object> get props => [username];
}

// States
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

// Bloc
class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final FetchUserProfileUseCase _fetchUserProfileUseCase;
  final FetchUserStatsUseCase _fetchUserStatsUseCase;
  final FetchContestRatingUseCase _fetchContestRatingUseCase;
  final FetchRecentSubmissionsUseCase _fetchRecentSubmissionsUseCase;

  UserDetailsBloc({
    required FetchUserProfileUseCase fetchUserProfileUseCase,
    required FetchUserStatsUseCase fetchUserStatsUseCase,
    required FetchContestRatingUseCase fetchContestRatingUseCase,
    required FetchRecentSubmissionsUseCase fetchRecentSubmissionsUseCase,
  })  : _fetchUserProfileUseCase = fetchUserProfileUseCase,
        _fetchUserStatsUseCase = fetchUserStatsUseCase,
        _fetchContestRatingUseCase = fetchContestRatingUseCase,
        _fetchRecentSubmissionsUseCase = fetchRecentSubmissionsUseCase,
        super(UserDetailsInitial()) {
    on<LoadUserDetails>(_onLoadUserDetails);
  }

  Future<void> _onLoadUserDetails(
      LoadUserDetails event, Emitter<UserDetailsState> emit) async {
    emit(UserDetailsLoading());
    try {
      final results = await Future.wait([
        _fetchUserProfileUseCase(event.username),
        _fetchUserStatsUseCase(event.username),
        _fetchContestRatingUseCase.getUserRanking(event.username),
        _fetchRecentSubmissionsUseCase(event.username),
      ]);

      emit(UserDetailsLoaded(
        userProfile: results[0] as LeetCodeUserInfo?,
        userStats: results[1] as UserQuestionStatusData?,
        contestRanking: results[2] as UserContestRankingResponse?,
        recentSubmissions: results[3] as UserRecentAcSubmissionResponse?,
      ));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }
}
