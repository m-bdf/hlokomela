import 'package:flutter/material.dart';
import 'package:hlokomela/src/list_note/list_note_service.dart';
import 'package:hlokomela/src/settings/settings_view.dart';

import 'list_note_controller.dart';

class ListNoteView extends StatefulWidget {
  const ListNoteView({Key? key}) : super(key: key);
  static const routeName = '/list_note';

  @override
  State<ListNoteView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<ListNoteView> {
  Map<String, dynamic>? notes;
  late int maxChar;
  late final ListNoteController controller;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<int> _items = [];
  int counter = 0;

  insertNote() {
    listKey.currentState?.insertItem(controller.notes?["notes"].length - 1,
        duration: const Duration(milliseconds: 200));
    _items = [counter++, ..._items];
  }

  loadNote() {
    for (var i = 0; i < controller.notes?["notes"].length; i++) {
      listKey.currentState?.insertItem(i,
          duration: const Duration(milliseconds: 200));
      _items = [counter++, ..._items];
    }
  }

  @override
  void initState() {
    controller = ListNoteController(ListNoteService(), context);
    controller.loadNotes().then((_) {
      loadNote();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    maxChar = (size.width * 0.12).toInt();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingsView.routeName);
                },
                icon: const Icon(Icons.settings),
              ),
            ),
            const Expanded(
              flex: 1,
              child : Center(
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
              child : AnimatedList(
                key: listKey,
                shrinkWrap: true,
                initialItemCount: _items.length,
                itemBuilder: (context, index, animation) {
                  return slideIt(context, index, animation); // Refer step 3
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO : create new note
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget slideIt(BuildContext context, int position, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: Card(
        child: InkWell(
          onTap: () {
            //TODO: add edit note
          },
          child : Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.notes?["notes"].keys.elementAt(position) ?? "Empty Title",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        controller.notes?["notes"].values.elementAt(position).length > maxChar ? '${controller.notes?["notes"].values.elementAt(position).substring(0, maxChar)}...' : controller.notes?["notes"].values.elementAt(position),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //TODO: delete
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
