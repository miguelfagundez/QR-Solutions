import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/scan/data/models/scan_model.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/scan.dart';

abstract class ScanSqliteDataSource {
  Future<Database?> openScanDatabase();
  Future<int?> insertScan(Scan model);
  Future<ScanModel?> getScan(int id);
  Future<List<ScanModel>> getAllScans();
  Future<int?> updateScan(Scan scan);
  Future<int?> deleteScan(int id);
  Future<int?> deleteAllScans();
}

class ScanSqliteDataSourceImpl implements ScanSqliteDataSource {
  static Database? _database;

  ScanSqliteDataSourceImpl();

  static final ScanSqliteDataSourceImpl db = ScanSqliteDataSourceImpl._();
  ScanSqliteDataSourceImpl._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await openScanDatabase();

    return _database;
  }

  @override
  Future<int?> deleteAllScans() async {
    try {
      final db = await database;
      final res = await db?.delete('Scans');
      return res;
    } catch (error) {
      debugPrint(error.toString());
      throw (LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<int?> deleteScan(int id) async {
    try {
      final db = await database;
      final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);
      return res;
    } catch (error) {
      debugPrint(error.toString());
      throw (LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<List<ScanModel>> getAllScans() async {
    try {
      final db = await database;
      final res = await db?.query('Scans');

      if (res != null) {
        return res.isNotEmpty
            ? res.map((s) => ScanModel.fromJson(s)).toList()
            : [];
      } else {
        return [];
      }
    } catch (error) {
      debugPrint(error.toString());
      throw (LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<ScanModel?> getScan(int id) async {
    try {
      final db = await database;
      final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);

      if (res != null) {
        return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
      } else {
        return null;
      }
    } catch (error) {
      debugPrint(error.toString());
      throw (LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<int?> insertScan(Scan scan) async {
    try {
      final db = await database;
      final res =
          await db?.insert('Scans', ScanModel.fromEntity(scan).toJson());

      // Es el ID del último registro insertado;
      return res;
    } catch (error) {
      debugPrint(error.toString());
      throw (LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }

  @override
  Future<Database?> openScanDatabase() async {
    // Database path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, DATABASE_NAME);
    if (kDebugMode) {
      print(path);
    }

    // Database creation
    return await openDatabase(path, version: DATABASE_VERSION, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
    });
  }

  @override
  Future<int?> updateScan(Scan scan) async {
    try {
      final db = await database;
      final res = await db?.update('Scans', ScanModel.fromEntity(scan).toJson(),
          where: 'id = ?', whereArgs: [scan.id]);

      return res;
    } catch (error) {
      debugPrint(error.toString());
      throw (LocalDataBaseFailure(message: error.toString(), code: ''));
    }
  }
}
