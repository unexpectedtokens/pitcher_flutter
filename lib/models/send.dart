import 'package:pitcher/models/climb.dart' as climb;
import 'package:pitcher/models/climber.dart' as climber;


const String tableName = "send";

class Send{

  final int climberID;
  final int tries;


  Send({
    required this.climberID,
    required this.tries
  });

  static String getCreateTable(){
    return '''
      CREATE TABLE $tableName(
        climberid INTEGER REFERENCES ${climber.tableName}(_id) ON DELETE CASCADE,
        climbid INTEGER REFERENCES ${climb.tableName}(_id) ON DELETE CASCADE,
        tries INTEGER DEFAULT 0
      );
    
    ''';
  }
}