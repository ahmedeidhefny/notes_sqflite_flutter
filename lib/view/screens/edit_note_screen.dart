
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_sqflite_flutter/view/screens/home_screen.dart';

import '../../controller/notes_controller.dart';

class EditNoteScreen extends StatelessWidget {
  final NotesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final Object? index = ModalRoute.of(context)?.settings.arguments;
    final int i = int.parse(index.toString());

    controller.titleController.text = controller.notes[i].title;
    controller.contentController.text = controller.notes[i].content;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Note',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateNote(
              controller.notes[i].id, controller.notes[i].dateTimeCreated);
          //Get.off(()=> HomeScreen());
        },
        child: Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 5),
                ),
              ),
              TextField(
                controller: controller.contentController,
                style: TextStyle(
                  fontSize: 22,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Content',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

