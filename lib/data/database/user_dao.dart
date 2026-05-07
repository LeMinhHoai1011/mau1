import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';
import 'app_database.dart';

class UserDAO {
  final database = AppDatabase();

  // Create
  Future<String> insertUser(UserModel user) async {
    final db = await database.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user.id;
  }

  // Read by ID
  Future<UserModel?> getUserById(String id) async {
    final db = await database.database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  // Read by email
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database.database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  // Read by phone
  Future<UserModel?> getUserByPhone(String phone) async {
    final db = await database.database;
    final maps = await db.query(
      'users',
      where: 'phone = ?',
      whereArgs: [phone],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  // Get all users
  Future<List<UserModel>> getAllUsers() async {
    final db = await database.database;
    final maps = await db.query('users');
    return List.generate(maps.length, (i) => UserModel.fromMap(maps[i]));
  }

  // Update
  Future<int> updateUser(UserModel user) async {
    final db = await database.database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Delete
  Future<int> deleteUser(String id) async {
    final db = await database.database;
    return db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get top contributors
  Future<List<UserModel>> getTopContributors() async {
    final db = await database.database;
    final maps = await db.query(
      'users',
      orderBy: 'documentCount DESC',
      limit: 10,
    );
    return List.generate(maps.length, (i) => UserModel.fromMap(maps[i]));
  }
}
