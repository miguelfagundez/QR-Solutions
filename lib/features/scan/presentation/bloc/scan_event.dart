part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}

class InitialStateEvent extends ScanEvent {
  InitialStateEvent();
}

class OpenScanDatabaseEvent extends ScanEvent {}

class DeleteAllScansEvent extends ScanEvent {}

class InsertScanEvent extends ScanEvent {
  final Scan scan;

  InsertScanEvent({required this.scan});
}

class GetAllScansEvent extends ScanEvent {
  GetAllScansEvent();
}
