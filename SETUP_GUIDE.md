# 🚀 EduShare App - Setup & Implementation Guide

## ✅ Completed Setup

### 1. **Project Structure** ✓
- ✅ Complete folder hierarchy created
- ✅ All 11 screens implemented
- ✅ Database layer with SQLite
- ✅ State management with Provider
- ✅ Theme and constants defined
- ✅ Reusable widgets created

### 2. **Folder Structure**
```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_strings.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       ├── common_card.dart
│       └── custom_button.dart
├── data/
│   ├── models/
│   │   ├── document_model.dart
│   │   └── user_model.dart
│   ├── mock_data/
│   │   └── mock_data.dart
│   └── database/
│       ├── app_database.dart
│       ├── document_dao.dart
│       └── user_dao.dart
├── providers/
│   ├── auth_provider.dart
│   ├── document_provider.dart
│   └── search_provider.dart
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
└── app.dart
```

## 🎯 Screen Details

### 1. **Onboarding Screen**
- Logo and tagline
- Feature highlights
- "Bắt đầu ngay" button → Login
- "Đăng nhập" text button → Login

### 2. **Login Screen**
- Toggle between Login/Register
- Email input
- Password input with forgot password link
- Login button → MainApp
- Social login (Google, Apple)

### 3. **Home Screen**
- Header with greeting + avatar
- Search bar with mic icon
- Category cards (Lập trình, Toán, Vật lý, Tiếng Anh)
- Trending section
- New uploads section
- Trending documents with ratings

### 4. **Discovery Screen**
- Category selection chips
- Language filter for programming
- Sort dropdown
- Document list with ratings
- Filter modal

### 5. **Document Detail Screen**
- Expandable header with document icon
- Title and author
- Rating (5-star)
- Stats (downloads, views, file type)
- Summary section
- Document info
- Tags
- Download/Share/Save buttons
- Comments section

### 6. **Notification Screen**
- List of notifications
- Types: comments, downloads, approvals, follows, posts
- Unread indicator
- Timestamp
- Mark as read functionality

### 7. **Profile Screen**
- Header with gradient background
- User avatar and info
- Bio section
- Stats (documents, followers, following)
- Contribution level progress bar
- Achievement badges
- My documents list
- Logout and Upload buttons

### 8. **Community Screen**
- Two tabs: Discussion & Top Contributors
- Discussion posts with replies, views
- Top contributors leaderboard
- Follow button
- Create post FAB

### 9. **Upload Screen**
- File upload area
- Title input
- Category dropdown
- Description textarea
- Tags input
- Upload button with loading state

### 10. **Book Lending Screen**
- Book list (initially empty)
- Add book modal with:
  - Title
  - Author
  - Condition (Rất tốt, Tốt, Khá, Trung bình)
  - Exchange location
- Edit and delete buttons
- FAB to add book

### 11. **Register Screen**
- Similar to login but for registration
- Additional name field
- Confirm password field
- Register button

## 🎨 Design System

### Colors
```dart
AppColors {
  primary: #1A56DB (Blue)
  background: #F8F9FE (Light)
  textMain: #111827 (Dark)
  textSecondary: #6B7280 (Gray)
  cardShadow: #1A000000
}
```

### Typography
- Display Large: 32px, Bold
- Display Medium: 28px, Bold
- Headline Medium: 20px, SemiBold
- Body Large: 16px, Regular
- Body Medium: 14px, Regular
- Label Small: 12px, Regular

### Components
- Button radius: 8-12px
- Card radius: 12px
- Input radius: 8px
- Avatar: Circular

## 📱 Navigation

### BottomNavigationBar (5 tabs)
```
[Home] [Discovery] [Community] [Notification] [Profile]
```

### Tab Routes
- Tab 0: HomeScreen
- Tab 1: DiscoveryScreen
- Tab 2: CommunityScreen
- Tab 3: NotificationScreen
- Tab 4: ProfileScreen

## 💾 Database

### SQLite Tables

#### documents
```sql
- id (PRIMARY KEY)
- title
- author
- category
- description
- rating (0.0-5.0)
- downloadCount
- fileType (PDF, DOCX, PPTX)
- uploadDate
- thumbnailUrl
```

#### users
```sql
- id (PRIMARY KEY)
- name
- email
- profileImageUrl
- bio
- documentCount
- contributionLevel
```

