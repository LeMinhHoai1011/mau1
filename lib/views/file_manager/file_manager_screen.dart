// File Manager Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FileManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Quản lý file')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.download_done),
              title: Text('Tài liệu Python.pdf'),
              subtitle: Text('Hoàn tất • 2.5MB'),
              trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.downloading),
              title: Text('AI Guide.doc'),
              subtitle: Text('Đang tải 75% • 3.2MB'),
            ),
          ),
        ],
      ),
    );
  }
}
