import 'package:flutter/material.dart';
import 'package:hlokomela/src/service/call_api.dart';

class EditNoteService {
  Future<void> saveNote(BuildContext context, String name, String content) async {
    return await CallApi.put(context, CallApi.route + "note", body: {"title": name, "content" : content});
  }

  Future<Map<String, dynamic>> getNote(BuildContext context, String title) async {
    return await CallApi.get(context, CallApi.route + "note", args : {"title": title});
  }
}
