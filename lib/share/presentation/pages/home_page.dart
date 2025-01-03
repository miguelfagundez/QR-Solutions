import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/features/scan/presentation/pages/create_qr_page.dart';
import 'package:qr_solutions/features/scan/presentation/pages/history_page.dart';
import 'package:qr_solutions/features/settings/presentation/pages/settings_page.dart';
import 'package:qr_solutions/share/presentation/bloc/ui/ui_bloc.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_navegation_bar.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_scan_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [
    const HistoryPage(),
    const CreateQrPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UiBloc, UiState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            APP_NAME,
          ),
          actions: [
            (state.indexSelected == 0)
                ? IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title:
                              Text(AppLocalizations.of(context)!.confirmTitle),
                          content: Text(AppLocalizations.of(context)!
                              .confirmDeleteAllScansBody),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<ScanBloc>(context,
                                          listen: false)
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
                : const SizedBox.shrink()
          ],
        ),
        body: IndexedStack(
          index: state.indexSelected,
          children: screens,
        ),
        bottomNavigationBar: const CustomNavigationBar(),
        floatingActionButton:
            (state.indexSelected == 0) ? const CustomScanButton() : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
