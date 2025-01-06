import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_solutions/core/utils/enums.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchWebsite(String website) async {
  final url = website;
  final uriUrl = Uri.parse(url);
  // Checking open website
  if (await canLaunchUrl(uriUrl)) {
    await launchUrl(uriUrl);
  } else {
    if (kDebugMode) {
      print('Could not launch $url');
    }
    //throw 'Could not launch $url';
    return false;
  }
  return true;
}

Future<bool> launchEmail(String email) async {
  final uriEmail = Uri.parse('mailto:$email?subject=Subject&body=Body');
  // Checking open email
  if (await canLaunchUrl(uriEmail)) {
    await launchUrl(uriEmail);
  } else {
    if (kDebugMode) {
      print('Could not launch $uriEmail');
    }
    //throw 'Could not launch $uriEmail';
    return false;
  }
  return true;
}

Future<bool> launchPhone(String phoneNumber) async {
  final uriPhone = Uri.parse('tel:$phoneNumber');
  // Checking open phone number
  if (await canLaunchUrl(uriPhone)) {
    await launchUrl(uriPhone);
  } else {
    if (kDebugMode) {
      print('Could not launch $uriPhone');
    }
    //throw 'Could not launch $uriPhone';
    return false;
  }
  return true;
}

Future<bool> launchScanIfPossible(Scan scan) async {
  if (scan.type == 'http') {
    debugPrint('It is a website..');
    return launchWebsite(scan.value);
  } else if (scan.type == 'email') {
    debugPrint('It is a email address..');
    return launchEmail(scan.value);
  } else if (scan.type == 'phone') {
    debugPrint('It is a phone number..');
    return launchPhone(scan.value);
  } else {
    // geo format is being checked outside
    debugPrint('It is another format..');
    customSnackBar(message: 'It is another format..');
    return true;
  }
}

String convertUiType(String type) {
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

String convertDatabaseType(String type) {
  switch (type) {
    case 'Web':
      return ScanTypes.http.name;
    case 'Geo':
      return ScanTypes.geo.name;
    case 'Phone':
      return ScanTypes.phone.name;
    case 'Email':
      return ScanTypes.email.name;
    default:
      return ScanTypes.other.name;
  }
}

IconData convertUiTypeToIcon(String type) {
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

List<String> returnListOfScanTypes() {
  return <String>['Other', 'Web', 'Phone', 'Geo', 'Email'];
}
