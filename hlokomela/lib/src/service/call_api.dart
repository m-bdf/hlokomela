import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_manager/network_manager.dart';

class CallApi {
  static String? token;

  static Future<Response> get(BuildContext context, String route, {Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["token"] = token!;
    }
    return Response.fromJson(jsonDecode(await NetworkManager.get(context, route)));
  }

  static Future<Response> post(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["token"] = token!;
    }
    return Response.fromJson(jsonDecode(await NetworkManager.post(context, route, body : body, headers : headers)));
  }

  static Future<Response> put(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["token"] = token!;
    }
    return Response.fromJson(jsonDecode(await NetworkManager.put(context, route, body : body, headers : headers)));
  }

  static Future<Response> delete(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    if (headers != null && token != null) {
      headers["token"] = token!;
    }
    return Response.fromJson(jsonDecode(await NetworkManager.delete(context, route, body : body, headers : headers)));
  }
}

class Response {
  final Map<String, dynamic> received;

  Response({
    required this.received,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      received: json['received'],
    );
  }
}