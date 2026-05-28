import 'package:flutter/material.dart';
import 'routes.dart';
import 'route_arguments.dart';

/// RouterHelper - Hàm tiện ích để điều hướng từ bất kỳ screen nào
class RouterHelper {
  // ==================== Auth Routes ====================
  
  /// Điều hướng đến Onboarding (lần đầu tiên)
  static Future<dynamic> goOnboarding(BuildContext context) {
    return Navigator.pushNamed(context, Routes.onboarding);
  }

  /// Điều hướng đến Login (xóa stack)
  static Future<dynamic> goLogin(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (route) => false,
    );
  }

  /// Điều hướng đến Register (normal push)
  static Future<dynamic> goRegister(BuildContext context) {
    return Navigator.pushNamed(context, Routes.register);
  }

  /// Điều hướng đến MainApp (xóa stack)
  static Future<dynamic> goMainApp(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainApp,
      (route) => false,
    );
  }

  // ==================== Home Routes ====================
  
  /// Điều hướng đến trang chủ (xóa stack)
  static Future<dynamic> goHome(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.home,
      (route) => false,
    );
  }

  /// Điều hướng đến Discovery
  static Future<dynamic> goDiscovery(BuildContext context) {
    return Navigator.pushNamed(context, Routes.discovery);
  }

  // ==================== Search & Detail Routes ====================

  /// Điều hướng đến Search với optional initial query
  static Future<dynamic> goSearch(
    BuildContext context, {
    String? initialQuery,
  }) {
    return Navigator.pushNamed(
      context,
      Routes.search,
      arguments: SearchArguments(initialQuery: initialQuery),
    );
  }

  /// Điều hướng đến Document Detail
  static Future<dynamic> goDocumentDetail(
    BuildContext context, {
    required String documentId,
    String? title,
    String? imagePath,
  }) {
    return Navigator.pushNamed(
      context,
      Routes.documentDetail,
      arguments: DocumentDetailArguments(
        documentId: documentId,
        title: title,
        imagePath: imagePath,
      ),
    );
  }

  // ==================== Library Routes ====================

  /// Điều hướng đến Library
  static Future<dynamic> goLibrary(BuildContext context) {
    return Navigator.pushNamed(context, Routes.library);
  }

  /// Điều hướng đến Book Lending
  static Future<dynamic> goBookLending(
    BuildContext context, {
    required String documentId,
  }) {
    return Navigator.pushNamed(
      context,
      Routes.bookLending,
      arguments: BookLendingArguments(documentId: documentId),
    );
  }

  // ==================== Profile Routes ====================

  /// Điều hướng đến Profile
  static Future<dynamic> goProfile(BuildContext context) {
    return Navigator.pushNamed(context, Routes.profile);
  }

  /// Điều hướng đến Edit Profile
  static Future<dynamic> goEditProfile(BuildContext context, {String? userId}) {
    return Navigator.pushNamed(
      context,
      Routes.editProfile,
      arguments: EditProfileArguments(userId: userId),
    );
  }

  /// Điều hướng đến Settings
  static Future<dynamic> goSettings(BuildContext context) {
    return Navigator.pushNamed(context, Routes.settings);
  }

  // ==================== Content Routes ====================

  /// Điều hướng đến Upload
  static Future<dynamic> goUpload(BuildContext context) {
    return Navigator.pushNamed(context, Routes.upload);
  }

  /// Điều hướng đến Review
  static Future<dynamic> goReview(
    BuildContext context, {
    required String documentId,
    required String documentTitle,
  }) {
    return Navigator.pushNamed(
      context,
      Routes.review,
      arguments: ReviewArguments(
        documentId: documentId,
        documentTitle: documentTitle,
      ),
    );
  }

  // ==================== Community Routes ====================

  /// Điều hướng đến Community
  static Future<dynamic> goCommunity(BuildContext context) {
    return Navigator.pushNamed(context, Routes.community);
  }

  /// Điều hướng đến Community Feed
  static Future<dynamic> goCommunityFeed(
    BuildContext context, {
    required String communityId,
  }) {
    return Navigator.pushNamed(
      context,
      Routes.communityFeed,
      arguments: CommunityFeedArguments(communityId: communityId),
    );
  }

  // ==================== Other Routes ====================

  /// Điều hướng đến Notification
  static Future<dynamic> goNotification(BuildContext context) {
    return Navigator.pushNamed(context, Routes.notification);
  }

  /// Điều hướng đến Messaging
  static Future<dynamic> goMessaging(BuildContext context) {
    return Navigator.pushNamed(context, Routes.messaging);
  }

  /// Điều hướng đến File Manager
  static Future<dynamic> goFileManager(BuildContext context) {
    return Navigator.pushNamed(context, Routes.fileManager);
  }

  /// Điều hướng đến Map
  static Future<dynamic> goMap(BuildContext context) {
    return Navigator.pushNamed(context, Routes.map);
  }

  // ==================== Navigation Control ====================

  /// Quay lại trang trước
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  /// Pop nhiều lần cho đến khi tìm được route thỏa điều kiện
  static void goBackUntil(BuildContext context, String routeName) {
    Navigator.popUntil(
      context,
      ModalRoute.withName(routeName),
    );
  }
}
