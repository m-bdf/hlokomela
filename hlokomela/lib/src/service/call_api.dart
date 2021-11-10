import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_manager/network_manager.dart';

class CallApi {
  static String? token;

  static Future<dynamic> get(BuildContext context, String route, {Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    return jsonDecode(await NetworkManager.get(context, route, headers: headers));
  }

  static Future<dynamic> post(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    return jsonDecode(await NetworkManager.post(context, route, body : body, headers : headers));
  }

  static Future<dynamic> put(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    return jsonDecode(await NetworkManager.put(context, route, body : body, headers : headers));
  }

  static Future<dynamic> delete(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    return jsonDecode(await NetworkManager.delete(context, route, body : body, headers : headers));
  }
}