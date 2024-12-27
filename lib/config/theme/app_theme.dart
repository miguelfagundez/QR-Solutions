import 'package:flutter/material.dart';
import 'package:qr_solutions/config/theme/colors.dart';

abstract class AppTheme {
  // Color(0xFF673AB7)
  static const _basePrimaryColor = AppColors.primaryColor;
  static const _basePrimaryLightColor = AppColors.primaryColor;
  static const _basePrimaryDarkColor = AppColors.primaryColor;

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _basePrimaryColor,
    primaryColorDark: _basePrimaryDarkColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _basePrimaryColor,
    ),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: _basePrimaryColor,
    primaryColorLight: _basePrimaryLightColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _basePrimaryColor,
    ),
  );
}
