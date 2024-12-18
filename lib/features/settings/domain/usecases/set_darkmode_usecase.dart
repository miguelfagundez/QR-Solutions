import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';

class SetDarkModeUseCase {
  final SettingsRepository repository;

  SetDarkModeUseCase({required this.repository});

  Either<Failure, bool> call(bool value) {
    return repository.setDarkMode(value);
  }
}
