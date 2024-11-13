import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

import '../../../../core/error/failures.dart';

class OpenScanDatabaseUseCase {
  final ScanRepository repository;

  OpenScanDatabaseUseCase({required this.repository});

  Future<Either<Failure, dynamic>> call(int version) {
    return repository.openScanDatabase(version);
  }
}
