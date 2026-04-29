import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'edushare.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tạo bảng documents
    await db.execute('''
      CREATE TABLE documents (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT,
        rating REAL DEFAULT 0.0,
        downloadCount INTEGER DEFAULT 0,
        fileType TEXT,
        uploadDate TEXT,
        thumbnailUrl TEXT
      )
    ''');

    // Tạo bảng users
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        profileImageUrl TEXT,
        bio TEXT,
        documentCount INTEGER DEFAULT 0,
        contributionLevel TEXT DEFAULT 'bronze'
      )
    ''');

    // Tạo bảng search history
    await db.execute('''
      CREATE TABLE search_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        query TEXT NOT NULL,
        searchDate TEXT
      )
    ''');

    // Tạo bảng downloaded documents
    await db.execute('''
      CREATE TABLE downloaded_documents (
        id TEXT PRIMARY KEY,
        documentId TEXT NOT NULL,
        downloadPath TEXT,
        downloadDate TEXT
      )
    ''');
  }

  // Đóng database
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
