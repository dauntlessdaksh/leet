import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_event.dart';
part 'settings_state.dart';

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
