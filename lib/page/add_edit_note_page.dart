import 'package:flutter/material.dart';
import 'package:todo_app/db/note_database.dart';

import '../model/note.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  const AddEditNotePage({
    super.key,
    this.note,
  });

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
          title: Text(
            widget.note != null ? "Update note" : "Add note ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  TextFormField(
                    controller: titlecontroller,
                    cursorColor: Colors.grey,
                    maxLength: 10,
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
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: disccontroller,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Description',
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
                          ? 'Enter a some description please'
                          : null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.black,
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: addOreditNote,
                      child: Text(
                        widget.note != null ? "Update" : "Save",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))
                ]),
              ),
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
     if(mounted){
       Navigator.of(context).pop();
     }
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: true,
       title: titlecontroller.text,
      desprecation: disccontroller.text,
    );
    await NoteDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: titlecontroller.text,
      isImportant: true,
       desprecation: disccontroller.text,
      createdTime: DateTime.now(),
    );

    await NoteDatabase.instance.create(note);
  }
}
