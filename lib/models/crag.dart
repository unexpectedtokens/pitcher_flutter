import 'package:pitcher/db/main.dart';

import 'climber.dart' as climber;
import 'climb.dart';
import 'like.dart';
import 'location.dart';

const String tableName = "crag";

class Crag{
  late int? id;
  late climber.Climber creator;
  late String name;
  late String description;
  late List<Climb> climbs = [];
  late List<Like> likes = [];
  late Location location;

  Crag({
    required this.creator,
    required this.name,
    required this.description,
    required this.location
  });


  static String getCreateTable(){
    return '''
    CREATE TABLE $tableName(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        creatorid INTEGER,
        name VARCHAR(50),
        description VARCHAR(200),
        lat NUMERIC,
        long NUMERIC
       );
    
    ''';
  }



  void printName(){
    print(name);
  }

  Future<Crag> insert() async{
    var db = await PitcherDatabase().database;
    id = await db.insert(tableName, toJSON());
    return this;
  }

  static Future<List<Crag>> getList() async {
    var db = await PitcherDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    var list = await db.rawQuery("SELECT cr._id as cragid, c._id as climberid, cr.creatorid, cr.name, cr.description, cr.lat, cr.long, c.username FROM $tableName cr LEFT JOIN ${climber.tableName} c ON cr.creatorid = c._id");
    await db.close();
    return List.generate(maps.length, (index) {
      var crag = list[index];
      return Crag(
          creator: climber.Climber.returnMockClimber(),
          name: crag["name"].toString(),
          description: crag["description"].toString(),
          location: Location(
              lat: double.parse(crag["lat"].toString()),
              long: double.parse(crag["long"].toString()),
          )
      );

    });

  }
  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'lat': location.lat,
      'long': location.long,
      'creatorid': creator.id
    };
  }
}