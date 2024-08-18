// To parse this JSON data, do
//
//     final scanModel = scanModelFromMap(jsonString);

import 'dart:convert';

import 'package:qr_solutions/src/models/scan_types.dart';

ScanModel scanModelFromMap(String str) => ScanModel.fromMap(json.decode(str));

String scanModelToMap(ScanModel data) => json.encode(data.toMap());

class ScanModel {
  int? id;
  String? type;
  String value;

  ScanModel({
    required this.value,
    this.id,
    this.type,
  }) {
    if (value.contains(ScanTypes.http.value)) {
      type = ScanTypes.http.name;
    } else {
      if (value.contains(ScanTypes.geo.value)) {
        type = ScanTypes.geo.name;
      } else {
        if (value.contains(ScanTypes.phone.value)) {
          type = ScanTypes.phone.name;
        } else {
          if (value.contains(ScanTypes.email.value)) {
            type = ScanTypes.email.name;
          } else {
            type = ScanTypes.other.name;
          }
        }
      }
    }
  }

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "value": value,
      };
}
