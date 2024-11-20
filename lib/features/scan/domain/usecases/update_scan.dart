import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/scan.dart';

class UpdateScanUseCase {
  final ScanRepository repository;

  UpdateScanUseCase({required this.repository});

  Future<Either<Failure, int?>> call(Scan scan) async {
    return await repository.updateScan(scan);
  }
}
