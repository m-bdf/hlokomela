library my_cache_manager;

import 'package:shared_preferences/shared_preferences.dart';

class MyCacheManager {

  static Future<bool?> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool? res = prefs.getBool(key);
    if (res != null) {
      return res;
    } else {
      return null;
    }
  }

  static Future writeBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<int?> readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? res = prefs.getInt(key);
    if (res != null) {
      return res;
    } else {
      return null;
    }
  }

  static Future writeInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("profile", value);
  }

  static Future<String?> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString(key);
    if (res != null) {
      return res;
    } else {
      return null;
    }
  }

  static Future writeString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("profile", value);
  }
}