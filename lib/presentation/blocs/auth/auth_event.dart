part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username;
  LoginRequested(this.username);

  @override
  List<Object> get props => [username];
}

class LogoutRequested extends AuthEvent {}
