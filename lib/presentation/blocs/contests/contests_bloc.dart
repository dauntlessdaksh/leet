import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/contest_list_model.dart';
import 'package:leet/domain/usecases/fetch_all_contests_usecase.dart';
import 'package:leet/domain/usecases/fetch_upcoming_contests_usecase.dart';

// Events
abstract class ContestsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllContests extends ContestsEvent {}

class LoadUpcomingContests extends ContestsEvent {}

// States
abstract class ContestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContestsInitial extends ContestsState {}

class ContestsLoading extends ContestsState {}

class AllContestsLoaded extends ContestsState {
  final List<ContestItem> contests;

  AllContestsLoaded(this.contests);

  @override
  List<Object> get props => [contests];
}

class UpcomingContestsLoaded extends ContestsState {
  final List<ContestItem> contests;

  UpcomingContestsLoaded(this.contests);

  @override
  List<Object> get props => [contests];
}

class ContestsError extends ContestsState {
  final String message;

  ContestsError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class ContestsBloc extends Bloc<ContestsEvent, ContestsState> {
  final FetchAllContestsUseCase _fetchAllContestsUseCase;
  final FetchUpcomingContestsUseCase _fetchUpcomingContestsUseCase;

  ContestsBloc({
    required FetchAllContestsUseCase fetchAllContestsUseCase,
    required FetchUpcomingContestsUseCase fetchUpcomingContestsUseCase,
  })  : _fetchAllContestsUseCase = fetchAllContestsUseCase,
        _fetchUpcomingContestsUseCase = fetchUpcomingContestsUseCase,
        super(ContestsInitial()) {
    on<LoadAllContests>(_onLoadAllContests);
    on<LoadUpcomingContests>(_onLoadUpcomingContests);
  }

  Future<void> _onLoadAllContests(
      LoadAllContests event, Emitter<ContestsState> emit) async {
    emit(ContestsLoading());
    try {
      final response = await _fetchAllContestsUseCase();
      emit(AllContestsLoaded(response.allContests ?? []));
    } catch (e) {
      emit(ContestsError(e.toString()));
    }
  }

  Future<void> _onLoadUpcomingContests(
      LoadUpcomingContests event, Emitter<ContestsState> emit) async {
    emit(ContestsLoading());
    try {
      final response = await _fetchUpcomingContestsUseCase();
      emit(UpcomingContestsLoaded(response.contests ?? []));
    } catch (e) {
      emit(ContestsError(e.toString()));
    }
  }
}
