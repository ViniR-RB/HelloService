import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'user.db';
    final path = join(dbpath, dbname);
    // Conectando
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user(id TEXT,username TEXT,email TEXT,webtoken TEXT,type TEXT)');
  }

  Future<void> insertUser(User user) async {
    final db = await database;
   
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteToken(String userId) async {
    final db = await database;

    await db.delete('user', where: 'id == ?', whereArgs: [userId]);
  }

  Future<List<User>> getUser() async {
    final db = await database;

    List<Map<String, dynamic>> items = await db.query('user');
   
    return List.generate(
      items.length,
      (i) => User(
        items[i]['id'],
        items[i]['username'],
        items[i]['webtoken'],
        items[i]['avatar'] ?? '',
        items[i]['type'] ?? '',
        email: items[i]['email'],
        password: '',
      ),
    );
  }

  updateToken({required String userId, required String userToken}) async {
    final db = await database;
    int items = await db.rawUpdate(
        'UPDATE user SET token = ? WHERE id = $userId', ['$userToken']);
  }
}
