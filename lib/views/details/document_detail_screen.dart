/// Document Detail Screen - Enhanced with Material 3
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/router_helper.dart';
import '../../data/models/document_model.dart';
import '../../providers/library_provider.dart';

class DocumentDetailScreen extends StatefulWidget {
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
  State<DocumentDetailScreen> createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends State<DocumentDetailScreen> {
  bool _isSaved = false;

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
                icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_outline),
                onPressed: () {
                  setState(() => _isSaved = !_isSaved);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isSaved ? 'Đã lưu tài liệu' : 'Đã bỏ lưu tài liệu'),
                    ),
                  );
                },
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
                    widget.title ?? widget.documentId,
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
                            widget.author,
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
                                index < widget.rating.toInt()
                                    ? Icons.star
                                    : Icons.star_outline,
                                color: Colors.amber,
                                size: AppSpacing.iconSmall,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${widget.rating} (245 votes)',
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
                      onPressed: () => _downloadDocument(context),
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
                            RouterHelper.goBookLending(context, documentId: widget.documentId);
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
                              documentId: widget.documentId,
                              documentTitle: widget.title ?? widget.documentId,
                            );
                          },
                          icon: const Icon(Icons.star_outline, size: 16),
                          label: const Text('Đánh giá', style: TextStyle(fontSize: 11)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Colors.amber),
                            foregroundColor: Colors.amber.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            RouterHelper.goCommunityFeed(
                              context,
                              communityId: widget.title ?? widget.documentId,
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

  Future<void> _downloadDocument(BuildContext context) async {
    final document = DocumentModel(
      id: widget.documentId,
      title: widget.title ?? widget.documentId,
      author: widget.author,
      category: 'Tài liệu',
      description:
          'Tài liệu được tải xuống từ EduShare để bạn có thể mở lại trong thư viện.',
      rating: widget.rating,
      downloadCount: 1200,
      fileType: 'PDF',
      uploadDate: DateTime.now().toIso8601String(),
    );
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<LibraryProvider>().downloadDocument(document);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Đã tải tài liệu vào thư viện' : 'Không thể tải tài liệu',
        ),
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
