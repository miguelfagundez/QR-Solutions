import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';

abstract class SettingsPreferencesDataSource {
  bool setSettings(Settings settings);
  Settings getSettings();
}

class SettingsPreferencesDataSourceImpl
    implements SettingsPreferencesDataSource {
  static late SharedPreferences? _prefs;
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  bool setSettings(Settings settings) {
    try {
      _prefs?.setBool(APP_PREFERENCES_DARKMODE, settings.isDarkMode);
      _prefs?.setString(APP_PREFERENCES_LANGUAGE, settings.language);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Settings getSettings() {
    Settings settings = Settings(
      isDarkMode: _prefs?.getBool(APP_PREFERENCES_DARKMODE) ?? false,
      openWebAutomatically:
          _prefs?.getBool(APP_PREFERENCES_OPEN_WEBSITE) ?? false,
      openEmailAutomatically:
          _prefs?.getBool(APP_PREFERENCES_OPEN_EMAIL) ?? false,
      openPhoneAutomatically:
          _prefs?.getBool(APP_PREFERENCES_OPEN_PHONE) ?? false,
      language:
          _prefs?.getString(APP_PREFERENCES_LANGUAGE) ?? APP_LANGUAGE_DEFAULT,
    );
    return settings;
  }
}
