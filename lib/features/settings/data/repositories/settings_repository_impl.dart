import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/data/datasources/settings_preferences_data_source.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsPreferencesDataSource settingsPreferencesDataSource;

  SettingsRepositoryImpl({required this.settingsPreferencesDataSource});

  @override
  Either<Failure, bool> getDarkMode() {
    try {
      final bool resp = settingsPreferencesDataSource.getDarkMode();
      return Right(resp);
    } catch (error) {
      return Left(PreferencesFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Either<Failure, bool> setDarkMode(bool value) {
    try {
      bool result = settingsPreferencesDataSource.setDarkMode(value);
      return Right(result);
    } catch (error) {
      return Left(PreferencesFailure(message: error.toString(), code: ''));
    }
  }
}
