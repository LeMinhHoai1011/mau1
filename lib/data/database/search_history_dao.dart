import 'package:sqflite/sqflite.dart';
import '../models/search_history_model.dart';
import 'app_database.dart';

class SearchHistoryDAO {
  final database = AppDatabase();

  // Insert search query
  Future<int> insertSearchHistory(SearchHistoryModel history) async {
    final db = await database.database;
    return await db.insert(
      'search_history',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all search history
  Future<List<SearchHistoryModel>> getAllSearchHistory() async {
    final db = await database.database;
    final maps = await db.query('search_history', orderBy: 'searchDate DESC');
    return List.generate(maps.length, (i) => SearchHistoryModel.fromMap(maps[i]));
  }

  // Delete search history by id
  Future<int> deleteSearchHistory(int id) async {
    final db = await database.database;
    return db.delete(
      'search_history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all search history
  Future<int> clearAllSearchHistory() async {
    final db = await database.database;
    return db.delete('search_history');
  }
}