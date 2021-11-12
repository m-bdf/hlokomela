import 'dart:core';

class EditNoteData {
  EditNoteData({required this.noteName, required this.isNew});

  final String noteName;
  final bool isNew;

  String getNoteName() {
    return noteName;
  }

  bool getFirstName() {
    return isNew;
  }
}