import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/schedule.dart';
import '../services/database_service.dart';

class ScheduleProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  List<Schedule> _schedules = [];
  List<Schedule> get schedules => _schedules;

  /// ------------------ FETCH ALL ------------------
  Future<void> fetchSchedules() async {
    final db = await _dbService.database;
    final result = await db.query('schedules');
    _schedules = result.map((row) => Schedule.fromMap(row)).toList();
    notifyListeners();
  }

  /// ------------------ ADD ------------------
  Future<void> addSchedule(
    String userId,
    String title,
    String dateTime,
    String description,
  ) async {
    final db = await _dbService.database;
    final newSchedule = Schedule(
      id: const Uuid().v4(),
      userId: userId,
      title: title,
      dateTime: dateTime,
      description: description,
    );

    await db.insert('schedules', newSchedule.toMap());
    _schedules.add(newSchedule);
    notifyListeners();
  }
}
