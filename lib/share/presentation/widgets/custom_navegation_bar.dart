import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/share/presentation/bloc/ui/ui_bloc.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UiBloc, UiState>(builder: (_, state) {
      return BottomNavigationBar(
        currentIndex: state.indexSelected,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: AppLocalizations.of(context)!.history,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: AppLocalizations.of(context)!.creator,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          )
        ],
        onTap: (index) {
          BlocProvider.of<UiBloc>(context, listen: false)
              .add(IndexSelectedEvent(indexSelected: index));
          // TODO - Delete - Testing purposes
          if (index == 0) {
            debugPrint('index 0 - Historical page');
          } else {
            debugPrint('index 1 - Settings page');
          }
        },
      );
    });
  }
}
