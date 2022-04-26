import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_sqflite_flutter/helper/database_service_sqflite.dart';
import 'package:notes_sqflite_flutter/model/note_entity.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

class NotesController extends GetxController {
  static const String datePattern = 'MMM dd yyyy hh:mm';

  var titleController = TextEditingController();
  var contentController = TextEditingController();

  var notes = <Note>[];

  int contentWordCount = 0, contentCharCount = 0;

  @override
  void onInit() {
    super.onInit();
    getAllNotes();
  }

  bool isEmptyTable() => notes.length == 0 ? true : false;

  void addNewNote() async {
    String title = titleController.text;
    String content = contentController.text;

    if (title.isEmpty) title = 'بدون عنوان';

    Note note = Note(
      title: title,
      content: content,
      dateTimeEdited: DateFormat(datePattern).format(DateTime.now()),
      dateTimeCreated: DateFormat(datePattern).format(DateTime.now()),
    );

    await DatabaseHelper.instance.addNote(note);

    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);

    titleController.text = '';
    contentController.text = '';

    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(id: id);
    await DatabaseHelper.instance.deleteNote(note);

    getAllNotes();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();

    getAllNotes();
  }

  void updateNote(int id, dtCreated) async {
    String title = titleController.text;
    String content = contentController.text;

    if (title.isEmpty) title = 'بدون عنوان';

    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeEdited: DateFormat(datePattern).format(DateTime.now()),
      dateTimeCreated: dtCreated,
    );

    await DatabaseHelper.instance.updateNote(note);

    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);

    titleController.text = '';
    contentController.text = '';

    getAllNotes();
    Get.back();
  }

  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getNotes();
    update();
  }

  void shareNote(String title, String content){
    Share.share('''$title
    $content
    Create by Ahmed Eid
    ''');

  }
}
