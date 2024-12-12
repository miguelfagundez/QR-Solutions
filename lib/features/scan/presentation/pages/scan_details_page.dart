import 'package:flutter/material.dart';
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
    // TODO: implement didChangeDependencies
    scan = (ModalRoute.of(context)!.settings.arguments) as Scan;
    debugPrint('item.id=${scan.id}');
    debugPrint('item.value=${scan.value}');
    debugPrint('item.type=${scan.type}');
    super.didChangeDependencies();
  }

  void DeleteScanAction(int itemId) {
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
                  DeleteScanEvent(id: itemId),
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
              DeleteScanAction(scan.id!);
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
              launchScanIfPossible(context, scan);
            },
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_forever),
                Text(
                  AppLocalizations.of(context)!.tryOpenScan,
                ),
              ],
            ),
          ),
          OutlineScanButton(
            onTap: () {
              DeleteScanAction(scan.id!);
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
