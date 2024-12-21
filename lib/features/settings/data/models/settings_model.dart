import 'package:qr_solutions/features/settings/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    super.isDarkMode,
    super.openWebAutomatically,
    super.openEmailAutomatically,
    super.openPhoneAutomatically,
  });
}
