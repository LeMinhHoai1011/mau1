import 'package:flutter/material.dart';
import 'routes.dart';
import 'route_arguments.dart';

// Import all screens
import '../../views/auth/auth_wrapper.dart';
import '../../views/auth/login_screen.dart';
import '../../views/auth/register_screen.dart';
import '../../views/onboarding/onboarding_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/discovery/discovery_screen.dart';
import '../../views/library/library_screen.dart';
import '../../views/details/document_detail_screen.dart';
import '../../views/notification/notification_screen.dart';
import '../../views/profile/profile_screen.dart';
import '../../views/profile/edit_profile_screen.dart';
import '../../views/community/community_screen.dart';
import '../../views/community/community_feed.dart';
import '../../views/messaging/messaging_screen.dart';
import '../../views/search/search_screen.dart';
import '../../views/upload/upload_screen.dart';
import '../../views/file_manager/file_manager_screen.dart';
import '../../views/book_lending/book_lending_screen.dart';
import '../../views/review/review_screen.dart';
import '../../views/settings/settings_screen.dart';
import '../../views/map/map_screen.dart';
import '../../app.dart';

/// AppRouter - Quản lý tất cả routes và transitions
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case Routes.splash:
        return _buildRoute(const AuthWrapper(), settings);

      case Routes.onboarding:
        return _buildRoute(const OnboardingScreen(), settings);

      case Routes.login:
        return _buildRoute(const LoginScreen(), settings);

      case Routes.register:
        return _buildRoute(const RegisterScreen(), settings);

      // Main Routes
      case Routes.mainApp:
        return _buildRoute(const MainApp(), settings);

      case Routes.home:
        return _buildRoute(const HomeScreen(), settings);

      // Discovery Routes
      case Routes.discovery:
        return _buildRoute(const DiscoveryScreen(), settings);

      // Library Routes
      case Routes.library:
        return _buildRoute(const LibraryScreen(), settings);

      case Routes.documentDetail:
        final args = settings.arguments as DocumentDetailArguments?;
        return _buildRoute(
          DocumentDetailScreen(
            documentId: args?.documentId ?? '',
            title: args?.title,
            imagePath: args?.imagePath,
          ),
          settings,
        );

      // Notification Routes
      case Routes.notification:
        return _buildRoute(const NotificationScreen(), settings);

      // Profile Routes
      case Routes.profile:
        return _buildRoute(const ProfileScreen(), settings);

      case Routes.editProfile:
        final args = settings.arguments as EditProfileArguments?;
        return _buildRoute(
          EditProfileScreen(userId: args?.userId),
          settings,
        );

      case Routes.settings:
        return _buildRoute(const SettingsScreen(), settings);

      // Community Routes
      case Routes.community:
        return _buildRoute(const CommunityScreen(), settings);

      case Routes.communityFeed:
        final args = settings.arguments as CommunityFeedArguments?;
        return _buildRoute(
          CommunityFeed(communityId: args?.communityId ?? ''),
          settings,
        );

      // Messaging Routes
      case Routes.messaging:
        return _buildRoute(const MessagingScreen(), settings);

      // Search Routes
      case Routes.search:
        final args = settings.arguments as SearchArguments?;
        return _buildRoute(
          SearchScreen(initialQuery: args?.initialQuery),
          settings,
        );

      // Upload Routes
      case Routes.upload:
        return _buildRoute(const UploadScreen(), settings);

      // File Manager Routes
      case Routes.fileManager:
        return _buildRoute(const FileManagerScreen(), settings);

      // Book Lending Routes
      case Routes.bookLending:
        final args = settings.arguments as BookLendingArguments?;
        return _buildRoute(
          BookLendingScreen(documentId: args?.documentId ?? ''),
          settings,
        );

      // Review Routes
      case Routes.review:
        final args = settings.arguments as ReviewArguments?;
        return _buildRoute(
          ReviewScreen(
            documentId: args?.documentId ?? '',
            documentTitle: args?.documentTitle ?? '',
          ),
          settings,
        );

      // Map Routes
      case Routes.map:
        return _buildRoute(const MapScreen(), settings);

      default:
        return _buildRoute(const AuthWrapper(), settings);
    }
  }

  /// Tạo route với animation
  static Route<dynamic> _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => widget,
      settings: settings,
    );
  }

  /// Tạo route với fade animation
  static Route<dynamic> _buildFadeRoute(Widget widget, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Tạo route với slide animation từ phải sang trái
  static Route<dynamic> _buildSlideRoute(Widget widget, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
