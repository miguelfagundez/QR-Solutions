import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQrWidget extends StatefulWidget {
  const CreateQrWidget({super.key});

  @override
  State<CreateQrWidget> createState() => _QrCreatorState();
}

class _QrCreatorState extends State<CreateQrWidget> {
  String? userInput;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                userInput = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Insert a value',
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          (userInput != null)
              ? QrImageView(
                  data: userInput.toString(),
                  version: QrVersions.auto,
                  size: 250.0,
                )
              : Container(),
        ],
      ),
    );
  }
}
