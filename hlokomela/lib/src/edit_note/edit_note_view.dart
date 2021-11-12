import 'package:flutter/material.dart';
import 'package:hlokomela/src/widget/loading_dialog.dart';
import 'package:hlokomela/src/widget/save_will_pop.dart';

import 'edit_note_controller.dart';
import 'edit_note_service.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({Key? key, required this.noteName, required this.isNew})
      : super(key: key);
  final String noteName;
  final bool isNew;
  static const routeName = '/edit_note';

  @override
  State<EditNoteView> createState() => _EditNoteView();
}

class _EditNoteView extends State<EditNoteView> {
  late final EditNoteController controller;
  TextEditingController? noteController;
  bool isSaved = false;

  @override
  void initState() {
    controller = EditNoteController(EditNoteService(), context);
    if (!widget.isNew) {
      controller.loadNote(widget.noteName).then((_) {
        setState(() {
          noteController =
              TextEditingController(text: controller.note!["content"]);
        });
      });
    } else {
      noteController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SaveWillPop(
      isSaved: isSaved,
      onQuit: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const LoadingDialog(title: "Saving note");
            }),
        controller.saveNote(widget.noteName, noteController?.text ?? "").then(
            (_) => {
                  Navigator.of(context).pop(true),
                  Navigator.of(context).pop(true)
                })
      },
      onCancel: () => {Navigator.of(context).pop(true)},
      canLeave: noteController == null ? false : true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    widget.noteName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: noteController == null
                        ? const LoadingDialog(title: "Loading note")
                        : TextField(
                            controller: noteController,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            onChanged: (text) {
                              setState(() {
                                isSaved = false;
                              });
                            },
                          ),
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const LoadingDialog(title: "Saving note");
                });
            controller
                .saveNote(widget.noteName, noteController?.text ?? "")
                .then((_) => {
                      Navigator.of(context).pop(true),
                      setState(() {
                        isSaved = true;
                      }),
                    });
            FocusScope.of(context).unfocus();
          },
          child: const Icon(Icons.save),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
