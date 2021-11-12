import 'package:flutter/material.dart';

//in development
class DarkThemeData {
  static getThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.amber,
      fontFamily: 'Georgia',
    );
  }
}
