part of 'settings_bloc.dart';

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
