import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/features/scan/presentation/pages/history_page.dart';
import 'package:qr_solutions/features/settings/presentation/pages/settings_page.dart';
import 'package:qr_solutions/share/presentation/bloc/ui/ui_bloc.dart';
// import 'package:qr_solutions/share/presentation/providers/ui_provider.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_navegation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_scan_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [
    const HistoryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          APP_NAME,
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.confirmTitle),
                  content: Text(
                      AppLocalizations.of(context)!.confirmDeleteAllScansBody),
                  actions: [
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<ScanBloc>(context, listen: false)
                              .add(DeleteAllScansEvent());
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.yes)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.no)),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<UiBloc, UiState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.indexSelected,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
