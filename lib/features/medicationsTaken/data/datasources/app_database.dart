import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() {
    return _instance;
  }
  //Singleton instance
  AppDatabase._internal();

  Database? _db;

  Future<Database> get database async{
    return _db ??= await _initDb();
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'tukuntech.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  
  }

Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicationsTaken (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicineName TEXT,
        dosage TEXT,
        status TEXT,
        takenAt TEXT
      )
    ''');
  }


}