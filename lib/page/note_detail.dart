import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/note_database.dart';
import '../model/note.dart';
import 'add_edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  const NoteDetailPage({super.key, required this.noteId});

  @override
  State<NoteDetailPage> createState() => NoteDetailPageState();
}

class NoteDetailPageState extends State<NoteDetailPage> {
  Note? note;
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
          title: const Text(
            "Detaile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            // isImportantButton(),
            editButton(),
            deleteButton()
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note!.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat.yMMMd().format(note!.createdTime),
                      style: const TextStyle(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.5,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        note!.desprecation,
                        style: const TextStyle(fontSize: 18, color: Colors.black87),
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
            color: const Color.fromARGB(255, 215, 215, 215),
          ),
          child: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
      );
  Widget deleteButton() => IconButton(
        onPressed: () async {
          await NoteDatabase.instance.delete(widget.noteId);
          if (mounted) {
            Navigator.pop(context);
          }
        },
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 215, 215, 215),
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
      );

  Widget isImportantButton() => IconButton(
        onPressed: () async {
          await NoteDatabase.instance.delete(widget.noteId);
          if (mounted) {
            Navigator.pop(context);
          }
        },
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 215, 215, 215),
          ),
          child: Icon(
            note!.isImportant ? Icons.bookmark_added_rounded : Icons.bookmark_outline_rounded,
            color: Colors.black,
          ),
        ),
      );
}
