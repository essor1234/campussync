import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/schedule.dart';
import '../models/event.dart';

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
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT UNIQUE,
        role TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE schedules(
        id TEXT PRIMARY KEY,
        userId TEXT,
        title TEXT,
        dateTime TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE events(
        id TEXT PRIMARY KEY,
        title TEXT,
        dateTime TEXT,
        description TEXT,
        attendees TEXT
      )
    ''');
  }

  // ---------------------- USER CRUD ----------------------

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return maps.map((map) => User.fromMap(map)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------------- SCHEDULE CRUD ----------------------

  Future<int> insertSchedule(Schedule schedule) async {
    final db = await database;
    return await db.insert(
      'schedules',
      schedule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Schedule>> getAllSchedules() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('schedules');
    return maps.map((map) => Schedule.fromMap(map)).toList();
  }

  Future<List<Schedule>> getSchedulesByUser(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'schedules',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps.map((map) => Schedule.fromMap(map)).toList();
  }

  Future<int> updateSchedule(Schedule schedule) async {
    final db = await database;
    return await db.update(
      'schedules',
      schedule.toMap(),
      where: 'id = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<int> deleteSchedule(String id) async {
    final db = await database;
    return await db.delete('schedules', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------------- EVENT CRUD ----------------------

  Future<int> insertEvent(Event event) async {
    final db = await database;
    return await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> getAllEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events');
    return maps.map((map) => Event.fromMap(map)).toList();
  }

  Future<int> updateEvent(Event event) async {
    final db = await database;
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(String id) async {
    final db = await database;
    return await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------------- HELPER ----------------------

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