#### search_history
```sql
- id (AUTO_INCREMENT)
- query
- searchDate
```

#### downloaded_documents
```sql
- id (PRIMARY KEY)
- documentId
- downloadPath
- downloadDate
```

## 🔄 State Management

### AuthProvider
Methods:
- `login(email, password)` → bool
- `register(name, email, password)` → bool
- `logout()` → Future<void>
- `updateProfile(user)` → Future<bool>

State:
- currentUser: UserModel?
- isLoading: bool
- errorMessage: String?

### DocumentProvider
Methods:
- `loadDocuments()` → Future<void>
- `loadDocumentsByCategory(category)` → Future<void>
- `searchDocuments(query)` → Future<void>
- `addDocument(document)` → Future<bool>
- `updateDocumentRating(id, rating)` → Future<bool>

State:
- documents: List<DocumentModel>
- filteredDocuments: List<DocumentModel>
- isLoading: bool

### SearchProvider
Methods:
- `addSearchQuery(query)` → Future<void>
- `clearSearchHistory()` → Future<void>
- `removeSearchQuery(query)` → Future<void>
- `getPopularCategories()` → List<String>
- `getProgrammingLanguages()` → List<String>

State:
- searchHistory: List<String>
- suggestions: List<String>

## 📦 Key Dependencies

```yaml
provider: ^6.0.0           # State management
sqflite: ^2.3.0           # SQLite database
http: ^1.1.0              # HTTP requests
dio: ^5.3.0               # HTTP client
connectivity_plus: ^5.0.0 # Network status
camera: ^0.10.5           # Camera access
image_picker: ^1.0.0      # Image selection
intl: ^0.19.0             # Internationalization
shared_preferences: ^2.2.0 # Local storage
```

## 🔐 Android Permissions

Already added to `AndroidManifest.xml`:
- `INTERNET`
- `CAMERA`
- `ACCESS_NETWORK_STATE`
- `WRITE_EXTERNAL_STORAGE`
- `READ_EXTERNAL_STORAGE`

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Generate Freezed Models (Optional)
```bash
flutter pub run build_runner build
```

### 3. Run the App
```bash
flutter run
```

### 4. Run on Android
```bash
flutter run -d android
```

## 📝 Usage Examples

### Using Provider
```dart
// Build context access
final authProvider = context.read<AuthProvider>();
final documents = context.watch<DocumentProvider>().documents;

// Login
await authProvider.login(email, password);

// Get documents by category
await documentProvider.loadDocumentsByCategory('Lập trình');

// Search
await searchProvider.addSearchQuery('Python');
```

### Using Database
```dart
final documentDAO = DocumentDAO();
final docs = await documentDAO.getAllDocuments();
final doc = await documentDAO.getDocumentById('doc_id');
await documentDAO.insertDocument(newDocument);
```

## 🎯 Next Steps for Backend Integration

1. **API Setup**
   - Create API endpoints for auth, documents, users
   - Setup API base URL in constants

2. **HTTP Client Setup**
   - Configure Dio with interceptors
   - Add error handling

3. **Data Sync**
   - Implement API calls in providers
   - Cache data locally with SQLite

4. **Real-time Features**
   - Setup WebSocket for notifications
   - Implement push notifications

5. **Authentication**
   - Integrate Firebase Auth (optional)
   - Setup JWT tokens

## 🐛 Troubleshooting

### Database Issues
```dart
// Reset database
await database.close();
// Delete and recreate
```

### Provider Issues
- Ensure MultiProvider wraps MyApp
- Use `context.read()` outside build
- Use `context.watch()` inside build

### Navigation Issues
- Check MainApp is properly imported
- Verify route names match

## 📚 Resources

- [Flutter Docs](https://flutter.dev)
- [Provider Package](https://pub.dev/packages/provider)
- [SQLite Tutorial](https://pub.dev/packages/sqflite)
- [Material Design 3](https://m3.material.io/)

## 💡 Tips & Best Practices

1. Always use `const` constructors
2. Apply theme colors from AppColors
3. Use string constants from AppStrings
4. Handle loading states in providers
5. Add proper error handling
6. Test on real Android device
7. Follow Clean Code principles

---

**Status**: ✅ Frontend Complete - Ready for Backend Integration
**Last Updated**: 29/04/2026
**Version**: 0.1.0
