import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

launchWebsite(String website) async {
  final url = website;
  final uriUrl = Uri.parse(url);
  // Checking open website
  if (await canLaunchUrl(uriUrl)) {
    await launchUrl(uriUrl);
  } else {
    if (kDebugMode) {
      print('Could not launch $url');
    }
    throw 'Could not launch $url';
  }
}

launchEmail(String email) async {
  final uriEmail = Uri.parse('mailto:$email?subject=Subject&body=Body');
  // Checking open email
  if (await canLaunchUrl(uriEmail)) {
    await launchUrl(uriEmail);
  } else {
    if (kDebugMode) {
      print('Could not launch $uriEmail');
    }
    throw 'Could not launch $uriEmail';
  }
}

launchPhone(String phoneNumber) async {
  final uriPhone = Uri.parse('tel:$phoneNumber');
  // Checking open phone number
  if (await canLaunchUrl(uriPhone)) {
    await launchUrl(uriPhone);
  } else {
    if (kDebugMode) {
      print('Could not launch $uriPhone');
    }
    throw 'Could not launch $uriPhone';
  }
}

launchScanIfPossible(Scan scan) async {
  if (scan.type == 'http') {
    debugPrint('It is a website..');
    launchWebsite(scan.value);
  } else if (scan.type == 'email') {
    debugPrint('It is a email address..');
    launchEmail(scan.value);
  } else if (scan.type == 'phone') {
    debugPrint('It is a phone number..');
    launchPhone(scan.value);
  } else if (scan.type == 'geo') {
    debugPrint('It is a map..');
    customSnackBar(message: 'It is a map..');
  } else {
    debugPrint('It is another format..');
    customSnackBar(message: 'It is another format..');
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
