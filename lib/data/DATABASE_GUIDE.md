# 📊 Database & Models Structure Guide

**Project:** EduShare  
**Date:** 2026-05-21  

---

## 📁 Project Structure

```
lib/
  ├── data/
  │   ├── database/
  │   │   ├── app_database.dart ✅
  │   │   ├── document_dao.dart ✅
  │   │   ├── downloaded_document_dao.dart ✅
  │   │   ├── search_history_dao.dart ✅
  │   │   └── user_dao.dart ✅
  │   │
  │   └── models/
  │       ├── document_model.dart ✅
  │       ├── downloaded_document_model.dart ✅
  │       ├── search_history_model.dart ✅
  │       └── user_model.dart ✅
  │
  └── core/
      └── router/ ✅
          ├── routes.dart
          ├── route_arguments.dart
          ├── app_router.dart
          ├── router_helper.dart
          └── PARAMETER_VALIDATION_REPORT.md
```

---

## 🗄️ Database Schema

### 1️⃣ Users Table
**File:** `lib/data/database/app_database.dart` (CREATE TABLE users)  
**Model:** `lib/data/models/user_model.dart`  
**DAO:** `lib/data/database/user_dao.dart`

```sql
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  profileImageUrl TEXT,
  bio TEXT,
  documentCount INTEGER DEFAULT 0,
  contributionLevel TEXT DEFAULT 'bronze'
)
```

**Fields:**
- `id`: User unique identifier (email or UUID)
- `name`: Full name của user
- `email`: Email address (unique)
- `phone`: Optional phone number
- `profileImageUrl`: Avatar URL
- `bio`: User biography/description
- `documentCount`: Số tài liệu đã upload
- `contributionLevel`: bronze/silver/gold/platinum

---

### 2️⃣ Documents Table
**File:** `lib/data/database/app_database.dart` (CREATE TABLE documents)  
**Model:** `lib/data/models/document_model.dart`  
**DAO:** `lib/data/database/document_dao.dart`

```sql
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
```

**Fields:**
- `id`: Document unique identifier (UUID)
- `title`: Tên tài liệu
- `author`: Tác giả/người upload
- `category`: Danh mục (Lập trình, Toán, v.v.)
- `description`: Mô tả chi tiết
- `rating`: Đánh giá 0.0-5.0
- `downloadCount`: Số lần tải
- `fileType`: PDF, DOCX, PPT, etc.
- `uploadDate`: Ngày upload (ISO format)
- `thumbnailUrl`: URL ảnh thumbnail

---

### 3️⃣ Search History Table
**File:** `lib/data/database/app_database.dart` (CREATE TABLE search_history)  
**Model:** `lib/data/models/search_history_model.dart`  
**DAO:** `lib/data/database/search_history_dao.dart`

```sql
CREATE TABLE search_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  query TEXT NOT NULL,
  searchDate TEXT
)
```

**Fields:**
- `id`: Auto-increment primary key
- `query`: Search query string
- `searchDate`: Ngày tìm kiếm (ISO format)

**Usage:** Lưu lịch tìm kiếm để suggest searches cũ

---

### 4️⃣ Downloaded Documents Table
**File:** `lib/data/database/app_database.dart` (CREATE TABLE downloaded_documents)  
**Model:** `lib/data/models/downloaded_document_model.dart`  
**DAO:** `lib/data/database/downloaded_document_dao.dart`

```sql
CREATE TABLE downloaded_documents (
  id TEXT PRIMARY KEY,
  documentId TEXT NOT NULL,
  downloadPath TEXT,
  downloadDate TEXT
)
```

**Fields:**
- `id`: Unique identifier
- `documentId`: Reference to documents table
- `downloadPath`: Local file path sau khi tải
- `downloadDate`: Ngày tải (ISO format)

**Usage:** Track downloaded files, cho phép access offline

---

## 📦 Models Structure

### ✅ UserModel
```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImageUrl;
  final String bio;
  final int documentCount;
  final String contributionLevel;

  // Methods: toMap(), fromMap()
}
```

### ✅ DocumentModel
```dart
class DocumentModel {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final double rating;
  final int downloadCount;
  final String fileType;
  final String uploadDate;
  final String? thumbnailUrl;

  // Methods: toMap(), fromMap()
}
```

### ✅ SearchHistoryModel
```dart
class SearchHistoryModel {
  final int id;
  final String query;
  final String? searchDate;

  // Methods: toMap(), fromMap()
}
```

