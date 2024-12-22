import 'package:dartz/dartz.dart';

import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/data/datasources/settings_preferences_data_source.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsPreferencesDataSource settingsPreferencesDataSource;

  SettingsRepositoryImpl({required this.settingsPreferencesDataSource});

  @override
  Either<Failure, bool> setSettings(Settings settings) {
    try {
      bool result = settingsPreferencesDataSource.setSettings(settings);
      return Right(result);
    } catch (error) {
      return Left(PreferencesFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Either<Failure, Settings> getSettings() {
    try {
      final Settings resp = settingsPreferencesDataSource.getSettings();
      return Right(resp);
    } catch (error) {
      return Left(PreferencesFailure(message: error.toString(), code: ''));
    }
  }
}
