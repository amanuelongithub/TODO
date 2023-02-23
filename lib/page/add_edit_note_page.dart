import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/db/note_database.dart';

import '../model/note.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({super.key, this.note});

  @override
  State<AddEditNotePage> createState() => AddEditNotePageState();
}

class AddEditNotePageState extends State<AddEditNotePage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController disccontroller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titlecontroller = TextEditingController(text: widget.note!.title);
      disccontroller = TextEditingController(text: widget.note!.desprecation);
    }
  }

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    disccontroller.dispose();
  }

  final formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late DateTime created;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TO DO"),
        ),
        body: Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(children: [
                TextFormField(
                  controller: titlecontroller,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 126, 126, 126),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    return value != null && value.isEmpty
                        ? 'Enter a title please'
                        : null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: disccontroller,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 126, 126, 126),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    return value != null && value.isEmpty
                        ? 'Enter a some description please'
                        : null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.black,
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: addOreditNote,
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ))
              ]),
            )));
  }

  void addOreditNote() async {
    final isValid = formKey.currentState!;

    if (isValid.validate()) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
      titlecontroller.text = '';
      disccontroller.text = '';
      Navigator.of(context).pop();
    } else {
      print("Form is not valid!");
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: true,
      number: 2,
      title: titlecontroller.text,
      desprecation: disccontroller.text,
    );
    await NoteDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: titlecontroller.text,
      isImportant: true,
      number: 1,
      desprecation: disccontroller.text,
      createdTime: DateTime.now(),
    );

    await NoteDatabase.instance.create(note);
  }
}
