import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';

class GetDarkModeUseCase {
  final SettingsRepository repository;

  GetDarkModeUseCase({required this.repository});

  Either<Failure, bool> call() {
    return repository.getDarkMode();
  }
}
