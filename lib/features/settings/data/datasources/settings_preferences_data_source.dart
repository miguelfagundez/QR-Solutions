import 'package:qr_solutions/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsPreferencesDataSource {
  bool getDarkMode();
  bool setDarkMode(bool value);
}

class SettingsPreferencesDataSourceImpl
    implements SettingsPreferencesDataSource {
  static late SharedPreferences? _prefs;
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  bool getDarkMode() {
    return _prefs?.getBool(APP_PREFERENCES_DARKMODE) ?? false;
  }

  @override
  bool setDarkMode(bool value) {
    try {
      _prefs?.setBool(APP_PREFERENCES_DARKMODE, value);
      return true;
    } catch (error) {
      return false;
    }
  }
}
