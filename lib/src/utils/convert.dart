import 'package:flutter/material.dart';

String convertType(String type) {
  switch (type) {
    case 'http':
      return 'Web';
    case 'geo':
      return 'Geo';
    case 'phone':
      return 'Phone';
    case 'email':
      return 'Email';
    default:
      return 'Other';
  }
}

IconData convertTypeToIcon(String type) {
  switch (type) {
    case 'http':
      return Icons.web_asset;
    case 'geo':
      return Icons.map;
    case 'phone':
      return Icons.phone;
    case 'email':
      return Icons.email_outlined;
    default:
      return Icons.archive_outlined;
  }
}
