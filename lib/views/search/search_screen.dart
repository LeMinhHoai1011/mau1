// Search Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm Python, Data Science...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() => _query = value);
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: _query.isEmpty
        ? Center(child: Text('Nhập từ khóa tìm kiếm'))
        : ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
              title: Text('Kết quả $index cho $_query'),
              subtitle: Text('Python Web, Data Science...'),
            ),
          ),
    );
  }
}
