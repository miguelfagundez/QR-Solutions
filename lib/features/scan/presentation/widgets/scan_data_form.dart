import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:qr_solutions/core/utils/enums.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/domain/entities/scan.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';
import 'package:qr_solutions/share/presentation/widgets/outline_scan_button.dart';

class ScanDataForm extends StatefulWidget {
  final Scan scan;

  const ScanDataForm({
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
  late String? newscanType;
  bool isWeb = false;
  final String https = 'https://';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (widget.scan.type == 'http') {
      isWeb = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myControllerValue = TextEditingController(text: widget.scan.value);
    newscanType = widget.scan.type;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderTextField(
            name: 'name',
            controller: myControllerValue,
            minLines: 1,
            maxLines: 10,
            validator: FormBuilderValidators.required(),
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.scanValueTitle),
            ),
          ),
          FormBuilderDropdown<String>(
            name: 'Types',
            initialValue: newscanType,
            validator: FormBuilderValidators.required(),
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.scanTypeTitle),
            ),
            onChanged: (value) {
              isWeb = false;
              newscanType = value;
              if (value == 'http') {
                isWeb = true;
              }
            },
            items: [
              DropdownMenuItem(
                value: ScanTypes.http.name,
                child: Text(convertUiType(ScanTypes.http.name)),
              ),
              DropdownMenuItem(
                value: ScanTypes.phone.name,
                child: Text(convertUiType(ScanTypes.phone.name)),
              ),
              DropdownMenuItem(
                value: ScanTypes.geo.name,
                child: Text(convertUiType(ScanTypes.geo.name)),
              ),
              DropdownMenuItem(
                value: ScanTypes.email.name,
                child: Text(convertUiType(ScanTypes.email.name)),
              ),
              DropdownMenuItem(
                value: ScanTypes.other.name,
                child: Text(convertUiType(ScanTypes.other.name)),
              ),
            ],
          ),
          // TextFormField(
          //   controller: myControllerValue,
          //   onChanged: (value) => scanValue = value,
          //   // The validator receives the text that the user has entered.
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'This field cannot be empty.';
          //     }
          //     return null;
          //   },
          // ),
          OutlineScanButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar..
                customSnackBar(
                    message: AppLocalizations.of(context)!.saveScanSuccess);
                String tmp = myControllerValue.text;
                if (isWeb && !tmp.contains(https)) {
                  myControllerValue.text = https + myControllerValue.text;
                }

                Scan newScan = Scan(value: '');
                newScan.id = widget.scan.id;
                newScan.value = myControllerValue.text;
                newScan.type = newscanType;

                BlocProvider.of<ScanBloc>(context, listen: false).add(
                  UpdateScanEvent(scan: newScan),
                );
                Navigator.pop(context);
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
