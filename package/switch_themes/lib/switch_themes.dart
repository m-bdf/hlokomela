library switch_themes;

import 'package:flutter/material.dart';
import 'package:my_cache_manager/my_cache_manager.dart';

class SwitchThemes extends StatefulWidget {
  const SwitchThemes({
    Key? key,
  }) : super(key: key);
  static final darkNotifier = ValueNotifier<bool>(false);

  static ValueNotifier<bool> isDark() {
    return darkNotifier;
  }

  @override
  State<SwitchThemes> createState() => _SwitchThemesState();
}

class _SwitchThemesState extends State<SwitchThemes> {

  @override
  void initState() {
    MyCacheManager.readBool("ThemeIsDark").then((value) => {
      setState(() {
        if (value == null) {
          MyCacheManager.writeBool("ThemeIsDark", false);
          SwitchThemes.darkNotifier.value = false;
        } else {
          SwitchThemes.darkNotifier.value = value;
        }
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: SwitchThemes.darkNotifier.value,
      onChanged: (value) {
        setState(() {
          MyCacheManager.writeBool("ThemeIsDark", value);
          SwitchThemes.darkNotifier.value = value;
        });
      },
      activeTrackColor: Colors.yellow,
      activeColor: Colors.orangeAccent,
    );
  }
}