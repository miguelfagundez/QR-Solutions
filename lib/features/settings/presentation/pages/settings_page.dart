import 'package:flutter/material.dart';
import 'package:qr_solutions/features/settings/data/datasources/settings_preferences_data_source.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // TODO Temporal - testing purposes
  late bool option;
  final prefs = SettingsPreferencesDataSourceImpl();

  @override
  void initState() {
    option = false;
    debugPrint('initState - option = $option');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    option = prefs.getDarkMode();
    debugPrint('didChangeDependencies - option = $option');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              SwitchListTile.adaptive(
                value: prefs.getDarkMode(),
                onChanged: (value) {
                  setState(() {
                    option = value;
                    prefs.setDarkMode(value);
                    debugPrint('setState - value = $value');
                  });
                },
              ),
              const Divider(),
            ],
          ),
        ),
      )),
    );
  }
}
