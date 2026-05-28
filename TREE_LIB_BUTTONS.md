# Hướng đi từng button khi nhấn (theo code hiện tại trong repo)

> Ghi chú: Nhiều `onPressed/onTap` đang để rỗng (`() {}`), hoặc UI có hành động nhưng chưa triển khai điều hướng/tác vụ. Với các chỗ đó, tài liệu này ghi rõ “chưa có action/đang TODO”.

## 1) Điều hướng toàn app / Bottom Navigation
### `lib/app.dart`
- **BottomNavigationBar (5 tab)**
  - Nhấn tab 0 “Trang chủ” → đổi `_selectedIndex = 0` → hiển thị `HomeScreen()`.
  - Nhấn tab 1 “Khám phá” → đổi `_selectedIndex = 1` → hiển thị `DiscoveryScreen()`.
  - Nhấn tab 2 “Thư viện” → đổi `_selectedIndex = 2` → hiển thị `LibraryScreen()`.
  - Nhấn tab 3 “Thông báo” → đổi `_selectedIndex = 3` → hiển thị `NotificationScreen()`.
  - Nhấn tab 4 “Cá nhân” → đổi `_selectedIndex = 4` → hiển thị `ProfileScreen()`.

## 2) Màn hình Home
### `lib/views/home/home_screen.dart`
- **Categories - SectionHeader “Xem tất cả”**
  - Nhấn → `Navigator.push` → mở `DiscoveryScreen()`.
- **Category card (4 card ngang)**
  - Tap vào “Lập trình / Toán / Vật lý / Tiếng Anh” → `Navigator.push` → mở `DiscoveryScreen()`.
  - (Hiện tại không dùng tham số category; chỉ mở DiscoveryScreen.)
- **Trending - SectionHeader “Xem tất cả”**
  - Nhấn → `Navigator.push` → mở `DiscoveryScreen()`.
- **New Uploads - SectionHeader “Xem tất cả”**
  - Nhấn → `Navigator.push` → mở `DiscoveryScreen()`.

- **TrendingCard (mỗi card trong Home)**
  - `TrendingCard` nằm ở `lib/views/home/widgets/trending_card.dart`
  - Nhấn vào card → **chưa có action** vì `onTap: () {}`.

## 3) Màn hình Discovery
### `lib/views/discovery/discovery_screen.dart`
- **AppBar icon “filter” (IconButton tune)**
  - Nhấn → `_showFilterModal()` → `showModalBottomSheet(...)` mở bottom sheet filter.

- **Chip Category (Lập trình / Toán héc / Vật lý / Tiếng Anh)**
  - Nhấn → `setState` đổi `selectedCategory` (không điều hướng route).

- **Chip Language (chỉ khi `selectedCategory == 'Lập trình'`)**
  - Nhấn → `setState` đổi `selectedLanguage` (không điều hướng route).

- **Dropdown sort (DropdownButton)**
  - `onChanged: (value) {}` → **chưa có action** (chưa đổi state/sort).

- **Từng item document render bằng `TrendingCard(...)`**
  - Nhấn vào card → **chưa có action** (vẫn `onTap: () {}` trong `TrendingCard`).

- **Checkbox trong filter modal**
  - `onChanged: (value) {}` → **chưa có action**.

## 4) Màn hình Library
### `lib/views/library/library_screen.dart`
- **TabBar (Đã lưu / Đã tải / Danh sách đọc)**
  - Nhấn tab → đổi tab index trên `TabController` → đổi nội dung trong `TabBarView`.
  - Không dùng điều hướng route.

- **List item actions**
  - `IconButton(Icons.delete, onPressed: () {})` → **chưa có action**.
  - `IconButton(Icons.folder_open, onPressed: () {})` → **chưa có action**.

## 5) Màn hình Notification
### `lib/views/notification/notification_screen.dart`
- **AppBar action “done_all”**
  - Nhấn → `onPressed: () {}` → **chưa có action**.

- **Các notification item**
  - Trong file hiện tại không có nút/tương tác trực tiếp cho từng item (chỉ hiển thị UI).

## 6) Màn hình Profile
### `lib/views/profile/profile_screen.dart`
- **Edit Profile button (IconButton edit)**
  - Nhấn → `Navigator.push` → `EditProfileScreen()`.

- **Settings button (IconButton settings)**
  - Nhấn → `Navigator.push` → `SettingsScreen()`.

- **Logout button (OutlinedButton “Đăng xuất”)**
  - Nhấn → `await authProvider.logout()` → `Navigator.pushAndRemoveUntil(... LoginScreen, (route) => false)`
  - Kết quả: quay về Login và xóa toàn bộ stack cũ.

- **Upload button (ElevatedButton “Tải lên tài liệu”)**
  - `onPressed: () {}` → **chưa có action**.

