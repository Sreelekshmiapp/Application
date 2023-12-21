

import 'package:first_app/DB/User.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Database? _database;
  static const String databaseName = 'mydb.db';
  static const int databaseVersion = 1;
  static const String tableName = 'users';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
  // Initialize FFI for SQLite
if (kIsWeb) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  } else {
    databaseFactory = databaseFactoryFfi;
  }
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, databaseName);

  return await openDatabase(
    path,
    version: databaseVersion,
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          email TEXT,
          password TEXT
        )
      ''');
    },
  );
}


  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(tableName, user);
  }





  //vieew data
  Future<List<User>> getUsersFromDatabase(Database database) async {
    final List<Map<String, dynamic>> userMaps = await database.query(
      tableName,
      orderBy: 'id DESC',
    );
    return List.generate(userMaps.length, (i) {
      return User(
        id: userMaps[i]['id'],
        email: userMaps[i]['email'],
        password: userMaps[i]['password'],
      );
    });
  }





  // Future<void> displayUsers() async {
  //   final dbHelper = DatabaseHelper();
  //   final Database database = await dbHelper.database;
  //   final users = await dbHelper.getUsersFromDatabase(database);
  //
  //   for (final user in users) {
  //     print('User ID: ${user.id}, Email: ${user.email}, Password: ${user
  //         .password}');
  //   }
  // }

  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateUser(User updatedUser) async {
    final db = await database;

    return await db.update(
      tableName,
      updatedUser.toMap(), // Convert User object to a map
      where: 'id = ?',
      whereArgs: [updatedUser.id],
    );
  }
}