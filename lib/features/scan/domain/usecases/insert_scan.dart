import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

class InsertScanUseCase {
  final ScanRepository repository;

  InsertScanUseCase({required this.repository});

  Future<Either<Failure, int?>> call(Scan scan) async {
    return await repository.insertScan(scan);
  }
}
