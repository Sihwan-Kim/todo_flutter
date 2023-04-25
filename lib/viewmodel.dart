import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';
//-----------------------------------------------------------------------------------------

class DatabaseControl
{
  Future<Database>? _database ;
  
  //-----------------------------------------------------------------------------------------------------
  void initDatabase() async
  {
    _database = openDatabase
    (
      join(await getDatabasesPath(), 'todo_database.db'),

      onCreate: (db, version) 
      {
        return db.execute("CREATE TABLE worklist(id INTEGER PRIMARY KEY, name TEXT, count INTEGER, colorIdex INTEGER)",);
      },
      version: 1,
    );
  }
  //-----------------------------------------------------------------------------------------------------
  Future<void> insertWorkList(WorkListProperty worklist) async 
  {
    final Database db = await _database!;

    await db.insert
    (
      'worklist',
      worklist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  //-----------------------------------------------------------------------------------------------------
}