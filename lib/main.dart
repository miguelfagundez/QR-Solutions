import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/core/utils/globals.dart';
import 'package:qr_solutions/di.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/features/scan/presentation/pages/history_page.dart';
import 'package:qr_solutions/features/scan/presentation/pages/scan_details_page.dart';
import 'package:qr_solutions/features/settings/data/datasources/settings_preferences_data_source.dart';
import 'package:qr_solutions/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:qr_solutions/share/presentation/bloc/ui/ui_bloc.dart';
import 'package:qr_solutions/share/presentation/pages/home_page.dart';
import 'package:qr_solutions/features/settings/presentation/pages/settings_page.dart';

import 'package:qr_solutions/l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Shared preferences
  await SettingsPreferencesDataSourceImpl.init();
  // Init Scan Bloc dependencies
  await init();

  runApp(const QRSolutionsApp());
}

class QRSolutionsApp extends StatelessWidget {
  const QRSolutionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UiBloc()),
        BlocProvider(create: (_) => GetIt.instance.get<ScanBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<SettingsBloc>()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (conext, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: APP_NAME,
        scaffoldMessengerKey: snackbarKey,
        initialRoute: INITIAL_ROUTE,
        routes: {
          HOME_ROUTE: (_) => const HomePage(),
          HISTORY_ROUTE: (_) => const HistoryPage(),
          SETTINGS_ROUTE: (_) => const SettingsPage(),
          SCAN_DETAILS_ROUTE: (_) => const ScanDetailsPage(),
        },
        theme:
            (state.isDarkMode ?? false) ? ThemeData.dark() : ThemeData.light(),
        // theme: ThemeData(
        //     primaryColor: PRIMARY_COLOR,
        //     floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //       backgroundColor: PRIMARY_COLOR,
        //     )),
        locale: const Locale(APP_LOCALE_EN),
        //locale: const Locale(APP_LOCALE_ES),
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      );
    });
  }
}
