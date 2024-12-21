import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  title: const Text('Dark Mode'),
                  value: state.isDarkMode!,
                  onChanged: (value) {
                    setState(() {
                      BlocProvider.of<SettingsBloc>(context, listen: false)
                          .add(ChangeDarkModeEvent(isDarkMode: value));
                    });
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        )),
      );
    });
  }
}
