import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';

// Events
abstract class CompareEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CompareUsers extends CompareEvent {
  final String username1;
  final String username2;

  CompareUsers(this.username1, this.username2);

  @override
  List<Object> get props => [username1, username2];
}

// States
abstract class CompareState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompareInitial extends CompareState {}

class CompareLoading extends CompareState {}

class CompareLoaded extends CompareState {
  final UserQuestionStatusData? user1Stats;
  final UserQuestionStatusData? user2Stats;
  final UserContestRankingResponse? user1Contest;
  final UserContestRankingResponse? user2Contest;
  final UserProfileCalendarResponse? user1Calendar;
  final UserProfileCalendarResponse? user2Calendar;

  CompareLoaded({
    this.user1Stats,
    this.user2Stats,
    this.user1Contest,
    this.user2Contest,
    this.user1Calendar,
    this.user2Calendar,
  });

  @override
  List<Object?> get props => [
        user1Stats,
        user2Stats,
        user1Contest,
        user2Contest,
        user1Calendar,
        user2Calendar,
      ];
}

class CompareError extends CompareState {
  final String message;
  CompareError(this.message);

  @override
  List<Object> get props => [message];
}

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
