import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leet/domain/usecases/fetch_user_profile_usecase.dart';
import 'package:leet/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FetchUserProfileUseCase _fetchUserProfileUseCase;

  AuthBloc(this._fetchUserProfileUseCase) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(AppConstants.keyUsername);

    if (username != null && username.isNotEmpty) {
      emit(AuthAuthenticated(username));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _fetchUserProfileUseCase(event.username);
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.keyUsername, event.username);
        emit(AuthAuthenticated(event.username));
      } else {
        emit(AuthError("User not found"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyUsername);
    emit(AuthUnauthenticated());
  }
}
