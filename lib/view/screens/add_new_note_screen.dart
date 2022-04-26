import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_sqflite_flutter/controller/notes_controller.dart';

class AddNewNoteScreen extends StatelessWidget {
  final NotesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add New Note',
          style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNewNote();
          //Get.back();
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
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    letterSpacing: 5
                  ),
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
