import 'package:pitcher/db/main.dart';
import 'package:pitcher/models/like.dart';
import 'package:pitcher/models/send.dart' as sends_mod;

import 'location.dart';
import 'climber.dart';


const String tableName = "climb";



enum ClimbType{
  route,
  boulder,
}

class Climb{
  int? id;
  final String name;
  final String description;
  final Location location;
  final String grade;
  late Climber climber;
  final ClimbType typeOfClimb;
  List<sends_mod.Send> sends = [];
  List<Like> likes = [];


  Climb({
    required this.name,
    required this.description,
    required this.location,
    required this.grade,
    required this.typeOfClimb,
  });


  static String getCreateTable(){
    return '''
      CREATE TABLE $tableName(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(50),
        description VARCHAR(50),
        lat NUMERIC,
        long NUMERIC,
        grade VARCHAR(3),
        postedByID INTEGER,
        typeofclimb VARCHAR(7),
        cragid INTEGER
       );
    ''';


  }



  Future insert(int cragid) async{
    var db = await PitcherDatabase().database;
    var givenID = await db.insert(tableName, toJSON(cragid));
    id = givenID;
    await db.close();
    return;
  }

  Future addSend(sends_mod.Send send, int climbid) async {
    var db = await PitcherDatabase();
    await send.insert(climbid);
    sends.add(send);
    await db.close();
    return;
  }


  Map<String, dynamic> toJSON(int cragid) {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'lat': location.lat,
      'long': location.long,
      'postedByID': 1,
      "typeofclimb": typeOfClimb == ClimbType.boulder ? "boulder" : "route",
      "grade": grade,
      "cragid": cragid
    };
  }

  static List<String> grades = const [
    '5a',
    '5b',
    '5c',
    '6a',
    '6b',
    '6c',
    '7a',
    '7b',
    '7c',
    '8a',
    '8b',
    '8c',
    '9a',
    '9b',
    '9c'
  ];
}




