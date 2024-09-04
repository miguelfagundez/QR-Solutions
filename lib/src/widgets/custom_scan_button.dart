import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_solutions/src/services/providers/scans_provider.dart';

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
        // String response = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancel',
        //   false,
        //   ScanMode.QR,
        // );

        // if (kDebugMode) {
        //   print(response);
        // }

        const resultWeb = 'https://miguelfagundez.com';
        const resultEmail = 'info@miguelfagundez.com';
        const resultPhone = '+1 523 523 6987';
        const resultGeo = 'geo(1.25,2.36)';
        const resultOther = 'Another type of data';

        final scanProvider = Provider.of<ScanProvider>(context, listen: false);
        scanProvider.newScan(resultWeb);
        scanProvider.newScan(resultEmail);
        scanProvider.newScan(resultPhone);
        scanProvider.newScan(resultGeo);
        scanProvider.newScan(resultOther);
        // scanProvider.deleteAllScans();
      },
    );
  }
}
