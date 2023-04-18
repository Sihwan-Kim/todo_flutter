import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';
//-----------------------------------------------------------------------------------------
class DatabaseHelper
{
  
  final String TableName = 'WorkLists';
//-----------------------------------------------------------------------------------------
  Future<Database?> get database async 
  {
    Database db = await initDB() ;

    return db;
  }
//-----------------------------------------------------------------------------------------
  initDB() async
  {
    String path = join(await getDatabasesPath(), 'todo_database.db');

    return await openDatabase
    (
      path,
      version: 1,
      onCreate:(db, version) async
      {
        await db.execute("CREATE TABLE WorkLists(id INTEGER PRIMARY KEY, name TEXT, count INTEGER, colorindex INTEGER)",) ;      
      },
      onUpgrade: (db, oldVersion, newVersion) {} 
    );
  }
//-----------------------------------------------------------------------------------------
  Future insert(WorkListProperty list) async 
  {
    final db = await database;

    await db?.insert(TableName, list.toMap());
  }
//-----------------------------------------------------------------------------------------
  Future<void> delete(WorkListProperty worklist) async 
  {
    final db = await database;

    await db?.delete(TableName, where: "id = ?", whereArgs: [worklist.id],);
  }
}
//-----------------------------------------------------------------------------------------