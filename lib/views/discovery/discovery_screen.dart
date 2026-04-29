// Discovery Screen (Danh mục môn học)
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../home/widgets/trending_card.dart';

class DiscoveryScreen extends StatefulWidget {
  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  String selectedCategory = 'Lập trình';
  String selectedLanguage = 'Python';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.discovery),
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: AppColors.textMain),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Selection
            Text(
              AppStrings.categories,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('Lập trình'),
                  _buildCategoryChip('Toán học'),
                  _buildCategoryChip('Vật lý'),
                  _buildCategoryChip('Tiếng Anh'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Programming Language Filter (nếu chọn Lập trình)
            if (selectedCategory == 'Lập trình') ...[
              Text(
                'Ngôn ngữ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildLanguageChip('Python'),
                    _buildLanguageChip('Java'),
                    _buildLanguageChip('C++'),
                    _buildLanguageChip('JavaScript'),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],

            // Sort Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.sort}:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                DropdownButton<String>(
                  value: 'newest',
                  items: [
                    DropdownMenuItem(
                      value: 'newest',
                      child: Text('Mới nhất'),
                    ),
                    DropdownMenuItem(
                      value: 'rating',
                      child: Text('Đánh giá cao'),
                    ),
                    DropdownMenuItem(
                      value: 'popular',
                      child: Text('Phổ biến'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 20),

            // Documents List
            Text(
              'Tài liệu (${selectedLanguage})',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...List.generate(
              5,
              (index) => Column(
                children: [
                  TrendingCard(
                    title: 'Hướng dẫn $selectedLanguage - Phần ${index + 1}',
                    author: 'Tác giả ${index + 1}',
                    rating: 4.5 + (index * 0.1),
                    views: 500 + (index * 100),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textMain,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageChip(String label) {
    bool isSelected = selectedLanguage == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = label;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textMain,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.filter,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('Rating cao nhất'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text('Lượt tải xuống cao'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text('Tài liệu mới'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
