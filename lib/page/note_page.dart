import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/db/note_database.dart';
import 'package:todo_app/model/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/page/add_edit_note_page.dart';
import 'package:todo_app/page/note_detail.dart';

import '../widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NoteDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NoteDatabase.instance.readAllNote();
    print("....note length...." + notes.length.toString());

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.black,
                )
              : notes.isEmpty
                  ? Text(
                      "There is no notes",
                      style: TextStyle(fontSize: 20),
                    )
                  : buildNotes()),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddEditNotePage()));
          refreshNotes();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildNotes() => GridView.builder(
        itemCount: notes.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (_, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!)));
              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      );
}
