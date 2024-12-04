import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ScanBloc, ScanState>(builder: (_, state) {
        return state.isUpdated!
            ? ListView.builder(
                itemCount: state.listOfScans?.length,
                itemBuilder: (context, index) {
                  final item = state.listOfScans?[index];
                  return Dismissible(
                    // Each Dismissible must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    // Provide a function that tells the app
                    // what to do after an item has been swiped away.
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      // setState(() {
                      //   items.removeAt(index);
                      // });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(AppLocalizations.of(context)!.confirmBody),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: AppLocalizations.of(context)!.undo,
                            onPressed: () {
                              // Code to execute.
                              // setState(() {
                              //   items.add('New Item ${index + 1}');
                              // });
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
                      leading: Icon(
                        convertUiTypeToIcon(item?.type ?? ''),
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(item?.value ?? ''),
                      subtitle: Text(convertUiType(item?.type ?? '')),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      onTap: () => debugPrint('${item?.id}'),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No Scans in Database'),
              );
      }),
    );
  }
}
