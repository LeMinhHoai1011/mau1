// Map Screen - Tài liệu gần bạn
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Tài liệu gần bạn')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 80, color: AppColors.primary),
            SizedBox(height: 16),
            Text('Tài liệu cách bạn 2.5km', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Sử dụng vị trí hiện tại'),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.my_location),
              label: Text('Cập nhật vị trí'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
