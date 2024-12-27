import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:qr_solutions/share/presentation/widgets/custom_snackbar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    BlocProvider.of<ScanBloc>(context, listen: false).add(GetAllScansEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ScanBloc, ScanState>(builder: (_, state) {
        return (state.listOfScans?.isNotEmpty ?? false)
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
                      BlocProvider.of<ScanBloc>(context, listen: false)
                          .add(DeleteScanEvent(id: item!.id!));

                      customSnackBar(
                        message: AppLocalizations.of(context)!
                            .confirmDeleteOneScanBody,
                        snackBarAction: SnackBarAction(
                          label: AppLocalizations.of(context)!.undo,
                          onPressed: () {
                            // Code to execute.
                            // return item into database
                            BlocProvider.of<ScanBloc>(context, listen: false)
                                .add(InsertScanEvent(scan: item));
                          },
                        ),
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(AppLocalizations.of(context)!
                      //         .confirmDeleteAllScansBody),
                      //     duration: const Duration(seconds: 3),
                      //     action: SnackBarAction(
                      //       label: AppLocalizations.of(context)!.undo,
                      //       onPressed: () {
                      //         // Code to execute.
                      //         // return item into database
                      //         debugPrint('item.id=${item?.id}');
                      //         debugPrint('item.value=${item?.value}');
                      //         debugPrint('item.type=${item?.type}');
                      //         BlocProvider.of<ScanBloc>(context, listen: false)
                      //             .add(InsertScanEvent(scan: item));
                      //       },
                      //     ),
                      //   ),
                      // );
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
                        // color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        item?.value ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(convertUiType(item?.type ?? '')),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SCAN_DETAILS_ROUTE,
                            arguments: item);
                        //launchScanIfPossible(context, item!);
                      },
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context)!.noScanInDatabase,
                ),
              );
      }),
    );
  }
}
