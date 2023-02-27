import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/note.dart';

class NoteCardWidget extends StatefulWidget {
  final Note note;
  final int index;
  const NoteCardWidget({
    super.key,
    required this.note,
    required this.index,
  });

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 212, 212, 212),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              widget.note.id.toString(),
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.note.title.toUpperCase(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.note.createdTime.toString(),
                    style: TextStyle(color: Colors.black26, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
