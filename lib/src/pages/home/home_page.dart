import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_solutions/src/models/scan_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/src/services/providers/db_provider.dart';

import 'package:qr_solutions/src/pages/creator/creator_page.dart';
import 'package:qr_solutions/src/pages/history/history_page.dart';
import 'package:qr_solutions/src/services/providers/scans_provider.dart';
import 'package:qr_solutions/src/widgets/custom_scan_button.dart';
import 'package:qr_solutions/src/services/providers/ui_state.dart';
import 'package:qr_solutions/src/pages/settings/settings_page.dart';
import 'package:qr_solutions/src/widgets/custom_navigation_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  int _pageIndex = 0;

  final screens = [
    const CreatorPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final uiState = Provider.of<UiState>(context);
    _pageIndex = uiState.indexSelected;

    DBProvider.db.database;

    final scanProvider = Provider.of<ScanProvider>(context);
    scanProvider.loadScans();

    return Scaffold(
      appBar: AppBar(
        title: Text((_pageIndex == 0)
            ? 'Creator'
            : (_pageIndex == 1)
                ? 'History'
                : 'Settings'),
        actions: [
          (_pageIndex == 0)
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (kDebugMode) {
                      print('Add button pressed');
                    }
                  },
                )
              : (_pageIndex == 1)
                  ? IconButton(
                      icon: const Icon(Icons.delete_forever),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(AppLocalizations.of(context)!
                                .confirmTitle), //Text('Confirm'),
                            content:
                                Text(AppLocalizations.of(context)!.confirmBody),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    final scanProvider =
                                        Provider.of<ScanProvider>(context,
                                            listen: false);

                                    scanProvider.deleteAllScans();
                                    Navigator.pop(context);
                                  },
                                  child:
                                      Text(AppLocalizations.of(context)!.yes)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                      Text(AppLocalizations.of(context)!.no)),
                            ],
                          ),
                        );
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        if (kDebugMode) {
                          print('Home button pressed');
                        }
                      },
                    ),
        ],
      ),
      body: IndexedStack(
        index: _pageIndex,
        children: screens,
      ),
      bottomNavigationBar: const CustomNavigationButton(),
      floatingActionButton: const CustomScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
