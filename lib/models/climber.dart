import 'package:pitcher/db/main.dart';

const String tableName = 'climber';

class Climber {
  late int? id;
  late String username;
  late String email;
  late String firstname;
  late String lastname;
  late String password;

  bool _validate() {
    return true;
  }

  Climber(
      {required this.username,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.password});

  static String getCreateTable() {
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

  static Future<int> login(String username, String password) async {
    var db = await PitcherDatabase().database;
    var list = await db.rawQuery("SELECT * FROM $tableName;");
    print(
        "length: ${list.length} $username $password ${list[0]["username"].toString()}");
    late Climber attemptingClimber;
    for (var element in list) {
      if (element["username"].toString() == username) {
        if (element["password"].toString() == password) {
          var climber = Climber(
              username: element["username"].toString(),
              email: element["username"].toString(),
              firstname: element["username"].toString(),
              lastname: element["username"].toString(),
              password: element["username"].toString());
          climber.id = int.parse(element["_id"].toString());
          attemptingClimber = climber;
        }
      }
    }
    return attemptingClimber.id!;
  }

  Future<int> register() async {
    var db = await PitcherDatabase().database;
    var givenID = await db.insert(tableName, toJson());
    await db.close();
    return givenID;
  }

  Future authenticate() async {
    var db = await PitcherDatabase().database;
    await db.insert("login", {"_userid": id});
    await db.close();
    return;
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "password": password,
    };
  }

  static Future<Climber> getCurUser() async {
    print("fetching user");
    var db = await PitcherDatabase().database;
    var list = await db.rawQuery(
        "SELECT c._id, c.username, c.email, c.firstname, c.lastname FROM login l INNER JOIN $tableName c ON l._userid = c._id;");
    print(list.length);
    late Climber climber;
    for (var x in list) {
      var id = int.parse(x["_id"].toString());
      climber = Climber(
        username: x["username"].toString(),
        email: x["email"].toString(),
        firstname: x["firstname"].toString(),
        lastname: x["lastname"].toString(),
        password: "",
      );
      climber.id = id;
    }

    await db.close();
    return climber;
  }

  static Future logOut() async {
    var db = await PitcherDatabase().database;
    await db.delete("login");
  }

  static Climber returnMockClimber() {
    var climber = Climber(
        username: "daniel122",
        email: "yes@no.nl",
        firstname: "Daniel",
        lastname: "de Jong",
        password: "");
    climber.id = 1;
    return climber;
  }

  static Future<bool> checkIfLogin() async {
    var db = await PitcherDatabase().database;
    var res = await db.rawQuery("SELECT 1 FROM login;");
    return res.isNotEmpty;
  }
}
