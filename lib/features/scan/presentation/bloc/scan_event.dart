part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}

class InitialStateEvent extends ScanEvent {
  InitialStateEvent();
}

class DeleteAllScansEvent extends ScanEvent {}

class InsertScanEvent extends ScanEvent {
  final Scan scan;

  InsertScanEvent({required this.scan});
}

class DeleteScanEvent extends ScanEvent {
  final int id;
  DeleteScanEvent({required this.id});
}

class GetAllScansEvent extends ScanEvent {
  GetAllScansEvent();
}
