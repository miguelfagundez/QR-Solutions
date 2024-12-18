part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  final bool? isDarkMode;

  const SettingsState({this.isDarkMode});
}

class SettingInitialState extends SettingsState {
  const SettingInitialState() : super(isDarkMode: false);
}

class SettingsFailureState extends SettingsState {
  final Failure failure;

  const SettingsFailureState({
    required this.failure,
  });
}

class ChangeDarkModeState extends SettingsState {
  final bool newDarkModeValue;

  const ChangeDarkModeState(this.newDarkModeValue)
      : super(isDarkMode: newDarkModeValue);
}
