import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';

class SetSettingsUseCase {
  final SettingsRepository repository;

  SetSettingsUseCase({required this.repository});

  Either<Failure, bool> call(Settings settings) {
    return repository.setSettings(settings);
  }
}
