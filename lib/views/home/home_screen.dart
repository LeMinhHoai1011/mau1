// Home Screen
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import 'widgets/trending_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                  )
                ],
              ),
              SizedBox(height: 20),

              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                  suffixIcon: Icon(Icons.mic, color: AppColors.textSecondary),
                ),
              ),
              SizedBox(height: 24),

              // Categories
              Text(
                AppStrings.categories,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryCard('Lập trình', Icons.code),
                    _buildCategoryCard('Toán', Icons.calculate),
                    _buildCategoryCard('Vật lý', Icons.atm),
                    _buildCategoryCard('Tiếng Anh', Icons.language),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Trending
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.trending,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Xem tất cả',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),
              TrendingCard(
                title: 'Python từ cơ bản đến nâng cao',
                author: 'Nguyễn Văn A',
                rating: 4.8,
                views: 1250,
              ),
              SizedBox(height: 12),
              TrendingCard(
                title: 'Giải tích 1: Bài tập và lời giải',
                author: 'Trần Thị B',
                rating: 4.6,
                views: 980,
              ),
              SizedBox(height: 24),

              // New Uploads
              Text(
                AppStrings.newUploads,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TrendingCard(
                title: 'Java Design Patterns',
                author: 'Lê Quang C',
                rating: 4.7,
                views: 450,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 80,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
