part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class InitialSettingsEvent extends SettingsEvent {
  InitialSettingsEvent();
}

class GetDarkModeEvent extends SettingsEvent {
  GetDarkModeEvent();
}

class ChangeDarkModeEvent extends SettingsEvent {
  final bool isDarkMode;

  ChangeDarkModeEvent({required this.isDarkMode});
}
