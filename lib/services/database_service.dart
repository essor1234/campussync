import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart'; // Import others

class DatabaseService {
  static Database? _database;
  static const String dbName = 'school.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, email TEXT UNIQUE, role TEXT)
    ''');
    await db.execute('''
      CREATE TABLE schedules(id TEXT PRIMARY KEY, userId TEXT, title TEXT, dateTime TEXT, description TEXT)
    ''');
    await db.execute('''
      CREATE TABLE events(id TEXT PRIMARY KEY, title TEXT, dateTime TEXT, description TEXT, attendees TEXT)
    ''');
  }

  // CRUD methods: e.g., Future<int> insertUser(User user) async { ... }
  // Implement insert, getAll, update, delete for each model.
}
