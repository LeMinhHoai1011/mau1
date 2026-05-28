// Community Screen - Discussion & Posts
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/router_helper.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedTab = 0; // 0: Discussion, 1: Top Contributors

  final List<Map<String, dynamic>> _posts = [
    {
      'title': 'Python: Cách tối ưu hóa code?',
      'author': 'Nguyễn Văn A',
      'content': 'Giúp mình cách viết code Python sao cho hiệu suất cao nhất?',
      'time': '2 giờ trước',
      'replies': 12,
      'views': 324,
    },
    {
      'title': 'Mẹo học Java nhanh chóng',
      'author': 'Trần Thị B',
      'content': 'Chia sẻ kinh nghiệm học Java trong 3 tháng...',
      'time': '5 giờ trước',
      'replies': 8,
      'views': 210,
    },
    {
      'title': 'Ứng dụng web hay nhất năm 2024?',
      'author': 'Lê Quang C',
      'content': 'Bạn nào có recommend ứng dụng web hay không?',
      'time': '1 ngày trước',
      'replies': 15,
      'views': 456,
    },
  ];

  void _showAddPostDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tạo thảo luận mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Tiêu đề bài thảo luận'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Nội dung thảo luận...'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                setState(() {
                  _posts.insert(0, {
                    'title': titleController.text,
                    'author': 'Tôi (Cá nhân)',
                    'content': contentController.text,
                    'time': 'Vừa xong',
                    'replies': 0,
                    'views': 1,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã đăng thảo luận thành công!')),
                );
              }
            },
            child: const Text('Đăng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cộng đồng'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              RouterHelper.goSearch(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 0
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Thảo luận',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedTab == 0
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 1
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Top Contributors',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedTab == 1
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildDiscussionList()
                : _buildTopContributorsList(),
          ),
        ],
      ),
      floatingActionButton: _selectedTab == 0
          ? FloatingActionButton(
              onPressed: _showAddPostDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildDiscussionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Column(
          children: [
            _buildPostCard(
              post['title'] ?? '',
              post['author'] ?? '',
              post['content'] ?? '',
              post['time'] ?? '',
              replies: post['replies'] ?? 0,
              views: post['views'] ?? 0,
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget _buildTopContributorsList() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildContributorCard(1, 'Nguyễn Văn A', '45 tài liệu', 'Python'),
        const SizedBox(height: 12),
        _buildContributorCard(2, 'Trần Thị B', '38 tài liệu', 'Java'),
        const SizedBox(height: 12),
        _buildContributorCard(3, 'Lê Quang C', '32 tài liệu', 'Web Dev'),
        const SizedBox(height: 12),
        _buildContributorCard(4, 'Phạm Thị D', '28 tài liệu', 'Data Science'),
        const SizedBox(height: 12),
        _buildContributorCard(5, 'Đỗ Văn E', '25 tài liệu', 'Mobile Dev'),
      ],
    );
  }

  Widget _buildPostCard(
    String title,
    String author,
    String content,
    String time, {
    required int replies,
    required int views,
  }) {
    return GestureDetector(
      onTap: () {
        RouterHelper.goCommunityFeed(context, communityId: title);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.message_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('$replies trả lời', style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.visibility, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('$views lượt xem', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContributorCard(int rank, String name, String docs, String specialty) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$docs • $specialty',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              textStyle: const TextStyle(fontSize: 12),
            ),
            child: const Text('Follow'),
          ),
        ],
      ),
    );
  }
}