### ✅ DownloadedDocumentModel
```dart
class DownloadedDocumentModel {
  final String id;
  final String documentId;
  final String? downloadPath;
  final String? downloadDate;

  // Methods: toMap(), fromMap()
}
```

---

## 🔌 DAOs (Data Access Objects)

### Purpose
Each DAO provides database operations cho một model:
- `insert()` - Thêm record mới
- `update()` - Cập nhật record
- `delete()` - Xóa record
- `getById()` - Lấy một record
- `getAll()` - Lấy tất cả records
- `query()` - Custom query

### Example: UserDAO
```dart
class UserDAO {
  Future<void> insertUser(UserModel user) async { ... }
  Future<UserModel?> getUserById(String id) async { ... }
  Future<List<UserModel>> getAllUsers() async { ... }
  Future<void> updateUser(UserModel user) async { ... }
  Future<void> deleteUser(String id) async { ... }
}
```

---

## 🔗 Data Flow

```
Screen (e.g., HomeScreen)
    ↓
Provider (e.g., DocumentProvider)
    ↓
DAO (e.g., DocumentDAO)
    ↓
AppDatabase.database
    ↓
SQLite DB
    ↓
Model (e.g., DocumentModel)
    ↓
Back to Screen
```

---

## 💾 Usage Examples

### ✅ Get All Documents
```dart
// In Screen
final docs = context.read<DocumentProvider>().documents;

// In Provider
Future<void> fetchDocuments() async {
  final dao = DocumentDAO();
  final docs = await dao.getAllDocuments();
  documents = docs;
  notifyListeners();
}

// In DAO
Future<List<DocumentModel>> getAllDocuments() async {
  final db = await AppDatabase().database;
  final maps = await db.query('documents');
  return maps.map((map) => DocumentModel.fromMap(map)).toList();
}
```

### ✅ Get Document by ID
```dart
// Already implemented in app_database.dart
Future<Map<String, dynamic>?> getDocumentById(String id) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'documents',
    where: 'id = ?',
    whereArgs: [id],
  );
  if (maps.isNotEmpty) {
    return maps.first;
  }
  return null;
}
```

### ✅ Insert User
```dart
// In UserDAO
Future<void> insertUser(UserModel user) async {
  final db = await AppDatabase().database;
  await db.insert('users', user.toMap());
}
```

---

## 🏗️ Best Practices

### 1. Always Use Models
```dart
// ✅ GOOD
DocumentModel doc = DocumentModel.fromMap(data);

// ❌ BAD
Map<String, dynamic> doc = data;
```

### 2. Use DAOs for Database Operations
```dart
// ✅ GOOD
final dao = DocumentDAO();
final docs = await dao.getAllDocuments();

// ❌ BAD
final db = await AppDatabase().database;
final maps = await db.query('documents');
```

### 3. Use Providers for State Management
```dart
// ✅ GOOD
final docs = context.read<DocumentProvider>().documents;

// ❌ BAD
final db = await AppDatabase().database;
```

### 4. Always Handle Nulls
```dart
// ✅ GOOD
final user = await userDAO.getUserById(id);
if (user != null) {
  // Use user
}

// ❌ BAD
final user = await userDAO.getUserById(id);
print(user.name); // May crash if null
```

---

## 📝 Migration Guide (Khi cần update schema)

### Trong `_onUpgrade()` method:
```dart
Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    // ALTER TABLE to add new column
    await db.execute('ALTER TABLE documents ADD COLUMN views INTEGER DEFAULT 0');
  }
  if (oldVersion < 3) {
    // Create new table
    await db.execute('''
      CREATE TABLE ratings (
        id TEXT PRIMARY KEY,
        documentId TEXT NOT NULL,
        userId TEXT NOT NULL,
        rating REAL NOT NULL
      )
    ''');
  }
}
```

---

## ✅ Current Status

- ✅ 4 tables created
- ✅ 4 models implemented
- ✅ 4 DAOs created
- ✅ AppDatabase configured
- ✅ Schema matches models
- ✅ Parameters validated

---

## 🚀 Next Steps

1. **Implement DAOs fully** - Thêm tất cả methods (insert, update, delete, query)
2. **Create Providers** - Dùng DAOs để manage state
3. **Bind Screens to Providers** - Screens consume data từ Providers
4. **Add Error Handling** - Try-catch cho database operations
5. **Add Migrations** - Khi schema thay đổi

---

*Version: 1.0 - Structure Complete*  
*Last Updated: 2026-05-21*
