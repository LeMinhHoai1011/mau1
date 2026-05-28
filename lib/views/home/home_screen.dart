/// Home Screen - Enhanced with Material 3 and Design Tokens
/// 📱 Màn hình trang chủ hiển thị các danh mục, tài liệu trending và các upload mới
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/router_helper.dart';
import '../../core/widgets/section_header.dart';
import 'widgets/trending_card.dart';
import '../discovery/discovery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with greeting
              _buildHeader(),
              const SizedBox(height: AppSpacing.xl),

              // Search Bar - 🔍 Điều hướng đến trang tìm kiếm
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  suffixIcon: const Icon(Icons.mic, color: AppColors.textSecondary),
                ),
                onSubmitted: (query) {
                  // 🔀 Dùng RouterHelper để navigate đến search screen
                  RouterHelper.goSearch(context, initialQuery: query);
                },
              ),
              const SizedBox(height: AppSpacing.xl),

              // Categories Section - 📂 Xem tất cả danh mục
              SectionHeader(
                title: AppStrings.categories,
                onViewAll: () {
                  // 🔀 Dùng RouterHelper để navigate đến discovery
                  RouterHelper.goDiscovery(context);
                },
              ),
              const SizedBox(height: AppSpacing.md),
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
              const SizedBox(height: AppSpacing.xl),

              // Community Utilities Section - 🤝 Tiện ích Cộng đồng
              const SectionHeader(
                title: 'Tiện ích Cộng đồng',
                onViewAll: null,
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildUtilityCard(
                      context,
                      'Mượn sách',
                      Icons.book_online_outlined,
                      AppColors.primary,
                      () => RouterHelper.goBookLending(context, documentId: ''),
                    ),
                    _buildUtilityCard(
                      context,
                      'Cộng đồng',
                      Icons.groups_outlined,
                      Colors.orange,
                      () => RouterHelper.goCommunity(context),
                    ),
                    _buildUtilityCard(
                      context,
                      'Tải tài liệu',
                      Icons.upload_file_outlined,
                      Colors.green,
                      () => RouterHelper.goUpload(context),
                    ),
                    _buildUtilityCard(
                      context,
                      'Bản đồ sách',
                      Icons.map_outlined,
                      Colors.teal,
                      () => RouterHelper.goMap(context),
                    ),
                    _buildUtilityCard(
                      context,
                      'Tệp của tôi',
                      Icons.folder_open_outlined,
                      Colors.purple,
                      () => RouterHelper.goFileManager(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Trending Section - 🔥 Tài liệu nổi bật
              SectionHeader(
                title: AppStrings.trending,
                onViewAll: () {
                  // 🔀 Dùng RouterHelper để navigate đến discovery
                  RouterHelper.goDiscovery(context);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              const TrendingCard(
                documentId: 'python_basic',
                title: 'Python từ cơ bản đến nâng cao',
                author: 'Nguyễn Văn A',
                rating: 4.8,
                views: 1250,
              ),
              const SizedBox(height: AppSpacing.lg),
              const TrendingCard(
                documentId: 'calculus_1',
                title: 'Giải tích 1: Bài tập và lời giải',
                author: 'Trần Thị B',
                rating: 4.6,
                views: 980,
              ),
              const SizedBox(height: AppSpacing.xl),

              // New Uploads Section - ✨ Các upload mới nhất
              SectionHeader(
                title: AppStrings.newUploads,
                onViewAll: () {
                  // 🔀 Dùng RouterHelper để navigate đến discovery
                  RouterHelper.goDiscovery(context);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              const TrendingCard(
                documentId: 'java_patterns',
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

  /// 👤 Widget hiển thị phần header
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào! 👋',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            RouterHelper.goProfile(context);
          },
          child: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
            radius: 24,
          ),
        ),
      ],
    );
  }

  /// 📚 Widget hiển thị thẻ danh mục
  Widget _buildCategoryCard(String title, IconData icon) {
    return GestureDetector(
      // 🔀 Tap để xem tất cả tài liệu trong danh mục
      onTap: () {
        RouterHelper.goDiscovery(context);
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: AppSpacing.iconLarge),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  /// 🤝 Widget hiển thị tiện ích cộng đồng
  Widget _buildUtilityCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        margin: const EdgeInsets.only(right: AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: AppSpacing.iconLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
