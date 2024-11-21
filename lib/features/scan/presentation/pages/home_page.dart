import 'package:flutter/material.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_navegation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          APP_NAME,
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!
                      .confirmTitle), //Text('Confirm'),
                  content: Text(AppLocalizations.of(context)!.confirmBody),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.yes)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.no)),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
