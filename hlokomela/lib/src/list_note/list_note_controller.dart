import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'list_note_service.dart';

class ListNoteController with ChangeNotifier {
  ListNoteController(this._notesViewService, this.context);

  final ListNoteService _notesViewService;
  BuildContext context;

  Map<String, dynamic>? _notes;

  Map<String, dynamic>? get notes => _notes;

  Future<void> loadMoreNotes(int index, int count) async {
    WidgetsFlutterBinding.ensureInitialized();
    _notes!["titles"].addAll((await _notesViewService.getNotes(context, index, count))["titles"]);
    notifyListeners();
  }

  Future<void> loadNotes(int count) async {
    WidgetsFlutterBinding.ensureInitialized();
    _notes = await _notesViewService.getNotes(context, 0, count);
    notifyListeners();
  }


}
