import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/share/presentation/widgets/outline_scan_button.dart';

class ScanDataForm extends StatefulWidget {
  final Scan scan;

  ScanDataForm({
    super.key,
    required this.scan,
  });

  @override
  State<ScanDataForm> createState() => _ScanDataFormState();
}

class _ScanDataFormState extends State<ScanDataForm> {
  // This is a GlobalKey
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  late TextEditingController myControllerValue;
  late TextEditingController myControllerType;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerValue.dispose();
    myControllerType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String scanValue = widget.scan.value;
    myControllerValue = TextEditingController(text: widget.scan.value);
    myControllerType =
        TextEditingController(text: convertUiType(widget.scan.type!));

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: myControllerValue,
            onChanged: (value) => scanValue = value,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: myControllerType,
            onChanged: (value) => scanValue = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text2';
              }
              return null;
            },
          ),
          OutlineScanButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar..
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data Correctly')),
                );
              }
            },
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save),
                Text(
                  AppLocalizations.of(context)!.saveScanInDatabase,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
