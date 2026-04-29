// Settings Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  String _language = 'Tiếng Việt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Cài đặt')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text('Chế độ tối'),
            trailing: Switch(value: _darkMode, onChanged: (value) => setState(() => _darkMode = value)),
          ),
          ListTile(
            title: Text('Thông báo'),
            trailing: Switch(value: _notifications, onChanged: (value) => setState(() => _notifications = value)),
          ),
          ListTile(
            title: Text('Ngôn ngữ'),
            trailing: DropdownButton<String>(
              value: _language,
              items: ['Tiếng Việt', 'English'].map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text('Đổi mật khẩu'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Đăng xuất'),
            trailing: Icon(Icons.logout),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
