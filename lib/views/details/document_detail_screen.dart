/// Document Detail Screen - Enhanced with Material 3
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/router_helper.dart';

class DocumentDetailScreen extends StatelessWidget {
  final String documentId;
  final String? title;
  final String? imagePath;
  final String author;
  final double rating;

  const DocumentDetailScreen({
    super.key,
    required this.documentId, 
    this.title,               
    this.imagePath,           
    this.author = 'Nguyễn Văn A', 
    this.rating = 4.8,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primary.withValues(alpha: 0.1),
                child: const Center(
                  child: Icon(
                    Icons.description,
                    color: AppColors.primary,
                    size: 80,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_outline),
                onPressed: () {},
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title ?? documentId,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Author and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.author,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            author,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < rating.toInt()
                                    ? Icons.star
                                    : Icons.star_outline,
                                color: Colors.amber,
                                size: AppSpacing.iconSmall,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '$rating (245 votes)',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat(context, '1.2K', 'Lượt tải'),
                      _buildStat(context, '5.3K', 'Lượt xem'),
                      _buildStat(context, 'PDF', 'Loại file'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Summary
                  Text(
                    AppStrings.summary,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Tài liệu này cung cấp hướng dẫn toàn diện về lập trình Python, bắt đầu từ những khái niệm cơ bản cho đến các kỹ thuật lập trình nâng cao. Phù hợp cho sinh viên bắt đầu học lập trình.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Download Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text(AppStrings.download),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Community Actions Row - 🤝 Hoạt động cộng đồng liên quan sách/tài liệu
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            RouterHelper.goBookLending(context, documentId: documentId);
                          },
                          icon: const Icon(Icons.menu_book, size: 16),
                          label: const Text('Mượn sách', style: TextStyle(fontSize: 11)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            RouterHelper.goReview(
                              context,
                              documentId: documentId,
                              documentTitle: title ?? documentId,
                            );
                          },
                          icon: const Icon(Icons.star_outline, size: 16),
                          label: const Text('Đánh giá', style: TextStyle(fontSize: 11)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Colors.amber),
                            foregroundColor: Colors.amber.shade850,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            RouterHelper.goCommunityFeed(
                              context,
                              communityId: title ?? documentId,
                            );
                          },
                          icon: const Icon(Icons.forum_outlined, size: 16),
                          label: const Text('Thảo luận', style: TextStyle(fontSize: 11)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Colors.green),
                            foregroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Related Documents
                  Text(
                    'Tài liệu liên quan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildRelatedItem(context, 'cpp_advanced', 'C++ Advanced Concepts', 'Lê Quang C'),
                  const SizedBox(height: AppSpacing.md),
                  _buildRelatedItem(context, 'web_dev_guide', 'Web Development Guide', 'Nguyễn Văn A'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildRelatedItem(BuildContext context, String relDocId, String relTitle, String relAuthor) {
    return GestureDetector(
      onTap: () {
        RouterHelper.goDocumentDetail(
          context,
          documentId: relDocId,
          title: relTitle,
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.borderLight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(Icons.description, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      relAuthor,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
