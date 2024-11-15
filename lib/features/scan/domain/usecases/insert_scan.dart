import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';

class InserScanUseCase {
  final ScanRepository repository;

  InserScanUseCase({required this.repository});

  Future<Either<Failure, int>> call(String value) async {
    return await repository.insertScan(value);
  }
}
