import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import '../../../../core/utils/enums.dart';

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

// Only available for geo values
  LatLng getLatLng() {
    try {
      final latLng = value.substring(4).split(',');

      final latitude = double.parse(latLng[0]);
      final longitude = double.parse(latLng[1]);

      return LatLng(latitude, longitude);
    } catch (error) {
      debugPrint(error.toString());
      return const LatLng(0.0, 0.0);
    }
  }
}
