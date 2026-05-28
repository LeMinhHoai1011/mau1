import 'package:sqflite/sqflite.dart';
import '../models/downloaded_document_model.dart';
import 'app_database.dart';

class DownloadedDocumentDAO {
  final database = AppDatabase();

  // Insert downloaded document
  Future<String> insertDownloadedDocument(DownloadedDocumentModel document) async {
    final db = await database.database;
    await db.insert(
      'downloaded_documents',
      document.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return document.id;
  }

  // Get all downloaded documents
  Future<List<DownloadedDocumentModel>> getAllDownloadedDocuments() async {
    final db = await database.database;
    final maps = await db.query('downloaded_documents', orderBy: 'downloadDate DESC');
    return List.generate(maps.length, (i) => DownloadedDocumentModel.fromMap(maps[i]));
  }

  // Get downloaded document by id
  Future<DownloadedDocumentModel?> getDownloadedDocumentById(String id) async {
    final db = await database.database;
    final maps = await db.query(
      'downloaded_documents',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return DownloadedDocumentModel.fromMap(maps.first);
    }
    return null;
  }

  // Delete downloaded document
  Future<int> deleteDownloadedDocument(String id) async {
    final db = await database.database;
    return db.delete(
      'downloaded_documents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Check if document is downloaded
  Future<bool> isDocumentDownloaded(String documentId) async {
    final db = await database.database;
    final maps = await db.query(
      'downloaded_documents',
      where: 'documentId = ?',
      whereArgs: [documentId],
    );
    return maps.isNotEmpty;
  }
}