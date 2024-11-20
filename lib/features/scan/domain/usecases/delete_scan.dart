import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

import '../../../../core/error/failures.dart';

class DeleteScanUseCase {
  final ScanRepository repository;

  DeleteScanUseCase({required this.repository});

  Future<Either<Failure, int?>> call(int id) async {
    return await repository.deleteScan(id);
  }
}
