import 'package:dartz/dartz.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';

import '../../../../core/error/failures.dart';

abstract class ScanRepository {
  Future<Either<Failure, dynamic>> openScanDatabase(int version);
  Future<Either<Failure, int>> insertScan(String value);
  Future<Either<Failure, Scan>> getScan(int id);
  Future<Either<Failure, List<Scan>>> getAllScans();
  Future<Either<Failure, int>> updateScan(Scan scan);
  Future<Either<Failure, int>> deleteScan(int id);
  Future<Either<Failure, int>> deleteAllScans();
}
