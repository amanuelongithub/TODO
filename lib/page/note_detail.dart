import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../db/note_database.dart';
import '../model/note.dart';
import 'add_edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  const NoteDetailPage({super.key, required this.noteId});

  @override
  State<NoteDetailPage> createState() => Note_DetailPageState();
}

class Note_DetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NoteDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Detaile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [isImportantButton(), editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.5,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        note.desprecation,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    )
                  ],
                ),
              ));
  }

  Widget editButton() => IconButton(
        onPressed: () async {
          if (isLoading) return;
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AddEditNotePage(note: note),
            ),
          );

          refreshNote();
        },
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 215, 215, 215),
          ),
          child: Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
      );
  Widget deleteButton() => IconButton(
        onPressed: () async {
          await NoteDatabase.instance.delete(widget.noteId);
          Navigator.pop(context);
        },
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 215, 215, 215),
          ),
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
      );

  Widget isImportantButton() => IconButton(
        onPressed: () async {
          await NoteDatabase.instance.delete(widget.noteId);
          Navigator.pop(context);
        },
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 215, 215, 215),
          ),
          child: Icon(
            note.isImportant
                ? Icons.bookmark_added_rounded
                : Icons.bookmark_outline_rounded,
            color: Colors.black,
          ),
        ),
      );
}
