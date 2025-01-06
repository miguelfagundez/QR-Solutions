// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/features/scan/presentation/widgets/scan_data_form.dart';
import 'package:qr_solutions/share/presentation/widgets/outline_scan_button.dart';

class ScanDetailsPage extends StatefulWidget {
  const ScanDetailsPage({super.key});

  @override
  State<ScanDetailsPage> createState() => _ScanDetailsPageState();
}

class _ScanDetailsPageState extends State<ScanDetailsPage> {
  late final Scan scan;

  @override
  void didChangeDependencies() {
    scan = (ModalRoute.of(context)!.settings.arguments) as Scan;
    super.didChangeDependencies();
  }

  void deleteScanAction(Scan item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmTitle),
        content: Text(AppLocalizations.of(context)!.confirmDeleteOneScanBody),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<ScanBloc>(context, listen: false).add(
                  DeleteScanEvent(id: item.id!),
                );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)!.scanType}: ${convertUiType(scan.type.toString())}',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              deleteScanAction(scan);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScanDataForm(scan: scan),
                  ],
                ),
              ),
            ),
          ),
          OutlineScanButton(
            onTap: () {
              Share.share(scan.value);
            },
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.share),
                Text(
                  AppLocalizations.of(context)!.shareScan,
                ),
              ],
            ),
          ),
          OutlineScanButton(
            onTap: () async {
              if (scan.type == 'geo') {
                try {
                  Navigator.pushNamed(
                    context,
                    MAPS_ROUTE,
                    arguments: scan,
                  );
                } catch (error) {
                  customSnackBar(
                    message: AppLocalizations.of(context)!.launchErrorMsg,
                  );
                }
              } else {
                bool success = await launchScanIfPossible(scan);
                if (!success) {
                  customSnackBar(
                    message: AppLocalizations.of(context)!.launchErrorMsg,
                  );
                }
              }
            },
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.open_in_browser_rounded),
                Text(
                  AppLocalizations.of(context)!.tryOpenScan,
                ),
              ],
            ),
          ),
          OutlineScanButton(
            onTap: () {
              deleteScanAction(scan);
            },
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_forever),
                Text(
                  AppLocalizations.of(context)!.deleteScan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
