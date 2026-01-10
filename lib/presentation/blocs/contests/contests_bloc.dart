import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/data/models/contest_list_model.dart';
import 'package:leet/domain/usecases/fetch_all_contests_usecase.dart';
import 'package:leet/domain/usecases/fetch_upcoming_contests_usecase.dart';

part 'contests_event.dart';
part 'contests_state.dart';

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
