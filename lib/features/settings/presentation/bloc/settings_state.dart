part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  final Settings? settings;

  const SettingsState({
    this.settings,
  });
}

class SettingInitialState extends SettingsState {
  SettingInitialState()
      : super(
          settings: Settings(
            isDarkMode: false,
            openWebAutomatically: false,
            openEmailAutomatically: false,
            openPhoneAutomatically: false,
            language: 'en',
          ),
        );
}

class SettingsFailureState extends SettingsState {
  final Failure failure;

  const SettingsFailureState({
    required this.failure,
  });
}

class ChangeSettingsState extends SettingsState {
  final Settings newSettings;

  const ChangeSettingsState(this.newSettings)
      : super(
          settings: newSettings,
        );
}
