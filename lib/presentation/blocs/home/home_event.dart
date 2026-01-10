part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  final String username;
  LoadHomeData(this.username);
  
  @override
  List<Object> get props => [username];
}

class RefreshHomeData extends HomeEvent {
    final String username;
  RefreshHomeData(this.username);
  
  @override
  List<Object> get props => [username];
}
