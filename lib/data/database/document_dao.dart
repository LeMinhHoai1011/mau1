import 'package:sqflite/sqflite.dart';
import '../models/document_model.dart';
import 'app_database.dart';

class DocumentDAO {
  final database = AppDatabase();

  // Create
  Future<String> insertDocument(DocumentModel document) async {
    final db = await database.database;
    await db.insert(
      'documents',
      document.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return document.id;
  }

  // Read all
  Future<List<DocumentModel>> getAllDocuments() async {
    final db = await database.database;
    final maps = await db.query('documents');
    return List.generate(maps.length, (i) => DocumentModel.fromMap(maps[i]));
  }

  // Read by category
  Future<List<DocumentModel>> getDocumentsByCategory(String category) async {
    final db = await database.database;
    final maps = await db.query(
      'documents',
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) => DocumentModel.fromMap(maps[i]));
  }

  // Read by ID
  Future<DocumentModel?> getDocumentById(String id) async {
    final db = await database.database;
    final maps = await db.query(
      'documents',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return DocumentModel.fromMap(maps.first);
    }
    return null;
  }

  // Update
  Future<int> updateDocument(DocumentModel document) async {
    final db = await database.database;
    return db.update(
      'documents',
      document.toMap(),
      where: 'id = ?',
      whereArgs: [document.id],
    );
  }

  // Delete
  Future<int> deleteDocument(String id) async {
    final db = await database.database;
    return db.delete(
      'documents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Search documents
  Future<List<DocumentModel>> searchDocuments(String query) async {
    final db = await database.database;
    final maps = await db.query(
      'documents',
      where: 'title LIKE ? OR author LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) => DocumentModel.fromMap(maps[i]));
  }
}
