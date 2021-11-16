import 'package:flutter/material.dart';
import 'package:hlokomela/src/service/call_api.dart';

class ListNoteService {
  Future<void> deleteNote(BuildContext context, String name) async {
    return await CallApi.delete(context, CallApi.route + "note",
        body: {"title": name});
  }

  Future<Map<String, dynamic>> getNotes(
      BuildContext context, int index, int count) async {
    return await CallApi.get(context, CallApi.route + "notes",
        args: {"index": index.toString(), "count": count.toString()});
  }
}
