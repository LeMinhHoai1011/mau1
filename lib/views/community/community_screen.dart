// Community Screen - Discussion & Posts
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class CommunityScreen extends StatefulWidget {
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedTab = 0; // 0: Discussion, 1: Top Contributors

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Cộng đồng'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
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
                      padding: EdgeInsets.symmetric(vertical: 12),
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
                      padding: EdgeInsets.symmetric(vertical: 12),
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
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildDiscussionList() {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        _buildPostCard(
          'Python: Cách tối ưu hóa code?',
          'Nguyễn Văn A',
          'Giúp mình cách viết code Python sao cho hiệu suất cao nhất?',
          '2 giờ trước',
          replies: 12,
          views: 324,
        ),
        SizedBox(height: 12),
        _buildPostCard(
          'Mẹo học Java nhanh chóng',
          'Trần Thị B',
          'Chia sẻ kinh nghiệm học Java trong 3 tháng...',
          '5 giờ trước',
          replies: 8,
          views: 210,
        ),
        SizedBox(height: 12),
        _buildPostCard(
          'Ứng dụng web hay nhất năm 2024?',
          'Lê Quang C',
          'Bạn nào có recommend ứng dụng web hay không?',
          '1 ngày trước',
          replies: 15,
          views: 456,
        ),
      ],
    );
  }

  Widget _buildTopContributorsList() {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        _buildContributorCard(1, 'Nguyễn Văn A', '45 tài liệu', 'Python'),
        SizedBox(height: 12),
        _buildContributorCard(2, 'Trần Thị B', '38 tài liệu', 'Java'),
        SizedBox(height: 12),
        _buildContributorCard(3, 'Lê Quang C', '32 tài liệu', 'Web Dev'),
        SizedBox(height: 12),
        _buildContributorCard(4, 'Phạm Thị D', '28 tài liệu', 'Data Science'),
        SizedBox(height: 12),
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
    return Container(
      padding: EdgeInsets.all(12),
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.message_outlined, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('$replies trả lời', style: TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.visibility, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('$views lượt xem', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContributorCard(int rank, String name, String docs, String specialty) {
    return Container(
      padding: EdgeInsets.all(12),
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
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$docs • $specialty',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              textStyle: TextStyle(fontSize: 12),
            ),
            child: Text('Follow'),
          ),
        ],
      ),
    );
  }
}
