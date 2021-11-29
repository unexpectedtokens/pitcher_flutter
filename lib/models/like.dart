import 'package:pitcher/models/crag.dart' as crag;
import 'package:pitcher/models/climb.dart' as climb;
import 'package:pitcher/models/climber.dart' as climber;

const String tableNameCragLike = "crag_like";
const String tableNameClimbLike = "climb_like";

class Like{
  late int climberID;




  static String getCreateTableCragLike(){
    return "CREATE TABLE $tableNameCragLike(climberid INTEGER REFERENCES ${climber.tableName}(_id) "
        "ON DELETE CASCADE, "
        "cragid INTEGER REFERENCES ${crag.tableName}(_id) ON DELETE CASCADE);";



  }
  static String getCreateTableClimbLike(){
    return "CREATE TABLE $tableNameClimbLike(climberid INTEGER REFERENCES ${climber.tableName}(_id) "
        "ON DELETE CASCADE,climbid INTEGER REFERENCES ${climb.tableName}(_id) ON DELETE CASCADE);";
  }
}