import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/db/note_database.dart';
import 'package:todo_app/model/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/page/add_edit_note_page.dart';
import 'package:todo_app/page/note_detail.dart';

import '../widget/dawer.dart';
import '../widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        leading: InkResponse(
            radius: 20,
            splashColor: Colors.grey,
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Icon(Icons.menu, color: Colors.white)),
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
          int val = notes.length == null ? 0 : notes.length;
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AddEditNotePage(),
            ),
          );
          // await CupertinoPageRoute(builder: (context) => AddEditNotePage());
          refreshNotes();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildNotes() => OrientationBuilder(builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        final isMobile = MediaQuery.of(context).size.shortestSide < 600;

        return GridView.builder(
          itemCount: notes.length,
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isPortrait ? 2 : 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20),
          itemBuilder: (_, index) {
            final note = notes[index];
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => NoteDetailPage(noteId: note.id!),
                  ),
                );
                refreshNotes();
              },
              child: NoteCardWidget(note: note, index: index),
            );
          },
        );
      });
}
