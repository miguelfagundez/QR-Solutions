import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';
import 'package:qr_solutions/share/presentation/widgets/outline_scan_button.dart';

class CreateQrWidget extends StatefulWidget {
  const CreateQrWidget({super.key});

  @override
  State<CreateQrWidget> createState() => _QrCreatorState();
}

final listOfScanTypes = returnListOfScanTypes();

class _QrCreatorState extends State<CreateQrWidget> {
  String userScanType = listOfScanTypes.first;
  String databaseScanType = convertDatabaseType(listOfScanTypes.first);
  final myController = TextEditingController();
  bool isWeb = false;
  bool isPhone = false;
  final String https = 'https://';

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(builder: (context, state) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  myController.text = value;
                });
              },
              controller: myController,
              keyboardType:
                  (isPhone) ? TextInputType.phone : TextInputType.text,
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
                  isWeb = false;
                  isPhone = false;
                  if (value == 'Web') {
                    isWeb = true;
                  } else {
                    if (value == 'Phone') {
                      isPhone = true;
                    }
                  }
                  userScanType = value!;
                  databaseScanType = convertDatabaseType(userScanType);
                  myController.text = '';
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
            (myController.text == null)
                ? Container()
                : (myController.text.isEmpty)
                    ? Container()
                    : QrImageView(
                        data: myController.text.toString(),
                        version: QrVersions.auto,
                        size: 250.0,
                      ),
            const SizedBox(
              height: 25,
            ),
            OutlineScanButton(
              onTap: (myController.text == null)
                  ? null
                  : (myController.text.isEmpty)
                      ? null
                      : () {
                          // Save scan value & type
                          //Saving ..
                          String tmp = myController.text;
                          if (isWeb && !tmp.contains(https)) {
                            myController.text = https + myController.text;
                          }
                          final Scan scan = Scan(
                            value: myController.text.toString(),
                            type: databaseScanType,
                          );

                          BlocProvider.of<ScanBloc>(context)
                              .add(InsertScanEvent(scan: scan));
                          customSnackBar(
                              message: AppLocalizations.of(context)!
                                  .saveScanSuccess);
                          setState(() {
                            myController.text = '';
                            userScanType = listOfScanTypes.first;
                          });
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
    });
  }
}
