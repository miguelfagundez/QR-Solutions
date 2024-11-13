import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/scan.dart';

class GetAllScansUseCase {
  final ScanRepository repository;

  GetAllScansUseCase({required this.repository});

  Future<Either<Failure, List<Scan>>> call() {
    return repository.getAllScans();
  }
}
