import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/db/note_database.dart';
import 'package:todo_app/model/note.dart';
import 'package:todo_app/page/add_edit_note_page.dart';
import 'package:todo_app/page/note_detail.dart';
import 'package:lottie/lottie.dart';
import '../widget/dawer.dart';
import '../widget/note_card_widget.dart';

class LottieDialog extends StatefulWidget {
  const LottieDialog({Key? key}) : super(key: key);

  @override
  State<LottieDialog> createState() => _LottieDialogState();
}

class _LottieDialogState extends State<LottieDialog> with SingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/json/empty-1.json',
          repeat: false,
          controller: lottieController,
          onLoaded: (comopsition) {
            lottieController.duration = comopsition.duration;
            // lottieController.forward();
          },
          height: 120,
          width: 120,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            "Enjoy Your Order",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
        )
      ],
    );
  }
}


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Note> notes = [];
  bool isLoading = false;
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    refreshNotes();
    lottieController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    NoteDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NoteDatabase.instance.readAllNote();
    // print("....note length...." + notes.length.toString());

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.setContext(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        leading: InkResponse(radius: 20, splashColor: Colors.grey, onTap: () => _scaffoldKey.currentState?.openDrawer(), child: const Icon(Icons.menu, color: Colors.white)),
        title: Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : notes.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/json/empty-2.json',
                          repeat: true,
                          // controller: lottieController,
                          // onLoaded: (comopsition) {
                          //   lottieController.duration = comopsition.duration;

                          // },
                          height: 120,
                          width: 120,
                        ),
                        const Text(
                          "Empty Note",
                          style: TextStyle(fontSize: 20, color: Color.fromARGB(203, 131, 131, 131)),
                        ),
                      ],
                    )
                  : buildNotes()),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        onPressed: () async {
          // int val = notes.length;
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const AddEditNotePage(),
            ),
          );
          refreshNotes();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildNotes() => OrientationBuilder(builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return GridView.builder(
          itemCount: notes.length,
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: isPortrait ? 2 : 3, mainAxisSpacing: 20, crossAxisSpacing: 20),
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
