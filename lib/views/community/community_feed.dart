// Community Feed Screen
// 👥 Màn hình feed cộng đồng - Parameter: communityId để load feed của community cụ thể
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// 👥 Community feed widget
/// Parameter: communityId - Community ID để load feed
class CommunityFeed extends StatelessWidget {
  final String communityId;

  const CommunityFeed({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Cộng đồng #$communityId')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text('Bài viết $index'),
            subtitle: Text('Thảo luận về Python AI'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.comment, size: 20),
                SizedBox(width: 4),
                Text('$index'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
