import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/features/settings/presentation/bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<SettingsBloc>(context, listen: false)
        .add(GetDarkModeEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (conext, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.settings,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 32,
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.darkMode),
                  value: state.isDarkMode!,
                  onChanged: (value) {
                    setState(() {
                      BlocProvider.of<SettingsBloc>(context, listen: false)
                          .add(ChangeDarkModeEvent(isDarkMode: value));
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(
                      '${AppLocalizations.of(context)!.openAutomatically}:'),
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.website),
                  value: state.isDarkMode!,
                  onChanged: (value) {},
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.email),
                  value: state.isDarkMode!,
                  onChanged: (value) {},
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.phone),
                  value: state.isDarkMode!,
                  onChanged: (value) {},
                ),
                const Divider(),
                ListTile(
                  title: Text(
                      '${AppLocalizations.of(context)!.share} ${AppLocalizations.of(context)!.appTitle}'),
                  trailing: const Icon(Icons.share_rounded),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.privacy),
                  trailing: const Icon(Icons.privacy_tip_outlined),
                ),
                ListTile(
                  title: Text('${AppLocalizations.of(context)!.version}: '),
                  trailing: const Text(
                    APP_VERSION,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
