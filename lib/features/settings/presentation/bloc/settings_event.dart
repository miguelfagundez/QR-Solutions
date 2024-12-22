part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class InitialSettingsEvent extends SettingsEvent {
  InitialSettingsEvent();
}

class ChangeSettingsEvent extends SettingsEvent {
  final Settings settings;

  ChangeSettingsEvent({required this.settings});
}

class GetSettingsEvent extends SettingsEvent {
  GetSettingsEvent();
}
