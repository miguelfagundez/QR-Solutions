import 'package:flutter/material.dart';
import 'package:qr_solutions/core/utils/globals.dart';

void customSnackBar({
  required String message,
  Duration snackbarDuration = const Duration(seconds: 3),
  SnackBarAction? snackBarAction,
}) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    duration: snackbarDuration,
    action: snackBarAction,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}
