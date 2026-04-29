# 📱 EduShare Flutter App - Development Guidelines

## Project Overview
EduShare là ứng dụng Flutter cho phép sinh viên chia sẻ, tìm kiếm và khám phá tài liệu học tập từ cộng đồng.

## 🎯 Key Features Implemented
✅ Complete folder structure with all screens
✅ SQLite database with DAOs for CRUD operations
✅ Material Design 3 theme (Blue #1A56DB)
✅ State management with Provider pattern
✅ BottomNavigationBar with 5 main tabs
✅ Authentication screens (Login/Register/Onboarding)
✅ Document discovery and filtering
✅ Community discussion features
✅ User profiles with achievements
✅ Upload documents functionality
✅ Book lending system
✅ Android permissions configured

## 📋 Architecture

### Data Layer
- **Models**: DocumentModel, UserModel with toMap/fromMap methods
- **DAOs**: DocumentDAO, UserDAO for database operations
- **Database**: SQLite with tables for documents, users, search_history

### Business Logic Layer
- **Providers**: AuthProvider, DocumentProvider, SearchProvider
- **State Management**: Using Provider pattern for clean architecture

### Presentation Layer
- **Widgets**: CustomButton, CommonCard, TrendingCard
- **Screens**: 11 main screens with consistent styling
- **Theme**: Custom Material Design 3 theme

## 🛠️ Tech Stack
- Flutter 3.8+
- Provider 6.0.0
- SQLite (sqflite 2.3.0)
- Material Design 3
- Dio for API calls
- Image picker & Camera support

## 📱 Screen Structure

### Tab 1: Home Screen
- Search bar with categories
- Trending documents
- Recent uploads
- Category cards

### Tab 2: Discovery Screen
- Category selection
- Language filter (for programming)
- Sorting options
- Document list with ratings

### Tab 3: Community Screen
- Discussion posts
- Top contributors
- Post creation

### Tab 4: Notification Screen
- Comment notifications
- Download milestones
- Approval notifications

### Tab 5: Profile Screen
- User stats (documents, followers)
- Achievement badges
- Contribution level
- My documents list

## 🎨 Design System

### Colors
- Primary: #1A56DB (Blue)
- Background: #F8F9FE
- Text Main: #111827
- Text Secondary: #6B7280

### Typography
- Display Large: 32px, bold
- Headline: 20px, semibold
- Body: 14-16px
- Small: 12px

### Components
- Cards with shadow
- Round buttons (12px radius)
- Input fields with rounded borders
- Rating using star icons
- Avatar circles

## 📦 Database Operations

### DocumentDAO Methods
- `getAllDocuments()` - Fetch all documents
- `getDocumentsByCategory()` - Filter by category
- `searchDocuments()` - Search by title/author
- `insertDocument()` - Add new document
- `updateDocument()` - Update existing

### UserDAO Methods
- `getUserById()` - Get user profile
- `getTopContributors()` - Leaderboard
- `updateUser()` - Update profile

## 🔄 State Management Flow

```
UI Screen
  ↓
Provider.of<Provider>(context)
  ↓
Provider Methods
  ↓
DAO/Database
  ↓
SQLite
```

## 🚀 Development Workflow

### Adding New Feature
1. Create model if needed in `/data/models/`
2. Add DAO methods in `/data/database/`
3. Create provider in `/providers/`
4. Build UI screen in `/views/`
5. Add routes in `app.dart`

### Best Practices
- Use const constructors
- Apply custom theme throughout
- Add error handling in providers
- Use proper routing with named routes (future)
- Implement proper error states

## 📝 Code Conventions
- Camel case for variables/methods
- PascalCase for classes
- Follow Dart style guide
- Add comments for complex logic
- Use meaningful variable names

## 🔧 Android Configuration
Permissions added to AndroidManifest.xml:
- INTERNET
- CAMERA
- ACCESS_NETWORK_STATE
- WRITE_EXTERNAL_STORAGE
- READ_EXTERNAL_STORAGE

## 📚 Future Enhancements
- [ ] Backend API integration
- [ ] Firebase authentication
- [ ] Real-time push notifications
- [ ] Video tutorials
- [ ] Dark mode support
- [ ] Multilingual support
- [ ] Advanced search with filters
- [ ] Payment integration

## 🐛 Known Issues
None currently - project ready for API integration

## 📞 Support
For development questions, refer to:
- Flutter docs: https://flutter.dev
- Provider package: https://pub.dev/packages/provider
- SQLite: https://pub.dev/packages/sqflite

---
Last Updated: 29/04/2026
Status: Development Complete - Ready for Backend Integration
