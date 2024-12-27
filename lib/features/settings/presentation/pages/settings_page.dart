import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_solutions/core/utils/enums.dart';
import 'package:qr_solutions/core/utils/utils.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';
import 'package:qr_solutions/features/settings/presentation/bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _languageItem;

  @override
  void initState() {
    BlocProvider.of<SettingsBloc>(context, listen: false)
        .add(GetSettingsEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _languageItem = BlocProvider.of<SettingsBloc>(context, listen: false)
            .state
            .settings
            ?.language ??
        APP_LANGUAGE_DEFAULT;
    debugPrint(
        'didChangeDependencies (SettingsPage) - _languageItem = $_languageItem');
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
                      debugPrint('');
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
                          language:
                              state.settings?.language ?? APP_LANGUAGE_DEFAULT,
                        ),
                      ));
                    });
                  },
                ),
                const Divider(),
                Column(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.appLanguage),
                    ),
                    RadioListTile<String>(
                      value: Languages.en.value,
                      groupValue: _languageItem,
                      onChanged: (String? value) {
                        setState(() {
                          _languageItem = value.toString();
                          BlocProvider.of<SettingsBloc>(context, listen: false)
                              .add(ChangeSettingsEvent(
                            settings: Settings(
                              isDarkMode: state.settings?.isDarkMode ?? false,
                              openWebAutomatically:
                                  state.settings?.openWebAutomatically ?? false,
                              openEmailAutomatically:
                                  state.settings?.openEmailAutomatically ??
                                      false,
                              openPhoneAutomatically:
                                  state.settings?.openPhoneAutomatically ??
                                      false,
                              language: value ?? APP_LANGUAGE_DEFAULT,
                            ),
                          ));
                          debugPrint('English: $value');
                        });
                      },
                      title: Text(AppLocalizations.of(context)!.english),
                      subtitle:
                          Text(AppLocalizations.of(context)!.defaultLanMsg),
                    ),
                    RadioListTile<String>(
                      value: Languages.es.value,
                      groupValue: _languageItem,
                      onChanged: (String? value) {
                        setState(() {
                          _languageItem = value.toString();
                          BlocProvider.of<SettingsBloc>(context, listen: false)
                              .add(ChangeSettingsEvent(
                            settings: Settings(
                              isDarkMode: state.settings?.isDarkMode ?? false,
                              openWebAutomatically:
                                  state.settings?.openWebAutomatically ?? false,
                              openEmailAutomatically:
                                  state.settings?.openEmailAutomatically ??
                                      false,
                              openPhoneAutomatically:
                                  state.settings?.openPhoneAutomatically ??
                                      false,
                              language: value ?? APP_LANGUAGE_DEFAULT,
                            ),
                          ));
                          debugPrint('Spanish: $value');
                        });
                      },
                      title: Text(AppLocalizations.of(context)!.spanish),
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
                  onChanged: (value) {
                    // -- Website --
                    setState(() {
                      BlocProvider.of<SettingsBloc>(context, listen: false)
                          .add(ChangeSettingsEvent(
                        settings: Settings(
                          isDarkMode: state.settings?.isDarkMode ?? false,
                          openWebAutomatically: value,
                          openEmailAutomatically:
                              state.settings?.openEmailAutomatically ?? false,
                          openPhoneAutomatically:
                              state.settings?.openPhoneAutomatically ?? false,
                          language:
                              state.settings?.language ?? APP_LANGUAGE_DEFAULT,
                        ),
                      ));
                    });
                  },
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.email),
                  value: state.settings?.openEmailAutomatically ?? false,
                  onChanged: (value) {
                    // -- Email --
                    setState(() {
                      BlocProvider.of<SettingsBloc>(context, listen: false)
                          .add(ChangeSettingsEvent(
                        settings: Settings(
                          isDarkMode: state.settings?.isDarkMode ?? false,
                          openWebAutomatically:
                              state.settings?.openWebAutomatically ?? false,
                          openEmailAutomatically: value,
                          openPhoneAutomatically:
                              state.settings?.openPhoneAutomatically ?? false,
                          language:
                              state.settings?.language ?? APP_LANGUAGE_DEFAULT,
                        ),
                      ));
                    });
                  },
                ),
                SwitchListTile.adaptive(
                  title: Text(AppLocalizations.of(context)!.phone),
                  value: state.settings?.openPhoneAutomatically ?? false,
                  onChanged: (value) {
                    // -- Phone --
                    setState(() {
                      BlocProvider.of<SettingsBloc>(context, listen: false)
                          .add(ChangeSettingsEvent(
                        settings: Settings(
                          isDarkMode: state.settings?.isDarkMode ?? false,
                          openWebAutomatically:
                              state.settings?.openWebAutomatically ?? false,
                          openEmailAutomatically:
                              state.settings?.openEmailAutomatically ?? false,
                          openPhoneAutomatically: value,
                          language:
                              state.settings?.language ?? APP_LANGUAGE_DEFAULT,
                        ),
                      ));
                    });
                  },
                ),
                const Divider(),
                GestureDetector(
                  child: ListTile(
                    title: Text(
                        '${AppLocalizations.of(context)!.share} ${AppLocalizations.of(context)!.appTitle}'),
                    trailing: const Icon(Icons.share_rounded),
                  ),
                  onTap: () {
                    launchWebsite(APP_WEB_SHARE_GOOGLE_PLAY);
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.privacy),
                    trailing: const Icon(Icons.privacy_tip_outlined),
                  ),
                  onTap: () {
                    launchWebsite(APP_WEB_PRIVACY_POLICY);
                  },
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
