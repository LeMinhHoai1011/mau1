// Library Screen - Quản lý tài liệu đã lưu/tải
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/router_helper.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Tab> tabs = [
    Tab(text: 'Đã lưu'),
    Tab(text: 'Đã tải'),
    Tab(text: 'Danh sách đọc'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Thư viện của tôi'),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSavedTab(),
          _buildDownloadedTab(),
          _buildReadingListTab(),
        ],
      ),
    );
  }

  Widget _buildSavedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.bookmark, color: AppColors.primary),
          title: Text('Tài liệu đã lưu $index'),
          subtitle: const Text('Python cơ bản'),
          trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
          onTap: () {
            RouterHelper.goDocumentDetail(
              context,
              documentId: 'saved_$index',
              title: 'Tài liệu đã lưu $index',
            );
          },
        ),
      ),
    );
  }

  Widget _buildDownloadedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
          title: Text('File PDF $index'),
          subtitle: const Text('2.5MB • Tải ngày 20/10'),
          trailing: IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () {
              RouterHelper.goFileManager(context);
            },
          ),
          onTap: () {
            RouterHelper.goDocumentDetail(
              context,
              documentId: 'downloaded_$index',
              title: 'File PDF $index',
            );
          },
        ),
      ),
    );
  }

  Widget _buildReadingListTab() {
    final lists = ['Tài liệu ôn thi cuối kỳ', 'Giáo trình tham khảo AI'];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lists.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.playlist_play, color: AppColors.primary),
          title: Text(lists[index]),
          subtitle: const Text('3 tài liệu • Tạo ngày 25/05'),
          onTap: () {
            RouterHelper.goDocumentDetail(
              context,
              documentId: 'reading_list_$index',
              title: lists[index],
            );
          },
        ),
      ),
    );
  }
}
