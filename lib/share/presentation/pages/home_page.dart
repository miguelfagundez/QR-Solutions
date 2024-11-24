import 'package:flutter/material.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_navegation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_scan_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

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
                  title: Text(AppLocalizations.of(context)!.confirmTitle),
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
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                items.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.confirmBody),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: AppLocalizations.of(context)!.undo,
                    onPressed: () {
                      // Code to execute.
                      setState(() {
                        items.add('New Item ${index + 1}');
                      });
                    },
                  ),
                ),
              );
            },
            // Show a red background with icon as the item is swiped away.
            background: Container(
              color: Colors.redAccent,
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
            ),
            child: ListTile(
              title: Text(item),
              // ignore: avoid_print
              onTap: () => print(item),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
