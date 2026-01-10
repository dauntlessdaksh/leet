part of 'contests_bloc.dart';

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
