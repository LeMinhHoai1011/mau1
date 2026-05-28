// Review Screen
// ⭐ Màn hình đánh giá tài liệu
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// ⭐ Màn hình đánh giá tài liệu
/// Parameters:
/// - documentId: ID của tài liệu cần đánh giá
/// - documentTitle: Tên tài liệu (hiển thị trong header)
class ReviewScreen extends StatelessWidget {
  final String documentId;
  final String documentTitle;

  const ReviewScreen({
    super.key,
    required this.documentId,
    required this.documentTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        // 📚 Hiển thị tên tài liệu trong header
        title: Text('Đánh giá: $documentTitle'),
      ),
      body: Column(
        children: [
          // Form đánh giá
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Viết nhận xét của bạn...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text('Đánh giá: '),
                    ...List.generate(5, (i) => IconButton(
                      icon: Icon(Icons.star, color: Colors.amber),
                      onPressed: () {},
                    )),
                  ],
                ),
                ElevatedButton(onPressed: () {}, child: Text('Gửi đánh giá')),
              ],
            ),
          ),
          // Danh sách nhận xét
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(child: Text('U${index + 1}')),
                title: Text('User ${index + 1}'),
                subtitle: Text('Nhận xét rất hay!'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
