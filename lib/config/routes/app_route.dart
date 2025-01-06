import 'package:flutter/material.dart';
import 'package:qr_solutions/config/routes/route_model.dart';

import 'package:qr_solutions/features/scan/presentation/pages/history_page.dart';
import 'package:qr_solutions/features/scan/presentation/pages/maps_page.dart';
import 'package:qr_solutions/features/scan/presentation/pages/scan_details_page.dart';
import 'package:qr_solutions/share/presentation/pages/home_page.dart';
import 'package:qr_solutions/features/settings/presentation/pages/settings_page.dart';

abstract class AppRoutes {
  // Initial screen
  static const initialRoute = 'home';

  // Route models - App routes
  static final menuRoutes = <RouteModel>[
    RouteModel(
      name: 'Home',
      route: 'home',
      screen: const HomePage(),
      icon: Icons.home,
    ),
    RouteModel(
      name: 'History',
      route: 'history',
      screen: const HistoryPage(),
      icon: Icons.history,
    ),
    RouteModel(
      name: 'Settings',
      route: 'settings',
      screen: const SettingsPage(),
      icon: Icons.settings,
    ),
    RouteModel(
      name: 'Details',
      route: 'details',
      screen: const ScanDetailsPage(),
      icon: Icons.details,
    ),
    RouteModel(
      name: 'Maps',
      route: 'maps',
      screen: const MapsPage(),
      icon: Icons.map,
    ),
  ];

  // Get App routes
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> getAppRoutes = {};

    for (final route in menuRoutes) {
      getAppRoutes
          .addAll({route.route: (BuildContext context) => route.screen});
    }

    return getAppRoutes;
  }

  static Route<dynamic>? onGenerateDefaultRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomePage(),
    );
  }
}
