library network_manager;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  static Future<String> get(BuildContext context, String route) async {
    try {
      final response = await http.get(Uri.parse(route));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar("The server couldn't be reached"));
      throw Exception(e);
    }
  }

  static Future<String> post(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse(route), body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar("The server couldn't be reached"));
      throw Exception(e);
    }
  }

  static Future<String> put(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      final response = await http.put(Uri.parse(route), body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar("The server couldn't be reached"));
      throw Exception(e);
    }
  }

  static Future<String> delete(BuildContext context, String route, {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      final response = await http.delete(Uri.parse(route), body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(response.statusCode.toString()));
        throw Exception('Failed to load Response');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar("The server couldn't be reached"));
      throw Exception(e);
    }
  }

  static SnackBar makeSnackBar(String error) {
    return SnackBar(
      content: Text('Error: $error'),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds : 3),
    );
  }
}