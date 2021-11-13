import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_manager/network_manager.dart';

class CallApi {
  static String? token;
  static String route =
      "http://4025-2003-cd-7715-2800-3335-3b3f-707c-2853.ngrok.io/";

  static Future<dynamic> get(BuildContext context, String route,
      {Map<String, String>? args, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    if (token != null && headers == null) {
      return jsonDecode(await NetworkManager.get(context, route,
          args: args, headers: {"Authorization": "Bearer " + token!}));
    }
    return jsonDecode(
        await NetworkManager.get(context, route, args: args, headers: headers));
  }

  static Future<dynamic> post(BuildContext context, String route,
      {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    if (token != null && headers == null) {
      return jsonDecode(await NetworkManager.post(context, route,
          body: body, headers: {"Authorization": "Bearer " + token!}));
    }
    return jsonDecode(await NetworkManager.post(context, route,
        body: body, headers: headers));
  }

  static Future<dynamic> put(BuildContext context, String route,
      {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    if (token != null && headers == null) {
      return jsonDecode(await NetworkManager.put(context, route,
          body: body, headers: {"Authorization": "Bearer " + token!}));
    }
    return jsonDecode(
        await NetworkManager.put(context, route, body: body, headers: headers));
  }

  static Future<dynamic> delete(BuildContext context, String route,
      {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["Authorization"] = "Bearer " + token!;
    }
    if (token != null && headers == null) {
      return jsonDecode(await NetworkManager.delete(context, route,
          body: body, headers: {"Authorization": "Bearer " + token!}));
    }
    return jsonDecode(await NetworkManager.delete(context, route,
        body: body, headers: headers));
  }
}
