import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

import '../../../../core/error/failures.dart';

class GetScanUseCase {
  final ScanRepository repository;

  GetScanUseCase({required this.repository});

  Future<Either<Failure, Scan>> call(int id) async {
    return await repository.getScan(id);
  }
}
