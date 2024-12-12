import '../../../../core/utils/scan_types.dart';

class Scan {
  int? id;
  String? type;
  String value;

  Scan({
    required this.value,
    this.id,
    this.type,
  }) {
    if (type == null) {
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
  }
}
