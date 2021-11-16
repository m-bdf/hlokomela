import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_note_service.dart';

class EditNoteController with ChangeNotifier {
  EditNoteController(this._notesViewService, this.context);

  final EditNoteService _notesViewService;
  BuildContext context;

  Map<String, dynamic>? _note;

  Map<String, dynamic>? get note => _note;

  Future<void> saveNote(String title, String content) async {
    await _notesViewService.saveNote(context, title, content);
    notifyListeners();
  }

  Future<void> loadNote(String title) async {
    _note = await _notesViewService.getNote(context, title);
    notifyListeners();
  }
}
