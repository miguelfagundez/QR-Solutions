import 'package:qr_solutions/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  SettingsModel({
    required super.isDarkMode,
    required super.openWebAutomatically,
    required super.openEmailAutomatically,
    required super.openPhoneAutomatically,
    required super.language,
  });
}
