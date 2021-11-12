import 'package:flutter/material.dart';
import 'package:hlokomela/src/edit_note/edit_note_data.dart';
import 'package:hlokomela/src/edit_note/edit_note_view.dart';
import 'package:hlokomela/src/list_note/list_note_service.dart';
import 'package:hlokomela/src/list_note/list_note_widget.dart';
import 'package:hlokomela/src/settings/settings_view.dart';
import 'package:hlokomela/src/widget/exit_will_pop.dart';

import 'list_note_controller.dart';

class ListNoteView extends StatefulWidget {
  const ListNoteView({Key? key}) : super(key: key);
  static const routeName = '/list_note';

  @override
  State<ListNoteView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<ListNoteView> {
  Map<String, dynamic>? notes;
  bool isInserted = true;
  late int maxChar;
  late final ListNoteController controller;
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  insertNote(int index) {
    for (var i = index; i < controller.notes?["titles"].length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
    isInserted = true;
  }

  removeNote(int index) {
    listKey.currentState?.removeItem(
        index, (_, animation) => slideIt(context, index, animation),
        duration: const Duration(milliseconds: 200));
    controller.notes?["titles"].removeAt(index);
  }

  loadNote() {
    for (var i = 0; i < controller.notes?["titles"].length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
  }

  @override
  void initState() {
    controller = ListNoteController(ListNoteService(), context);
    controller.loadNotes(15).then((_) {
      if (controller.notes != null) {
        loadNote();
      }
    });
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = 200.0;
      int index = controller.notes?["titles"].length;
      if (maxScroll - currentScroll <= delta && isInserted) {
        controller
            .loadMoreNotes(controller.notes?["titles"].length,
                MediaQuery.of(context).size.height ~/ 30)
            .then((_) => {insertNote(index)});
        isInserted = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    maxChar = (size.width * 0.12).toInt();
    return ExitWillPop(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingsView.routeName);
                  },
                  icon: const Icon(Icons.settings),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: AnimatedList(
                  controller: scrollController,
                  key: listKey,
                  shrinkWrap: true,
                  initialItemCount: controller.notes?["titles"].length ?? 0,
                  itemBuilder: (context, index, animation) {
                    return slideIt(context, index, animation);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController controller = TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Create note'),
                content: const Text('Enter a name'),
                actions: <Widget>[
                  TextField(
                    controller: controller,
                  ),
                  TextButton(
                    onPressed: () =>
                        {Navigator.of(context).pop(controller.text)},
                    child: const Text('Validate'),
                  ),
                ],
              ),
            ).then((value) => {
                  Navigator.of(context).pushNamed(EditNoteView.routeName,
                      arguments: EditNoteData(noteName: value, isNew: true))
                });
          },
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget slideIt(BuildContext context, int position, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: ListNoteWidget(
        controller: controller,
        maxChar: maxChar,
        scrollController: scrollController,
        position: position,
        onPressDelete: () {
          controller
              .deleteNote(controller.notes?["titles"][position])
              .then((value) {
            removeNote(position);
          });
        },
        onPressCard: () {
          Navigator.of(context).pushNamed(EditNoteView.routeName,
              arguments: EditNoteData(
                  noteName: controller.notes?["titles"][position],
                  isNew: false));
        },
      ),
    );
  }
}
