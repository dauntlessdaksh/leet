import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Events
abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

// States
abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final String appVersion;
  final String buildNumber;

  SettingsLoaded({
    required this.appVersion,
    required this.buildNumber,
  });

  @override
  List<Object> get props => [appVersion, buildNumber];
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      emit(SettingsLoaded(
        appVersion: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      ));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
