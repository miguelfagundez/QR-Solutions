import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';

abstract class SettingsRepository {
  Either<Failure, bool> getDarkMode();
  Either<Failure, bool> setDarkMode(bool value);
}
