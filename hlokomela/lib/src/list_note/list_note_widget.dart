import 'package:flutter/material.dart';
import 'package:hlokomela/src/list_note/list_note_controller.dart';

class ListNoteWidget extends StatelessWidget {
  const ListNoteWidget({
    Key? key,
    required this.controller,
    required this.maxChar,
    required this.position,
    required this.onPressDelete,
    required this.onPressCard,
    required this.scrollController,
  }) : super(key: key);

  final ListNoteController controller;
  final int maxChar;
  final int position;
  final VoidCallback onPressDelete;
  final VoidCallback onPressCard;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (controller.notes?["titles"].length == 0) {
      return Container();
    }
    return Card(
      child: InkWell(
        onTap: onPressCard,
        child: Padding(
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
                      controller.notes?["titles"]?[position] ?? "Empty Title",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onPressDelete,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
