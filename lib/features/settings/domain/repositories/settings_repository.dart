import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Either<Failure, bool> setSettings(Settings settings);
  Either<Failure, Settings> getSettings();
}
