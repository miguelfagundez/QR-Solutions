import 'package:flutter/material.dart';
import 'package:qr_solutions/src/services/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

// Inserting a new QR in DB
  newScan(String value) async {
    final scan = ScanModel(value: value);
    final id = await DBProvider.db.insertScan(scan);

    scan.id = id;
    scans.add(scan);

    // Update UI
    notifyListeners();
  }

  loadScans() async {
    final tempScans = await DBProvider.db.getScans();
    scans = [...tempScans];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    scans = [];
    loadScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }
}
