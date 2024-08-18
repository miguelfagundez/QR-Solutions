import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:qr_solutions/l10n/l10n.dart';
import 'package:qr_solutions/src/pages/home/home_page.dart';
import 'package:qr_solutions/src/pages/history/history_page.dart';
import 'package:qr_solutions/src/pages/maps/maps_page.dart';
import 'package:qr_solutions/src/pages/settings/settings_page.dart';
import 'package:qr_solutions/src/pages/web/web_page.dart';
import 'package:qr_solutions/src/services/providers/ui_state.dart';
import 'package:qr_solutions/src/theme/qr_theme.dart';

void main() => runApp(const QRSolutionsApp());

class QRSolutionsApp extends StatelessWidget {
  const QRSolutionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiState()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  bool isDark = false;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Solutions',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'web': (_) => const WebPage(),
        'history': (_) => const HistoryPage(),
        'maps': (_) => const MapsPage(),
        'settings': (_) => const SettingsPage()
      },
      theme: isDark
          ? QRTheme(myPrimaryColor: Colors.deepPurple).myDarkTheme()
          : QRTheme(myPrimaryColor: Colors.deepPurple).myLightTheme(),
      locale: const Locale('en'), //uiProvider.getCurrentLocale,
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
