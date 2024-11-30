part of 'scan_bloc.dart';

@immutable
abstract class ScanState {
  bool? isUpdated;
  List<Scan>? listOfScans;
  ScanState({this.isUpdated, this.listOfScans});
}

class ScanInitialState extends ScanState {
  ScanInitialState() : super(isUpdated: false, listOfScans: []);
}

class ScanDatabaseFailureState extends ScanState {
  final Failure failure;

  ScanDatabaseFailureState({
    required this.failure,
  });
}

// Insert, Update, Delete, Delete All
class ScanDatabaseSuccessState extends ScanState {
  ScanDatabaseSuccessState();
}

class GetAllScansState extends ScanState {
  GetAllScansState();
}
