part of 'compare_bloc.dart';

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
