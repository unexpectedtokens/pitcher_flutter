import 'package:pitcher/db/main.dart';

import 'climber.dart' as climber;
import 'climb.dart' as climb;
import 'like.dart';
import 'location.dart';

const String tableName = "crag";

class Crag{
  late int? id;
  late climber.Climber creator;
  late String name;
  late String description;
  late List<climb.Climb> climbs = [];
  late List<Like> likes = [];
  late Location location;
  int boulderCount = 0;
  int routeCount = 0;

  Crag({
    required this.creator,
    required this.name,
    required this.description,
    required this.location,
    this.id
  });


  static String getCreateTable(){
    return '''
    CREATE TABLE $tableName(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        creatorid INTEGER,
        name VARCHAR(50),
        description VARCHAR(2000),
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
          id: int.parse(crag["cragid"].toString()),
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

  static Future<Crag> getDetail(int itf) async{
    var db = await PitcherDatabase().database;
    var list = await db.rawQuery("SELECT cr._id as cragid, c._id as climberid, cr.creatorid, cr.name, cr.description, cr.lat, cr.long, c.username FROM $tableName cr LEFT JOIN ${climber.tableName} c ON cr.creatorid = c._id WHERE cr.id = ?", ["$itf"]);
    print(list);
    late Crag crag;
    list.forEach((element) {
      var creator = climber.Climber.returnMockClimber();
      crag = Crag(
          id: int.parse(element["cragid"].toString()),
          creator: creator,
          name: element["name"].toString(),
          description: element["description"].toString(),
          location: Location(
            lat: double.parse(element["lat"].toString()),
            long: double.parse(element["long"].toString()),
          )
      );
    });
    await db.close();
    return crag;
  }


  void setClimbCount(){
    var amountBoulder = 0;
    var amountRoute = 0;
    for(var c in climbs){
      if(c.typeOfClimb == climb.ClimbType.route){
        amountRoute ++;
      }else if(c.typeOfClimb == climb.ClimbType.boulder){
        amountBoulder++;
      }
    }
    boulderCount = amountBoulder;
    routeCount = amountRoute;
  }

  Future loadClimbs() async{
    climbs = <climb.Climb>[];
    var db = await PitcherDatabase().database;
    var list = await db.query(climb.tableName, where: "cragid = $id");
    List<climb.Climb> fetchedClimbs = List<climb.Climb>.generate(list.length, (index) =>
        climb.Climb(
            description: list[index]["description"].toString(),
            name: list[index]["name"].toString(),
            location: Location(
                lat: double.parse(list[index]["lat"].toString()),
                long: double.parse(list[index]["long"].toString())
            ),
          grade: list[index]["grade"].toString(),
          typeOfClimb: list[index]["typeofclimb"].toString() == "boulder" ? climb.ClimbType.boulder : climb.ClimbType.route,
          postedByID: int.parse(list[index]["postedByID"].toString()),
        )
    );
    climbs = fetchedClimbs;
    return;
  }

  Future addClimb(climb.Climb climb) async{
    await climb.insert(id!);
    climbs.add(climb);
    return;
  }

  List<climb.Climb> getRoutes(){
    var routes = <climb.Climb>[];
    for ( var c in climbs){
      if(c.typeOfClimb == climb.ClimbType.route){
        routes.add(c);
      }
    }
    return routes;
  }

  List<climb.Climb> getBoulders(){
    var routes = <climb.Climb>[];
    for ( var c in climbs){
      if(c.typeOfClimb == climb.ClimbType.boulder){
        routes.add(c);
      }
    }
    return routes;
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