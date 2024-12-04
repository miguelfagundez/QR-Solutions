part of 'scan_bloc.dart';

@immutable
abstract class ScanState {
  final bool? isUpdated;
  final List<Scan>? listOfScans;
  const ScanState({this.isUpdated, this.listOfScans});
}

class ScanInitialState extends ScanState {
  ScanInitialState() : super(isUpdated: false, listOfScans: []);
}

class ScanDatabaseFailureState extends ScanState {
  final Failure failure;

  const ScanDatabaseFailureState({
    required this.failure,
  });
}

// Insert, Update, Delete, Delete All
class ScanDatabaseSuccessState extends ScanState {
  const ScanDatabaseSuccessState();
}

class GetAllScansState extends ScanState {
  final List<Scan> newListOfScans;
  const GetAllScansState(this.newListOfScans)
      : super(isUpdated: true, listOfScans: newListOfScans);
}
