/// Route names - Tập trung quản lý tất cả route names
/// Sử dụng: Navigator.pushNamed(context, Routes.home)
class Routes {
  // Auth Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main Routes
  static const String mainApp = '/main';
  static const String home = '/home';

  // Discovery Routes
  static const String discovery = '/discovery';

  // Library Routes
  static const String library = '/library';
  static const String documentDetail = '/document-detail';

  // Notification Routes
  static const String notification = '/notification';

  // Profile Routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';

  // Community Routes
  static const String community = '/community';
  static const String communityFeed = '/community-feed';

  // Messaging Routes
  static const String messaging = '/messaging';

  // Search Routes
  static const String search = '/search';

  // Upload Routes
  static const String upload = '/upload';

  // File Manager Routes
  static const String fileManager = '/file-manager';

  // Book Lending Routes
  static const String bookLending = '/book-lending';

  // Review Routes
  static const String review = '/review';

  // Map Routes
  static const String map = '/map';
}
