// Notification Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.notification),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            'Bình luận mới',
            'Nguyễn Văn B vừa bình luận về tài liệu của bạn',
            '2 giờ trước',
            Icons.comment,
            isRead: false,
          ),
          _buildNotificationItem(
            'Lượt tải cao',
            'Tài liệu "Python từ cơ bản" của bạn đạt 1K lượt tải',
            '5 giờ trước',
            Icons.trending_up,
            isRead: false,
          ),
          _buildNotificationItem(
            'Phê duyệt tài liệu',
            'Tài liệu mới của bạn đã được phê duyệt',
            '1 ngày trước',
            Icons.check_circle,
            isRead: true,
          ),
          _buildNotificationItem(
            'Người mới theo dõi',
            'Trần Thị C vừa theo dõi bạn',
            '2 ngày trước',
            Icons.person_add,
            isRead: true,
          ),
          _buildNotificationItem(
            'Bài viết mới',
            'Nguyễn Văn A vừa đăng bài viết mới',
            '3 ngày trước',
            Icons.article,
            isRead: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String description,
    String time,
    IconData icon, {
    bool isRead = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isRead ? Colors.grey.shade200 : AppColors.primary.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
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
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
