import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_sqflite_flutter/controller/notes_controller.dart';
import 'package:notes_sqflite_flutter/view/screens/edit_note_screen.dart';
import 'package:notes_sqflite_flutter/view/screens/home_screen.dart';
import 'package:notes_sqflite_flutter/view/widgets/alarm_dialog.dart';

import '../screens/add_new_note_screen.dart';

class NoteDetailsScreen extends StatelessWidget {
  final NotesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final Object? index = ModalRoute.of(context)?.settings.arguments;
    final int i = int.parse(index.toString());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: GetBuilder<NotesController>(
            builder: (_) {
              return Text(
                '${controller.notes[i].title}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              );
            },
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditNoteScreen(), arguments: i);
                },
                icon: Icon(
                  Icons.edit,
                )),
            IconButton(
                onPressed: () {
                  Get.bottomSheet(buildBottomSheet(context, i));
                },
                icon: Icon(
                  Icons.more_vert,
                )),
          ],
        ),
        body: GetBuilder<NotesController>(
          builder: (_) {
            return Scrollbar(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        controller.notes[i].title,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Last Edited : " + controller.notes[i].dateTimeEdited,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SelectableText(
                        controller.notes[i].content,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget buildBottomSheet(BuildContext context, int i) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlarmDialogCustom(
                    text: "Are you sure you want to delete the note?",
                    confirmCallback: () {
                      controller.deleteNote(controller.notes[i].id);
                      Get.offAll(HomeScreen());
                    },
                    cancellCallback: () {
                      Get.back();
                    },
                  );
                },
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.delete,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              controller.shareNote(
                controller.notes[i].title,
                controller.notes[i].content,
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.share,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Share",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Created :  " + controller.notes[i].dateTimeCreated,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Content Word Count :  " +
                      controller.contentWordCount.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Content Character Count :  " +
                      controller.contentCharCount.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Created by AHMED Eid",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
