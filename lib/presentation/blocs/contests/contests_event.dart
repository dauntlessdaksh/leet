part of 'contests_bloc.dart';

abstract class ContestsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllContests extends ContestsEvent {}

class LoadUpcomingContests extends ContestsEvent {}
