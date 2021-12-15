import 'dart:async';

import 'package:pitcher/models/crag.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pitcher/models/climber.dart' as climber;
import 'package:pitcher/models/climb.dart';
import 'package:pitcher/models/send.dart';
import 'package:pitcher/models/like.dart';


class PitcherDatabase {





  Database? _database;



  Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await _initDB("pitcher.db");
    return _database!;
  }
  Future<Database> _initDB(String filename) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filename);
    return await openDatabase(
        path,
        version: 3,
        onUpgrade: _createDB
    );

  }

  Future _createDB(Database db, int version, int anon) async{

    await db.execute(
        climber.Climber.getCreateTable()
    );
    await db.execute(
        "CREATE TABLE login (_userid INTEGER REFERENCES ${climber.tableName}(_id) ON DELETE CASCADE);"
    );
    await db.execute(
      Climb.getCreateTable()
    );
    await db.execute(
        Crag.getCreateTable()
    );
    await db.execute(
        Like.getCreateTableCragLike()
    );
    await db.execute(
        Like.getCreateTableClimbLike()
    );
    await db.execute(
        Send.getCreateTable()
    );


  }

  Future close() async {
    final db = await database;
    db.close();
  }
}