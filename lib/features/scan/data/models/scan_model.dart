import 'package:qr_solutions/features/scan/domain/entities/scan.dart';

class ScanModel extends Scan {
  ScanModel({
    required super.value,
    super.id,
    super.type,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      id: json["id"],
      type: json["type"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "value": value,
    };
  }
}
