import 'package:flutter/material.dart';

class QRTheme extends ChangeNotifier {
  final Color myPrimaryColor;

  QRTheme({
    required this.myPrimaryColor,
  });

  ThemeData myLightTheme() {
    return ThemeData.light().copyWith(
        primaryColor: myPrimaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: myPrimaryColor,
        ));
  }

  ThemeData myDarkTheme() {
    return ThemeData.dark().copyWith(
        primaryColor: myPrimaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: myPrimaryColor,
        ));
  }
}
