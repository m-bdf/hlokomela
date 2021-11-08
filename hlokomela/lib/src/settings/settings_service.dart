import 'package:flutter/material.dart';
import 'package:my_cache_manager/my_cache_manager.dart';

class SettingsService {

  Future<ThemeMode> themeMode() async {
    bool? value =  await MyCacheManager.readBool("ThemeIsDark");
    if (value == null) {
      MyCacheManager.writeBool("ThemeIsDark", false);
      return ThemeMode.light;
    } else {
      if (value == true) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    }
  }

  Future<bool> themeModeBoolean() async {
    bool? value =  await MyCacheManager.readBool("ThemeIsDark");
    if (value == null) {
      MyCacheManager.writeBool("ThemeIsDark", false);
      return false;
    } else {
      return value;
    }
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    if (theme == ThemeMode.dark) {
      await MyCacheManager.writeBool("ThemeIsDark", true);
    } else {
      await MyCacheManager.writeBool("ThemeIsDark", false);
    }
  }
}
