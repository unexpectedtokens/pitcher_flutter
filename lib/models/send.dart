import 'package:pitcher/db/main.dart';
import 'package:pitcher/models/climb.dart' as climb;
import 'package:pitcher/models/climber.dart' as climber;

const String tableName = "send";

class Send {
  final int tries;
  final climber.Climber sender;
  Send({
    required this.tries,
    required this.sender,
  });

  static String getCreateTable() {
    return '''
      CREATE TABLE $tableName(
        climberid INTEGER REFERENCES ${climber.tableName}(_id) ON DELETE CASCADE,
        climbid INTEGER REFERENCES ${climb.tableName}(_id) ON DELETE CASCADE,
        tries INTEGER DEFAULT 0
      );
   
    ''';
  }

  Future insert(int climbid) async {
    var db = await PitcherDatabase().database;
    await db.insert(tableName, toJSON(climbid));

    await db.close();
    return;
  }

  static Future<List<Send>> getSendsForClimb(int climbid) async {
    var db = await PitcherDatabase().database;
    var queryRes = await db.rawQuery(
        "SELECT * FROM $tableName s INNER JOIN ${climber.tableName} c ON c._id = s.climberid WHERE climbid = ?;",
        [climbid]);
    if (queryRes.isEmpty) {
      return <Send>[];
    }
    var list = List<Send>.generate(queryRes.length, (index) {
      var item = queryRes[index];
      var sender = climber.Climber(
        username: item["username"].toString(),
        email: item["email"].toString(),
        password: "",
        firstname: item["firstname"].toString(),
        lastname: item["lastname"].toString(),
      );
      return Send(sender: sender, tries: int.parse(item["tries"].toString()));
    });
    return list;
  }

  Map<String, dynamic> toJSON(int climbid) {
    return <String, dynamic>{
      'climberid': sender.id,
      "climbid": climbid,
      "tries": tries,
    };
  }
}
