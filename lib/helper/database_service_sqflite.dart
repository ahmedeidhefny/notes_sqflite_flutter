import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/note_entity.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //late final Database _database;

  static final _dbName = 'notes.db';
  static final _dbVersion = 1;
  static final _tableName = 'notes';

  Future<Database> get database async {
  //  if (_database == null) {
      return await initialDatabase();
    //  return _database;
    //}
    //return _database;
  }

  initialDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
    CREATE TABLE ${_tableName}(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    dateTimeEdited TEXT NOT NULL,
    dateTimeCreated TEXT NOT NULL
    )
    ''');
  }

  //Add Note
  Future<int> addNote(Note note) async {
    Database db = await instance.database;
    return await db.insert(_tableName, note.toMap());
  }

  //Delete Note
  Future<int> deleteNote(Note note) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [note.id]);
  }

  //Delete All note
  Future<int> deleteAllNotes() async {
    Database db = await instance.database;
    return await db.delete(_tableName);
  }

  //Update Note
  Future<int> updateNote(Note note) async {
    Database db = await instance.database;
    return await db.update(_tableName, note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }

  //get Notes List
  Future<List<Note>> getNotes() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (index) {
      return Note(
        id: maps[index]['id'],
        title: maps[index]['title'],
        content: maps[index]['content'],
        dateTimeCreated: maps[index]['dateTimeCreated'],
        dateTimeEdited: maps[index]['dateTimeEdited']
      );
    });
  }

}
