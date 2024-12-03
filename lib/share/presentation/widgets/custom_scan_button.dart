// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';

class CustomScanButton extends StatelessWidget {
  const CustomScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.camera_alt_outlined,
        color: Colors.white60,
      ),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        // final barcodeScanRes = 'geo:45.287135,-75.920226';

        if (barcodeScanRes == '-1') {
          // Check this, it is not an error / Cancel pressed
          return;
        }

        final Scan scan = Scan(value: barcodeScanRes);
        BlocProvider.of<ScanBloc>(context).add(InsertScanEvent(scan: scan));

        launchScanIfPossible(context, scan);
      },
    );
  }
}
