// Library Screen - Quản lý tài liệu đã lưu/tải
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LibraryScreen extends StatefulWidget {
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
      padding: EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text('Tài liệu đã lưu $index'),
          subtitle: Text('Python cơ bản'),
          trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {}),
        ),
      ),
    );
  }

  Widget _buildDownloadedTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text('File PDF $index'),
          subtitle: Text('2.5MB • Tải ngày 20/10'),
          trailing: IconButton(icon: Icon(Icons.folder_open), onPressed: () {}),
        ),
      ),
    );
  }

  Widget _buildReadingListTab() {
    return Center(child: Text('Chưa có danh sách đọc'));
  }
}
