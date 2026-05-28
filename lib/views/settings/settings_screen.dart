// Settings Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/router_helper.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  final String _language = 'Tiếng Việt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Chế độ tối'),
            trailing: Switch(value: _darkMode, onChanged: (value) => setState(() => _darkMode = value)),
          ),
          ListTile(
            title: const Text('Thông báo'),
            trailing: Switch(value: _notifications, onChanged: (value) => setState(() => _notifications = value)),
          ),
          ListTile(
            title: const Text('Ngôn ngữ'),
            trailing: DropdownButton<String>(
              value: _language,
              items: const ['Tiếng Việt', 'English'].map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: const Text('Đổi mật khẩu'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Đăng xuất'),
            trailing: const Icon(Icons.logout, color: Colors.red),
            textColor: Colors.red,
            onTap: () async {
              final authProvider = context.read<AuthProvider>();
              await authProvider.logout();
              if (mounted) {
                RouterHelper.goLogin(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
