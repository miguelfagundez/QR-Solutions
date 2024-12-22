import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/enums.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';
import 'package:qr_solutions/features/settings/presentation/bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _languageItem = Languages.en.value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // BlocProvider.of<SettingsBloc>(context, listen: false)
    //     .add(GetDarkModeEvent());
    BlocProvider.of<SettingsBloc>(context, listen: false)
        .add(GetSettingsEvent());
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
                  value: state.settings?.isDarkMode ?? false,
                  onChanged: (value) {
                    setState(() {
                      // BlocProvider.of<SettingsBloc>(context, listen: false)
                      //     .add(ChangeDarkModeEvent(isDarkMode: value));
                      BlocProvider.of<SettingsBloc>(context, listen: false)
                          .add(ChangeSettingsEvent(
                        settings: Settings(
                          isDarkMode: value,
                          openWebAutomatically:
                              state.settings?.openWebAutomatically ?? false,
                          openEmailAutomatically:
                              state.settings?.openEmailAutomatically ?? false,
                          openPhoneAutomatically:
                              state.settings?.openPhoneAutomatically ?? false,
                          language: state.settings?.language ?? 'en',
                        ),
                      ));
                    });
                  },
                ),
                const Divider(),
                Column(
                  children: [
                    const ListTile(
                      title: Text('Languages:'),
                    ),
                    RadioListTile<String>(
                      value: Languages.en.value,
                      groupValue: _languageItem,
                      onChanged: (String? value) {
                        setState(() {
                          _languageItem = value.toString();
                          debugPrint('English: $value');
                        });
                      },
                      title: const Text('English'),
                      subtitle: const Text('Default language'),
                    ),
                    RadioListTile<String>(
                      value: Languages.es.value,
                      groupValue: _languageItem,
                      onChanged: (String? value) {
                        setState(() {
                          _languageItem = value.toString();
                          debugPrint('Spanish: $value');
                        });
                      },
                      title: const Text('Spanish'),
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  title: Text(
                      '${AppLocalizations.of(context)!.openAutomatically}:'),
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.website),
                  value: state.settings?.openWebAutomatically ?? false,
                  onChanged: (value) {},
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.email),
                  value: state.settings?.openEmailAutomatically ?? false,
                  onChanged: (value) {},
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.phone),
                  value: state.settings?.openPhoneAutomatically ?? false,
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
