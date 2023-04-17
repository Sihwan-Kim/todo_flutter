import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//-----------------------------------------------------------------------------------------
class PostHelper 
{
  // 데이터베이스를 시작한다.
  Future _openDb() async 
  {  
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'my_database.db');
  
    final db = await openDatabase
    (
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );
  }
  //----------------------------------------------------------------------------------------- 
  Future _onCreate(Database db, int version) async 
  {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS posts 
      (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }
  //-----------------------------------------------------------------------------------------
}
//-----------------------------------------------------------------------------------------