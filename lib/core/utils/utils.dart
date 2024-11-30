import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_solutions/core/utils/scan_types.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:url_launcher/url_launcher.dart';

launchScanIfPossible(BuildContext context, Scan scan) async {
  if (scan.type == 'http') {
    debugPrint('It is a website..');
    final url = scan.value;
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
  } else if (scan.type == 'email') {
    debugPrint('It is a email address..');
    final uriEmail =
        Uri.parse('mailto:${scan.value}?subject=Subject&body=Body');
    // Checking open email
    if (await canLaunchUrl(uriEmail)) {
      await launchUrl(uriEmail);
    } else {
      if (kDebugMode) {
        print('Could not launch $uriEmail');
      }
      throw 'Could not launch $uriEmail';
    }
  } else if (scan.type == 'phone') {
    debugPrint('It is a phone number..');
    final uriPhone = Uri.parse('tel:${scan.value}');
    // Checking open phone number
    if (await canLaunchUrl(uriPhone)) {
      await launchUrl(uriPhone);
    } else {
      if (kDebugMode) {
        print('Could not launch $uriPhone');
      }
      throw 'Could not launch $uriPhone';
    }
  } else if (scan.type == 'geo') {
    debugPrint('It is a map..');
    debugPrint('The scan.type = ${scan.type}');
    debugPrint('The scan.value = ${scan.value}');
  } else {
    debugPrint('It is another format..');
    debugPrint('The scan.type = ${scan.type}');
    debugPrint('The scan.value = ${scan.value}');
  }
}
