import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/scan/presentation/pages/history_page.dart';
import 'package:qr_solutions/share/presentation/pages/home_page.dart';
import 'package:qr_solutions/features/settings/presentation/pages/settings_page.dart';

import 'package:qr_solutions/l10n/l10n.dart';

void main() => runApp(const QRSolutionsApp());

class QRSolutionsApp extends StatelessWidget {
  const QRSolutionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  bool isDark = false;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      initialRoute: INITIAL_ROUTE,
      routes: {
        HOME_ROUTE: (_) => HomePage(),
        HISTORY_ROUTE: (_) => const HistoryPage(),
        SETTINGS_ROUTE: (_) => const SettingsPage(),
      },
      theme: ThemeData(
          primaryColor: PRIMARY_COLOR,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: PRIMARY_COLOR,
          )),
      locale: const Locale(APP_LOCALE_EN), //uiProvider.getCurrentLocale,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
