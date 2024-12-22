import 'package:get_it/get_it.dart';
import 'package:qr_solutions/features/scan/data/datasources/scan_sqlite_data_source.dart';
import 'package:qr_solutions/features/scan/data/repositories/scan_repository_impl.dart';
import 'package:qr_solutions/features/scan/domain/repositories/scan_repository.dart';
import 'package:qr_solutions/features/scan/domain/usecases/delete_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/delete_scan.dart';
import 'package:qr_solutions/features/scan/domain/usecases/get_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/insert_scan.dart';
import 'package:qr_solutions/features/scan/domain/usecases/update_scan.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/features/settings/data/datasources/settings_preferences_data_source.dart';
import 'package:qr_solutions/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:qr_solutions/features/settings/domain/repositories/settings_repository.dart';
import 'package:qr_solutions/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:qr_solutions/features/settings/domain/usecases/set_settings_usecase.dart';
import 'package:qr_solutions/features/settings/presentation/bloc/settings_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  // --- bloc register ---
  di.registerFactory(() => ScanBloc(di(), di(), di(), di(), di()));
  di.registerFactory(() => SettingsBloc(di(), di()));

  // --- usecases ---
  // Scans
  di.registerLazySingleton(() => DeleteAllScansUseCase(repository: di()));
  di.registerLazySingleton(() => DeleteScanUseCase(repository: di()));
  di.registerLazySingleton(() => InsertScanUseCase(repository: di()));
  di.registerLazySingleton(() => GetAllScansUseCase(repository: di()));
  di.registerLazySingleton(() => UpdateScanUseCase(repository: di()));
  // Settings
  di.registerLazySingleton(
    () => SetSettingsUseCase(repository: di()),
  );
  di.registerLazySingleton(
    () => GetSettingsUseCase(repository: di()),
  );

  // --- repository ---
  di.registerLazySingleton<ScanRepository>(
      () => ScanRepositoryImpl(scanSqliteDataSource: di()));
  di.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(settingsPreferencesDataSource: di()));

  // --- datasources ---
  di.registerLazySingleton<ScanSqliteDataSource>(
      () => ScanSqliteDataSourceImpl());
  di.registerLazySingleton<SettingsPreferencesDataSource>(
      () => SettingsPreferencesDataSourceImpl());
}
