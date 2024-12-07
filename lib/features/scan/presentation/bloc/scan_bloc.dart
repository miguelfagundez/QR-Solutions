import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/domain/usecases/delete_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/delete_scan.dart';
import 'package:qr_solutions/features/scan/domain/usecases/get_all_scans.dart';
import 'package:qr_solutions/features/scan/domain/usecases/insert_scan.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final DeleteAllScansUseCase _deleteAllScansUseCase;
  final DeleteScanUseCase _deleteScanUseCase;
  final GetAllScansUseCase _getAllScansUseCase;
  // final GetScanUseCase _getScanUseCase;
  final InsertScanUseCase _insertScanUseCase;
  // final UpdateScanUseCase _updateScanUseCase;

  ScanBloc(
    this._deleteAllScansUseCase,
    this._deleteScanUseCase,
    this._getAllScansUseCase,
    // this._getScanUseCase,
    this._insertScanUseCase,
    // this._updateScanUseCase,
  ) : super(ScanInitialState()) {
    on<DeleteAllScansEvent>(_deleteAllScansEvent);
    on<DeleteScanEvent>(_deleteScanEvent);
    on<InsertScanEvent>(_insertLastScanState);
    on<GetAllScansEvent>(_getAllScansEvent);
  }

  _deleteAllScansEvent(
      DeleteAllScansEvent event, Emitter<ScanState> emit) async {
    final resp = await _deleteAllScansUseCase();

    resp.fold(
        (deleteAllScansFailure) =>
            emit(ScanDatabaseFailureState(failure: deleteAllScansFailure)),
        (deleteAllScansSuccess) {
      debugPrint('All scans were deleted successfully, $deleteAllScansSuccess');
      emit(ScanInitialState());
    });
  }

  _deleteScanEvent(DeleteScanEvent event, Emitter<ScanState> emit) async {
    final resp = await _deleteScanUseCase(event.id);

    resp.fold(
        (deleteScanFailure) =>
            emit(ScanDatabaseFailureState(failure: deleteScanFailure)),
        (deleteScanSuccess) {
      debugPrint('Scan were deleted successfully, ${event.id}');
      // Call GetAllScans event to update my new state
      add(GetAllScansEvent());
    });
  }

  _insertLastScanState(InsertScanEvent event, Emitter<ScanState> emit) async {
    final resp = await _insertScanUseCase(event.scan);

    debugPrint('Insert scan into database, ${event.scan.value}');
    resp.fold(
        (insertFailure) =>
            emit(ScanDatabaseFailureState(failure: insertFailure)),
        (insertValue) {
      debugPrint('Insert scan into database, $insertValue');
      // Call GetAllScans event to update my new state
      add(GetAllScansEvent());
    });
  }

  _getAllScansEvent(GetAllScansEvent event, Emitter<ScanState> emit) async {
    final resp = await _getAllScansUseCase();

    resp.fold(
        (getScansFailure) =>
            emit(ScanDatabaseFailureState(failure: getScansFailure)),
        (listOfScans) {
      debugPrint('Getting scans into database, ${listOfScans.length}');
      emit(GetAllScansState(listOfScans));
    });
  }
}
