import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/src/services/providers/ui_state.dart';
import 'package:provider/provider.dart';

class CustomNavigationButton extends StatelessWidget {
  const CustomNavigationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiState = Provider.of<UiState>(context);
    final index = uiState.indexSelected;

    return BottomNavigationBar(
      currentIndex: index,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        // BottomNavigationBarItem(
        //   icon: const Icon(Icons.home),
        //   label: AppLocalizations.of(context)!.home, //'Home',
        // ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.create),
          label: AppLocalizations.of(context)!.creator,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.history),
          label: AppLocalizations.of(context)!.history,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settings,
        )
      ],
      onTap: (index) {
        uiState.indexSelected = index;
      },
    );
  }
}
