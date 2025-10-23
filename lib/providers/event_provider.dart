import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/event.dart';
import '../services/database_service.dart';

class EventProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  List<Event> _events = [];
  List<Event> get events => _events;

  /// ------------------ FETCH ALL ------------------
  Future<void> fetchEvents() async {
    final db = await _dbService.database;
    final result = await db.query('events');
    _events = result.map((row) => Event.fromMap(row)).toList();
    notifyListeners();
  }

  /// ------------------ ADD ------------------
  Future<void> addEvent(
    String title,
    String dateTime,
    String description,
    String attendees,
  ) async {
    final db = await _dbService.database;
    final newEvent = Event(
      id: const Uuid().v4(),
      title: title,
      dateTime: dateTime,
      description: description,
      attendees: attendees,
    );

    await db.insert('events', newEvent.toMap());
    _events.add(newEvent);
    notifyListeners();
  }
}
