abstract class Failure {
  // Base error info
  final String message;
  final String code;

  Failure({
    required this.code,
    required this.message,
  });
}

class LocalDataBaseFailure extends Failure {
  // Internal info for database errors
  LocalDataBaseFailure({required super.code, required super.message});
}

class PreferencesFailure extends Failure {
  // Internal info for preferences errors
  PreferencesFailure({required super.code, required super.message});
}
