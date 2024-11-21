import 'package:flutter/material.dart';

class CustomScanButton extends StatelessWidget {
  const CustomScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.camera_alt_outlined,
        color: Colors.white60,
      ),
      onPressed: () async {},
    );
  }
}
