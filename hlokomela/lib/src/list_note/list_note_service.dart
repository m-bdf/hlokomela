import 'package:flutter/material.dart';
import 'package:hlokomela/src/service/call_api.dart';

class ListNoteService {
  Future<Map<String, dynamic>> getNotes(BuildContext context) async {
      return await CallApi.get(context, CallApi.route + "note");
  }
}
