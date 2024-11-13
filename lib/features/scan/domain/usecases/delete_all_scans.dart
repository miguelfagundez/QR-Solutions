import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

import '../../../../core/error/failures.dart';

class DeleteAllScansUseCase {
  final ScanRepository repository;

  DeleteAllScansUseCase({required this.repository});

  Future<Either<Failure, int>> call() {
    return repository.deleteAllScans();
  }
}
