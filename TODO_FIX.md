# TODO: Fix Dart Analyzer Issues

## Total Issues: 47
- warning: 2
- info: 45

## Priority Tasks

### 1. UNUSED IMPORTS (2)
- [x] lib/core/widgets/common_card.dart:3 - app_colors.dart
- [x] lib/views/community/community_screen.dart:4 - app_strings.dart

### 2. DEPRECATED (18)
- [x] lib/core/theme/app_theme.dart:29 - background -> surface
- [x] lib/core/widgets/custom_button.dart:70 - withOpacity
- [x] lib/views/auth/login_screen.dart:105 - withOpacity
- [x] lib/views/auth/register_screen.dart:143 - withOpacity
- [x] lib/views/book_lending/book_lending_screen.dart:41,82 - withOpacity
- [x] lib/views/community/community_screen.dart:265 - withOpacity
- [x] lib/views/details/document_detail_screen.dart:34,196 - withOpacity
- [x] lib/views/home/widgets/trending_card.dart:45 - withOpacity
- [x] lib/views/notification/notification_screen.dart:73,76,84 - withOpacity
- [x] lib/views/onboarding/onboarding_screen.dart:42 - withOpacity
- [x] lib/views/upload/upload_screen.dart:38 - withOpacity

### 3. USE SUPER PARAMETERS (9)
- [x] lib/core/widgets/common_card.dart:13
- [x] lib/core/widgets/custom_button.dart:17
- [x] lib/views/auth/auth_wrapper.dart:10
- [x] lib/views/auth/login_screen.dart:9
- [x] lib/views/auth/register_screen.dart:8
- [x] lib/views/details/document_detail_screen.dart:11
- [x] lib/views/home/widgets/trending_card.dart:12
- [x] lib/views/onboarding/onboarding_screen.dart:8

### 4. USE KEY IN WIDGET CONSTRUCTORS (14)
- [x] lib/views/book_lending/book_lending_screen.dart:6
- [x] lib/views/community/community_feed.dart:5
- [x] lib/views/community/community_screen.dart:6
- [x] lib/views/discovery/discovery_screen.dart:7
- [x] lib/views/file_manager/file_manager_screen.dart:5
- [x] lib/views/home/home_screen.dart:7
- [x] lib/views/library/library_screen.dart:5
- [x] lib/views/map/map_screen.dart:5
- [x] lib/views/messaging/messaging_screen.dart:5
- [x] lib/views/notification/notification_screen.dart:6
- [x] lib/views/review/review_screen.dart:5
- [x] lib/views/search/search_screen.dart:5
- [x] lib/views/settings/settings_screen.dart:5
- [x] lib/views/upload/upload_screen.dart:6

### 5. PREFER FINAL FIELDS (4)
- [x] lib/providers/library_provider.dart:5 - _savedDocuments
- [x] lib/providers/library_provider.dart:6 - _downloadedDocuments
- [x] lib/views/book_lending/book_lending_screen.dart:17 - _bookListings
- [x] lib/views/settings/settings_screen.dart:13 - _language

### 6. UNNECESSARY BRACE IN STRING INTERPOLATION (1)
- [x] lib/views/discovery/discovery_screen.dart:106

### 7. USE BUILD CONTEXT SYNCHRONOUSLY (2)
- [x] lib/views/upload/upload_screen.dart:180,183

### 8. DEAD CODE (1)
- [x] lib/core/widgets/custom_button.dart:38
