import 'package:dartz/dartz.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/scan/data/datasources/scan_sqlite_data_source.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';
import 'package:sqflite/sqflite.dart';

class ScanRepositoryImpl implements ScanRepository {
  final ScanSqliteDataSource scanSqliteDataSource;

  ScanRepositoryImpl({required this.scanSqliteDataSource});

  @override
  Future<Either<Failure, int?>> deleteAllScans() async {
    try {
      final int? resp = await scanSqliteDataSource.deleteAllScans();
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, int?>> deleteScan(int id) async {
    try {
      final int? resp = await scanSqliteDataSource.deleteScan(id);
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, List<Scan>>> getAllScans() async {
    try {
      final List<Scan> resp = await scanSqliteDataSource.getAllScans();
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, Scan?>> getScan(int id) async {
    try {
      final Scan? resp = await scanSqliteDataSource.getScan(id);
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, int?>> insertScan(Scan scan) async {
    try {
      final int? resp = await scanSqliteDataSource.insertScan(scan);
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, dynamic>> openScanDatabase() async {
    try {
      final Database? resp = await scanSqliteDataSource.openScanDatabase();
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Either<Failure, int?>> updateScan(Scan scan) async {
    try {
      final int? resp = await scanSqliteDataSource.updateScan(scan);
      return Right(resp);
    } catch (error) {
      return Left(LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }
}
