import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';
import '../services/database_service.dart';

class UserProvider extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  User? _user;
  User? get user => _user;

  /// ------------------ LOGIN ------------------
  Future<void> login(String email) async {
    final db = await _dbService.database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      _user = User.fromMap(result.first);
      notifyListeners();
    } else {
      throw Exception('User not found. Please register first.');
    }
  }

  /// ------------------ REGISTER ------------------
  Future<void> register(String email, {String? name}) async {
    final db = await _dbService.database;

    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existing.isNotEmpty) {
      throw Exception('Email already registered.');
    }

    final newUser = User(
      id: const Uuid().v4(),
      name: name ?? email.split('@').first,
      email: email,
      role: 'student',
    );

    await db.insert('users', newUser.toMap());
    _user = newUser;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
}
