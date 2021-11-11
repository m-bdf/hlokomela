library network_manager;

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  static Map<String, String> baseHeader = {'Content-Type': 'application/json; charset=UTF-8'};

  static Future<String> get(BuildContext context, String route, {Map<String, String>? args, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        baseHeader.addAll(headers);
      }
      var uri = Uri.parse(route).replace(queryParameters: args);
      final response = await http.get(uri, headers: baseHeader);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        log(response.body);
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> post(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        baseHeader.addAll(headers);
      }
      final response = await http.post(Uri.parse(route), body: jsonEncode(body), headers: baseHeader);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> put(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        baseHeader.addAll(headers);
      }
      final response = await http.put(Uri.parse(route), body: jsonEncode(body), headers: baseHeader);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        log(response.body);
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> delete(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        baseHeader.addAll(headers);
      }
      final response = await http.delete(Uri.parse(route), body: jsonEncode(body), headers: baseHeader);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        log(response.body);
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static SnackBar makeSnackBar(String error) {
    return SnackBar(
      content: Text('Error: $error'),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds : 3),
    );
  }
}