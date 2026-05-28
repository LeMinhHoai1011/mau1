// Notification Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/router/router_helper.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.notification),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã đánh dấu tất cả là đã đọc')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            context,
            'Bình luận mới',
            'Nguyễn Văn B vừa bình luận về tài liệu của bạn',
            '2 giờ trước',
            Icons.comment,
            isRead: false,
            onTap: () {
              RouterHelper.goCommunityFeed(
                context,
                communityId: 'Python: Cách tối ưu hóa code?',
              );
            },
          ),
          _buildNotificationItem(
            context,
            'Lượt tải cao',
            'Tài liệu "Python từ cơ bản" của bạn đạt 1K lượt tải',
            '5 giờ trước',
            Icons.trending_up,
            isRead: false,
            onTap: () {
              RouterHelper.goDocumentDetail(
                context,
                documentId: 'python_basic',
                title: 'Python từ cơ bản đến nâng cao',
              );
            },
          ),
          _buildNotificationItem(
            context,
            'Phê duyệt tài liệu',
            'Tài liệu mới của bạn đã được phê duyệt',
            '1 ngày trước',
            Icons.check_circle,
            isRead: true,
            onTap: () {
              RouterHelper.goDocumentDetail(
                context,
                documentId: 'java_patterns',
                title: 'Java Design Patterns',
              );
            },
          ),
          _buildNotificationItem(
            context,
            'Người mới theo dõi',
            'Trần Thị C vừa theo dõi bạn',
            '2 ngày trước',
            Icons.person_add,
            isRead: true,
            onTap: () {
              RouterHelper.goProfile(context);
            },
          ),
          _buildNotificationItem(
            context,
            'Bài viết mới',
            'Nguyễn Văn A vừa đăng bài viết mới',
            '3 ngày trước',
            Icons.article,
            isRead: true,
            onTap: () {
              RouterHelper.goCommunity(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    String title,
    String description,
    String time,
    IconData icon, {
    bool isRead = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isRead ? Colors.grey.shade200 : AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
