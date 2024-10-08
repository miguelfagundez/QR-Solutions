import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:qr_solutions/src/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_solutions/src/models/scan_model.dart';
export 'package:qr_solutions/src/models/scan_model.dart';

class DBProvider {
  // ignore: unused_field
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();

    return _database;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    final path = join(directory.path, Constants.databaseName);

    if (kDebugMode) {
      print(path);
    }

    return await openDatabase(
      path,
      version: Constants.databaseVersion,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        )
        ''');
      },
    );
  }

  Future<int?> insertScanRaw(ScanModel model) async {
    final id = model.id;
    final scanType = model.type;
    final scanValue = model.value;

    final db = await database;

    final result = db?.rawInsert('''
      INSERT INTO Scans( id, type, value )
        VALUES( $id, $scanType, $scanValue)
    ''');

    return result;
  }

  Future<int?> insertScan(ScanModel model) async {
    final db = await database;
    final result = db?.insert('Scans', model.toMap());

    return result;
  }

  // SELECT registers
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final result = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);

    ScanModel? scan;

    // return result!.isNotEmpty ? ScanModel.fromMap(result.first) : null;
    if (result != null) {
      if (result.isNotEmpty) {
        scan = ScanModel.fromMap(result.first);
      }
    }

    return scan;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final result = await db?.query('Scans');

    List<ScanModel> scans = [];

    if (result != null) {
      if (result.isNotEmpty) {
        scans = result.map((e) => ScanModel.fromMap(e)).toList();
      }
    }

    return scans;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final result =
        await db?.query('Scans', where: 'type = ?', whereArgs: [type]);

    List<ScanModel> scans = [];

    if (result != null) {
      if (result.isNotEmpty) {
        scans = result.map((e) => ScanModel.fromMap(e)).toList();
      }
    }

    return scans;
  }

  // Update scans
  Future<int?> updateScan(ScanModel scan) async {
    final db = await database;
    final result = await db
        ?.update('Scans', scan.toMap(), where: 'id = ?', whereArgs: [scan.id]);

    return result;
  }

  // Delete scans
  Future<int?> deleteScan(int id) async {
    final db = await database;
    final result = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int?> deleteAllScans() async {
    final db = await database;
    //final result = await db?.delete('Scans');
    final result = await db?.rawDelete('''
      DELETE FROM Scans
    ''');

    return result;
  }
}
