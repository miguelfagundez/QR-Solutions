import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/domain/usecases/get_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/insert_scan.dart';
import 'package:qr_solutions/features/scan/domain/usecases/open_scan_database.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final GetAllScansUseCase _getAllScansUseCase;
  final InsertScanUseCase _insertScanUseCase;
  final OpenScanDatabaseUseCase _openScanDatabaseUseCase;

  ScanBloc(
    this._getAllScansUseCase,
    this._insertScanUseCase,
    this._openScanDatabaseUseCase,
  ) : super(ScanInitialState()) {
    on<OpenScanDatabaseEvent>(_openScanDatabaseEvent);
    on<InsertScanEvent>(_insertLastScanState);
    on<GetAllScansEvent>(_getAllScansEvent);
  }

  _openScanDatabaseEvent(
      OpenScanDatabaseEvent event, Emitter<ScanState> emit) async {
    final resp = await _openScanDatabaseUseCase();
    resp.fold(
        (insertFailure) =>
            emit(ScanDatabaseFailureState(failure: insertFailure)),
        (insertValue) {
      debugPrint('Database was created or opened, $insertValue');
    });
  }

  _insertLastScanState(InsertScanEvent event, Emitter<ScanState> emit) async {
    final resp = await _insertScanUseCase(event.scan);
    debugPrint('Insert scan into database, ${event.scan.value}');
    resp.fold(
        (insertFailure) =>
            emit(ScanDatabaseFailureState(failure: insertFailure)),
        (insertValue) {
      state.isUpdated = true;
      debugPrint('Insert scan into database, $insertValue');
    });
  }

  _getAllScansEvent(GetAllScansEvent event, Emitter<ScanState> emit) async {
    final resp = await _getAllScansUseCase();

    resp.fold(
        (getScansFailure) =>
            emit(ScanDatabaseFailureState(failure: getScansFailure)),
        (listOfScans) {
      state.isUpdated = false;
      debugPrint('Getting scans into database, ${listOfScans.length}');
    });
  }
}
