import 'package:flutter/material.dart';
import 'settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);
  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isActive = false;

  @override
  void initState() {
    widget.controller.loadSettingsBool().then((value) => {
      setState(() {
        isActive = value;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const Center(
              child: Text('Settings'),
            ),
            Row(
              children: [
                const Text('Dark theme:'),
                Switch(
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        widget.controller.updateThemeMode(ThemeMode.dark);
                      } else {
                        widget.controller.updateThemeMode(ThemeMode.light);
                      }
                      isActive = value;
                    });
                  },
                  activeTrackColor: Colors.yellow,
                  activeColor: Colors.orangeAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
