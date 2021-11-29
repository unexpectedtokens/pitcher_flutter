import 'package:pitcher/db/main.dart';


const String tableName = 'climber';


class Climber{
  late int? id;
  late String username;
  late String email;
  late String firstname;
  late String lastname;
  late String password;

  bool _validate(){
    return true;
  }

  Climber({
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.password
  });


  static String getCreateTable(){
    return '''
CREATE TABLE $tableName(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        username VARCHAR(50),
        email VARCHAR(50),
        firstname VARCHAR(20),
        lastname VARCHAR(20),
        password VARCHAR(80)
);
    ''';
  }

  static Future<bool> login(String username, String password) async{
    var db = await PitcherDatabase().database;
    return true;
  }

  Future<bool> register() async{
    var db = await PitcherDatabase().database;
    return true;
  }

  static Climber returnMockClimber(){
    var climber = Climber(username: "daniel122", email: "yes@no.nl", firstname: "Daniel", lastname: "de Jong", password: "");
    climber.id = 1;
    return climber;
  }
}