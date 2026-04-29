// Community Feed Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CommunityFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Cộng đồng')),
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