## 7) Màn hình Login
### `lib/views/auth/login_screen.dart`
- **Toggle Login/Register**
  - Nhấn “Đăng ký” (InkWell) → `Navigator.push` → `RegisterScreen()`.
  - (Nhấn “Đăng nhập” không có `onTap`, hiện tại là tĩnh UI.)

- **IconButton toggle show/hide password** (suffix icon của password field)
  - Nhấn → `setState(() => _obscurePassword = !_obscurePassword)` (chỉ đổi hiển thị, không điều hướng).

- **Nút “Đăng nhập”**
  - `onPressed: authProvider.isLoading ? null : _handleLogin`
  - Trong `_handleLogin`:
    - Nếu `success == true` → `Navigator.pushReplacement` → `MainApp()`.
    - Nếu thất bại → `ScaffoldMessenger.showSnackBar(...)` (không điều hướng).

- **Social login buttons** (OutlinedButton Google / Apple)
  - `onPressed: () {}` → **chưa có action**.

## 8) Màn hình Register
### `lib/views/auth/register_screen.dart`
- **Toggle Login/Register**
  - Nhấn “Đăng nhập” → `Navigator.pop(context)` (quay lại màn Login).
  - (Nhấn “Đăng ký” là tĩnh UI.)

- **IconButton toggle show/hide password**
  - Nhấn → đổi `_obscurePassword`.

- **IconButton toggle show/hide confirm password**
  - Nhấn → đổi `_obscureConfirmPassword`.

- **Nút “Đăng ký”**
  - `onPressed: authProvider.isLoading ? null : _handleRegister`
  - Trong `_handleRegister`:
    - Nếu success → `Navigator.pushReplacement` → `LoginScreen()`.
    - Đồng thời hiển thị SnackBar “Đăng ký thành công...”.
    - Nếu thất bại → SnackBar lỗi (không điều hướng).

- **Social login buttons**
  - Không có trong file Register (trong code hiện tại).

## 9) Màn hình Upload
### `lib/views/upload/upload_screen.dart`
- **“Chọn file” (ElevatedButton.icon)**
  - `onPressed: () {}` → **chưa có action**.

- **Dropdown “Chọn chủ đề”**
  - `onChanged` → `setState(() => _selectedCategory = value)` (không điều hướng).

- **Nút “Upload”**
  - `onPressed: _isUploading ? null : () => _uploadDocument()`
  - `_uploadDocument()`:
    - Nếu thiếu title hoặc category → show SnackBar lỗi, không điều hướng.
    - Nếu đủ:
      - set `_isUploading=true`
      - `Future.delayed(2s)` → set `_isUploading=false` → show SnackBar “Tài liệu đã được tải lên thành công!”
      - `Navigator.pop(context)` → quay về màn trước đó.

## 10) Màn hình Book Lending
### `lib/views/book_lending/book_lending_screen.dart`
- **FloatingActionButton “+”**
  - Nhấn → `_showAddBookModal()` → `showModalBottomSheet(...)` mở modal thêm sách.

- **Modal “Thêm sách mượn”**
  - **Nút “Lend” (ElevatedButton)**
    - Nhấn → `_addBook()`:
      - Validate: nếu thiếu title/author/location → SnackBar lỗi.
      - Nếu OK → thêm item vào `_bookListings`, clear controller, `Navigator.pop(context)` để đóng modal,
      - Sau đó show SnackBar “Sách đã được thêm thành công!”.

- **Xóa sách (IconButton delete)**
  - Nhấn → `_deleteBook(book)`:
    - `setState(() => _bookListings.remove(book))`
    - SnackBar “Sách đã được xóa”.

- **Sửa sách (IconButton edit)**
  - `onPressed: () {}` → **chưa có action**.

- **Empty state màn hình**
  - Khi `_bookListings.isEmpty` hiển thị text hướng dẫn; **nút thêm** vẫn là FAB “+”.

## 11) Màn hình khác (hiện chưa được “liệt kê button đầy đủ” vì chưa đọc file tương ứng)
- `lib/views/settings/*`, `lib/views/profile/edit_profile_screen.dart`, `lib/views/*` còn lại...
- Các file đó có thể còn nhiều `onPressed/onTap` khác, nhưng trong bước hiện tại tài liệu mới dựa trên những file đã đọc.

---
## Tổng hợp nhanh các case “chưa có action” (onPressed/onTap rỗng)
- `TrendingCard.onTap` → rỗng.
- Discovery: `DropdownButton.onChanged` → rỗng.
- Discovery filter modal: `CheckboxListTile.onChanged` → rỗng.
- Library: IconButton delete/folder_open → rỗng.
- Notification: AppBar action done_all → rỗng.
- Profile: Upload button → rỗng.
- Login/Register social buttons → rỗng.
- Upload: “Chọn file” → rỗng.
- BookLending: edit IconButton → rỗng.

