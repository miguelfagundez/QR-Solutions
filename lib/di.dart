import 'package:get_it/get_it.dart';
import 'package:qr_solutions/features/scan/data/datasources/scan_sqlite_data_source.dart';
import 'package:qr_solutions/features/scan/data/repositories/scan_repository_impl.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';
import 'package:qr_solutions/features/scan/domain/usecases/delete_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/get_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/insert_scan.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  // bloc register
  di.registerFactory(() => ScanBloc(di(), di(), di()));

  // usecases
  di.registerLazySingleton(() => DeleteAllScansUseCase(repository: di()));
  di.registerLazySingleton(() => InsertScanUseCase(repository: di()));
  di.registerLazySingleton(() => GetAllScansUseCase(repository: di()));

  // repository
  di.registerLazySingleton<ScanRepository>(
      () => ScanRepositoryImpl(scanSqliteDataSource: di()));

  // datasources
  di.registerLazySingleton<ScanSqliteDataSource>(
      () => ScanSqliteDataSourceImpl());
}
