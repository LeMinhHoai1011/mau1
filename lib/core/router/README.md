# Router System - EduShare

## 📋 Mục đích
Hệ thống router tập trung để quản lý tất cả điều hướng (navigation) trong ứng dụng EduShare.

## 📁 Cấu trúc
```
lib/core/router/
  ├── routes.dart           # Định nghĩa tất cả route names
  ├── route_arguments.dart  # Các lớp Arguments để truyền dữ liệu giữa screens
  ├── app_router.dart       # Quản lý route generation
  ├── router_helper.dart    # Hàm tiện ích để navigate
  ├── router.dart           # Export tất cả
  └── README.md            # Tài liệu này
```

## 🚀 Cách sử dụng

### 1. **Điều hướng cơ bản (không có tham số)**
```dart
import 'package:app/core/router/router_helper.dart';

// Đi đến settings
RouterHelper.goSettings(context);

// Đi đến upload
RouterHelper.goUpload(context);

// Quay lại
RouterHelper.goBack(context);
```

### 2. **Điều hướng với tham số**
```dart
// Đi đến document detail với tham số
RouterHelper.goDocumentDetail(
  context,
  documentId: 'doc123',
  title: 'Python Basics',
  imagePath: 'assets/images/python.jpg',
);

// Đi đến search với initial query
RouterHelper.goSearch(
  context,
  initialQuery: 'Flutter',
);

// Đi đến review
RouterHelper.goReview(
  context,
  documentId: 'doc123',
  documentTitle: 'Python for Beginners',
);
```

### 3. **Điều hướng và xóa tất cả routes trước (Login/Logout)**
```dart
// Logout - quay về login
RouterHelper.goLogin(context);

// Login thành công - đi đến MainApp
RouterHelper.goMainApp(context);

// Logout hoàn toàn - quay về login và xóa stack
RouterHelper.goHome(context);
```

## 📝 Thêm route mới

### Bước 1: Thêm route name vào `routes.dart`
```dart
class Routes {
  // ...
  static const String myNewScreen = '/my-new-screen';
  // ...
}
```

### Bước 2: Tạo Arguments class trong `route_arguments.dart` (nếu cần)
```dart
class MyNewScreenArguments {
  final String id;
  final String name;

  MyNewScreenArguments({
    required this.id,
    required this.name,
  });
}
```

### Bước 3: Thêm route vào `app_router.dart`
```dart
case Routes.myNewScreen:
  final args = settings.arguments as MyNewScreenArguments?;
  return _buildRoute(
    MyNewScreen(
      id: args?.id ?? '',
      name: args?.name ?? '',
    ),
    settings,
  );
```

### Bước 4: Thêm helper function vào `router_helper.dart`
```dart
static Future<dynamic> goMyNewScreen(
  BuildContext context, {
  required String id,
  required String name,
}) {
  return Navigator.pushNamed(
    context,
    Routes.myNewScreen,
    arguments: MyNewScreenArguments(id: id, name: name),
  );
}
```

## 🎨 Route Transitions

Router hỗ trợ các loại transitions:
- `_buildRoute()` - Standard Material Route
- `_buildFadeRoute()` - Fade transition
- `_buildSlideRoute()` - Slide transition từ phải sang trái

Để sử dụng:
```dart
// Trong app_router.dart, thay thế _buildRoute
case Routes.myNewScreen:
  return _buildSlideRoute(
    const MyNewScreen(),
    settings,
  );
```

## ✅ Danh sách Routes hiện tại

| Route Name | Path | Có tham số |
|-----------|------|----------|
| splash | / | ❌ |
| onboarding | /onboarding | ❌ |
| login | /login | ❌ |
| register | /register | ❌ |
| mainApp | /main | ❌ |
| home | /home | ❌ |
| discovery | /discovery | ❌ |
| library | /library | ❌ |
| documentDetail | /document-detail | ✅ |
| notification | /notification | ❌ |
| profile | /profile | ❌ |
| editProfile | /edit-profile | ✅ |
| settings | /settings | ❌ |
| community | /community | ❌ |
| communityFeed | /community-feed | ✅ |
| messaging | /messaging | ❌ |
| search | /search | ✅ |
| upload | /upload | ❌ |
| fileManager | /file-manager | ❌ |
| bookLending | /book-lending | ✅ |
| review | /review | ✅ |
| map | /map | ❌ |

## 🔄 Refactor Screens (Migration Guide)

### Trước (Old way):
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
);
```

### Sau (New way):
```dart
RouterHelper.goEditProfile(context);
```

### Ưu điểm:
- ✅ Code đơn giản hơn
- ✅ Tập trung management routing
- ✅ Dễ bảo trì
- ✅ Dễ thêm transitions
- ✅ Dễ refactor khi đổi screen
