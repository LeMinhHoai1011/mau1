// Messaging Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Tin nhắn')),
      body: Column(
        children: [
          // Danh sách chat
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(child: Text('U${index + 1}')),
                title: Text('User ${index + 1}'),
                subtitle: Text('Muốn mượn sách Python...'),
                trailing: Text('14:30'),
              ),
            ),
          ),
          // Input chat
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(decoration: InputDecoration(hintText: 'Nhập tin nhắn...'))),
                IconButton(icon: Icon(Icons.send), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
