// Review Screen
// ⭐ Màn hình đánh giá tài liệu
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// ⭐ Màn hình đánh giá tài liệu
/// Parameters:
/// - documentId: ID của tài liệu cần đánh giá
/// - documentTitle: Tên tài liệu (hiển thị trong header)
class ReviewScreen extends StatefulWidget {
  final String documentId;
  final String documentTitle;

  const ReviewScreen({
    super.key,
    required this.documentId,
    required this.documentTitle,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 4;
  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Nguyễn Văn Quang',
      'comment': 'Tài liệu cực kỳ chi tiết, rất hữu ích cho kỳ thi.',
      'rating': 5,
    },
    {
      'name': 'Trần Thị Linh',
      'comment': 'Nội dung tốt, ví dụ minh họa dễ hiểu.',
      'rating': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Đánh giá: ${widget.documentTitle}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _commentController,
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
                    ...List.generate(
                      5,
                      (i) => IconButton(
                        icon: Icon(
                          i < _selectedRating ? Icons.star : Icons.star_outline,
                          color: Colors.amber,
                        ),
                        onPressed: () => setState(() => _selectedRating = i + 1),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: Text('Gửi đánh giá'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(review['name'][0])),
                  title: Text(review['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < review['rating'] ? Icons.star : Icons.star_outline,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ),
                      ),
                      Text(review['comment']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _submitReview() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập nhận xét')),
      );
      return;
    }
    setState(() {
      _reviews.insert(0, {
        'name': 'Bạn',
        'comment': comment,
        'rating': _selectedRating,
      });
      _commentController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã gửi đánh giá')),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
