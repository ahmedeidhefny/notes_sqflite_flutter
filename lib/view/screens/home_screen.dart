import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_sqflite_flutter/controller/notes_controller.dart';
import 'package:notes_sqflite_flutter/view/screens/add_new_note_screen.dart';
import 'package:notes_sqflite_flutter/view/screens/note_details_screen.dart';
import 'package:notes_sqflite_flutter/view/widgets/alarm_dialog.dart';
import 'package:notes_sqflite_flutter/view/widgets/note_search_bar.dart';

class HomeScreen extends StatelessWidget {
  NotesController notesController = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Note App',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: NoteSearchbar());
              },
              icon: Icon(
                Icons.search,
              )),
          PopupMenuButton(
              onSelected: (value) {
                if (value == 0) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlarmDialogCustom(
                          text: 'Are you sure you want to delete all notes?',
                          confirmCallback: () {
                            notesController.deleteAllNotes();
                            Get.back();
                          },
                          cancellCallback: () {
                            Get.back();
                          },
                        );
                      });
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 0,
                        child: Text(
                          'Delete all Notes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewNoteScreen());
        },
        child: Icon(Icons.add),
      ),
      body: GetBuilder<NotesController>(
        builder: (_) =>
            !notesController.isEmptyTable() ? buildNotes() : buildEmptyNote(),
      ),
    );
  }

  Widget buildEmptyNote() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/note.json'),
          SizedBox(
            height: 40.0,
          ),
          Text(
            'You don\'t have any notes',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildNotes() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: StaggeredGridView.countBuilder(
        itemCount: notesController.notes.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => NoteDetailsScreen(), arguments: index);
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlarmDialogCustom(
                      text: 'Are you sure you want to delete the note?',
                      confirmCallback: () {
                        notesController
                            .deleteNote(notesController.notes[index].id);
                        Get.back();
                      },
                      cancellCallback: () {
                        Get.back();
                      },
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notesController.notes[index].title,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notesController.notes[index].content,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notesController.notes[index].dateTimeEdited,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
