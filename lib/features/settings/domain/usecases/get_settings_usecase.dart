import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase({required this.repository});

  Either<Failure, Settings> call() {
    return repository.getSettings();
  }
}
