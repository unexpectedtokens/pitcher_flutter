import 'location.dart';



const String tableName = "climb";

class Climb{
  final String name;
  final String description;
  final Location location;
  final String grade;
  final int postedByID;

  Climb({
    required this.name,
    required this.description,
    required this.location,
    required this.grade,
    required this.postedByID,
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
        typeofclimb VARCHAR(7)
       );
    ''';


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




