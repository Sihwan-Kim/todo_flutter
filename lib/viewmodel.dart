import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
//-----------------------------------------------------------------------------------------

const String tableName = 'WorkList';

class DatabaseControl
{
  DatabaseControl._();
  static final DatabaseControl _db = DatabaseControl._();
  factory DatabaseControl() => _db;

  static Database? _database;

  Future<Database?> get database async 
  {
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }
  //-----------------------------------------------------------------------------------------------------
  initDB() async 
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MyDogsDB.db');

    return await openDatabase
    (
      path,
      version: 1,
      onCreate: (db, version) async 
      {
        await db.execute('''
          CREATE TABLE $tableName(name TEXT PRIMARY KEY, count INTEGER, colorIndex INTEGER)
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion){}
    );
  }
  //-----------------------------------------------------------------------------------------------------
  Future<int> insertData(WorkListProperty workList) async 
  {
    var value = 
    {
     'name': workList.name,
     'count': workList.count,
     'colorIndex':workList.colorIndex
    };

    final db = await database;
    var res = await db!.insert('WorkList', value, conflictAlgorithm: ConflictAlgorithm.replace,);
 
    return res;
  }
  //-----------------------------------------------------------------------------------------------------
   Future<int> deleteData(String workListName) async
  {
    final db = await database;
    var res = await db!.delete('WorkList', where: 'name = ?', whereArgs: [workListName]) ;
 
    return res;
  }
  //-----------------------------------------------------------------------------------------------------
  Future<List<WorkListProperty>> getAllData() async 
  {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('WorkList');

    return List.generate
    (
      maps.length,(i) 
      {
        return WorkListProperty
        (
          name: maps[i]['name'],
          count: maps[i]['count'],
          colorIndex: maps[i]['colorindex'],
        );
      }
    );
  }
  //-----------------------------------------------------------------------------------------------------
}