import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_three/services/models/employee_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  final table = 'employee_table';
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
   CREATE TABLE $table(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT ,
          userName TEXT ,
          email TEXT ,
          profileImage TEXT,
          phone TEXT,
          website TEXT
          )
''');
  }

  Future<int> insert(EmployeeDetails employee,
      {ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace}) async {
    int? id;
    try {
      Database db = await instance.database;

      id = await db.insert(table, employee.toJson(),
          conflictAlgorithm: conflictAlgorithm);
      return id;
    } catch (e) {
      print('---$e');
    }
    return id!;
  }

  Future<List<EmployeeDetails>> queryEmployeeList() async {
    List<EmployeeDetails> empList = [];
    Database db = await instance.database;
    final maps = await db.query(table);

    if (maps.isNotEmpty) {
      empList = maps.map((json) => EmployeeDetails.fromJson(json)).toList();

      return empList;
    } else {
      throw Exception('not found');
    }
  }
}
