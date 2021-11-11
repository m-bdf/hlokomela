import 'package:flutter/material.dart';
import 'package:hlokomela/src/service/call_api.dart';

class ListNoteService {
  Future<Map<String, dynamic>> getNotes(BuildContext context, int index, int count) async {
    //{"index": index.toString(), "count": count.toString()}
    return await CallApi.get(context, CallApi.route + "notes", args : {"index": index.toString(), "count": count.toString()});
  }
}
