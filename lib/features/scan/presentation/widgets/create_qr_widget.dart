import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';
import 'package:qr_solutions/share/presentation/widgets/outline_scan_button.dart';

class CreateQrWidget extends StatefulWidget {
  const CreateQrWidget({super.key});

  @override
  State<CreateQrWidget> createState() => _QrCreatorState();
}

final listOfScanTypes = returnListOfScanTypes();

class _QrCreatorState extends State<CreateQrWidget> {
  String? userInput;
  String userScanType = listOfScanTypes.first;

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
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.insertValue,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          DropdownButton<String>(
            value: userScanType,
            elevation: 1,
            isExpanded: true,
            onChanged: (String? value) {
              // This is called when the user selects an scan type.
              setState(() {
                userScanType = value!;
              });
            },
            items:
                listOfScanTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 25,
          ),
          (userInput == null)
              ? Container()
              : (userInput!.isEmpty)
                  ? Container()
                  : QrImageView(
                      data: userInput.toString(),
                      version: QrVersions.auto,
                      size: 250.0,
                    ),
          const SizedBox(
            height: 25,
          ),
          OutlineScanButton(
            onTap: (userInput == null)
                ? null
                : (userInput!.isEmpty)
                    ? null
                    : () {
                        // Save scan value & type
                        //Saving ..
                        customSnackBar(message: 'saving userInput in DB');
                      },
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save_outlined),
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
