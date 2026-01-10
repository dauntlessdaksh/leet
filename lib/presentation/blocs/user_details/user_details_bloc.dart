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

part 'user_details_event.dart';
part 'user_details_state.dart';

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
