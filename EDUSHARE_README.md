# EduShare - Nền tảng chia sẻ tài liệu học tập cho sinh viên

EduShare là ứng dụng Flutter hiện đại dành cho sinh viên để chia sẻ, tìm kiếm và khám phá các tài liệu học tập từ cộng đồng toàn cầu.

## 🎯 Các tính năng chính

### 📱 Các màn hình chính
- **Onboarding**: Giới thiệu ứng dụng và các tính năng
- **Auth**: Đăng nhập/Đăng ký với Email, Google, Apple
- **Home**: Thanh tìm kiếm, danh mục, xu hướng, tài liệu mới
- **Discovery**: Khám phá tài liệu theo danh mục, filter ngôn ngữ, sorting
- **Document Details**: Xem trước PDF, tóm tắt, tác giả, nút tải/lưu/chia sẻ
- **Notification**: Thông báo bình luận, lượt tải, phê duyệt
- **Profile**: Thông tin cá nhân, thống kê, thành tựu, cấp độ đóng góp
- **Community**: Thảo luận, bài viết, top contributors
- **Upload**: Form tải lên tài liệu với tiêu đề, mô tả, danh mục, tag
- **Book Lending**: Quản lý mượn/cho mượn sách

## 📁 Cấu trúc dự án

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart      # Màu sắc ứng dụng (Xanh #1A56DB)
│   │   └── app_strings.dart     # Các chuỗi văn bản
│   ├── theme/
│   │   └── app_theme.dart       # Custom Theme Material Design
│   └── widgets/
│       ├── common_card.dart     # Widget thẻ chung
│       └── custom_button.dart   # Widget nút tùy chỉnh
├── data/
│   ├── models/
│   │   ├── document_model.dart  # Model tài liệu
│   │   └── user_model.dart      # Model người dùng
│   ├── mock_data/
│   │   └── mock_data.dart       # Dữ liệu mẫu
│   └── database/
│       ├── app_database.dart    # SQLite database setup
│       ├── document_dao.dart    # Document CRUD operations
│       └── user_dao.dart        # User CRUD operations
├── providers/
│   ├── auth_provider.dart       # State quản lý xác thực
│   ├── document_provider.dart   # State quản lý tài liệu
│   └── search_provider.dart     # State quản lý tìm kiếm
├── views/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── onboarding/
│   │   └── onboarding_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   │       └── trending_card.dart
│   ├── discovery/
│   │   └── discovery_screen.dart
│   ├── details/
│   │   └── document_detail_screen.dart
│   ├── notification/
│   │   └── notification_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   ├── community/
│   │   └── community_screen.dart
│   ├── upload/
│   │   └── upload_screen.dart
│   └── book_lending/
│       └── book_lending_screen.dart
├── main.dart
└── app.dart                     # Route & BottomNavigationBar
```

## 🛠️ Công nghệ sử dụng

### Frontend
- **Flutter 3.8+**: UI framework
- **Provider**: State management
- **Material Design 3**: Design system

### Database
- **SQLite (sqflite)**: Lưu trữ cục bộ
- **Bảng chính**: documents, users, search_history, downloaded_documents

### Networking
- **http/dio**: Gọi API
- **connectivity_plus**: Kiểm tra trạng thái mạng

### Camera & Media
- **camera**: Chụp ảnh
- **image_picker**: Chọn ảnh từ thư viện

### Storage
- **shared_preferences**: Lưu cài đặt cục bộ

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  sqflite: ^2.3.0
  path: ^1.8.0
  http: ^1.1.0
  dio: ^5.3.0
  connectivity_plus: ^5.0.0
  camera: ^0.10.5
  image_picker: ^1.0.0
  intl: ^0.19.0
  shared_preferences: ^2.2.0
```

## 🚀 Cách chạy dự án

### 1. Clone repository
```bash
git clone <repo-url>
cd mau1
```

### 2. Cài đặt dependencies
```bash
flutter pub get
```

### 3. Chạy ứng dụng
```bash
flutter run
```

### 4. Build APK (Android)
```bash
flutter build apk --release
```

## 🔐 Quyền hạn Android

Ứng dụng yêu cầu các quyền sau trong `AndroidManifest.xml`:
- `INTERNET`: Kết nối internet
- `CAMERA`: Chụp ảnh
- `ACCESS_NETWORK_STATE`: Kiểm tra trạng thái mạng
- `WRITE_EXTERNAL_STORAGE`: Lưu file
- `READ_EXTERNAL_STORAGE`: Đọc file

## 💾 Database Schema

### Bảng Documents
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

### Bảng Users
```sql
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  profileImageUrl TEXT,
  bio TEXT,
  documentCount INTEGER DEFAULT 0,
  contributionLevel TEXT DEFAULT 'bronze'
)
```

### Bảng Search History
```sql
CREATE TABLE search_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  query TEXT NOT NULL,
  searchDate TEXT
)
```

## 🎨 Thiết kế màu sắc

- **Màu chính**: `#1A56DB` (Xanh dương)
- **Nền**: `#F8F9FE` (Trắng nhạt)
- **Text chính**: `#111827` (Xám đậm)
- **Text phụ**: `#6B7280` (Xám)

## 📱 BottomNavigationBar

Gồm 5 tab chính:
1. 🏠 **Trang chủ** - Home Screen
2. 🔍 **Khám phá** - Discovery Screen
3. 👥 **Cộng đồng** - Community Screen
4. 🔔 **Thông báo** - Notification Screen
5. 👤 **Cá nhân** - Profile Screen

## 🔄 State Management (Provider)

### AuthProvider
- Quản lý đăng nhập/đăng ký
- Lưu trữ thông tin người dùng hiện tại
- Xác thực và phiên đăng nhập

### DocumentProvider
- Quản lý danh sách tài liệu
- Tìm kiếm và lọc tài liệu
- Cập nhật rating

### SearchProvider
- Quản lý lịch sử tìm kiếm
- Gợi ý tìm kiếm
- Danh mục phổ biến

## 🎯 Tính năng tiên tiến

- ✅ Authentication với Email, Google, Apple
- ✅ SQLite offline storage
- ✅ Rating hệ thống (sao)
- ✅ Search & Filter tài liệu
- ✅ Thảo luận cộng đồng
- ✅ Upload tài liệu với metadata
- ✅ Mượn/cho mượn sách
- ✅ Thông báo real-time
- ✅ Thống kê đóng góp
- ✅ Camera integration
- ✅ Offline mode

## 📝 TODO

- [ ] Tích hợp backend API
- [ ] Push notifications
- [ ] Video tutorials
- [ ] Dark mode
- [ ] Multi-language support
- [ ] Advanced analytics
- [ ] Social sharing
- [ ] Payment integration

## 📄 License

MIT License - feel free to use this project

## 👥 Contributors

- Nguyễn Văn A
- Trần Thị B
- Lê Quang C

## 📧 Liên hệ

Email: support@edushare.com
Website: www.edushare.com

---

**Tạo ngày**: 29/04/2026
**Phiên bản**: 0.1.0
**Trạng thái**: Phát triển
