// Search Screen
// 🔍 Màn hình tìm kiếm - Parameter: initialQuery (optional) từ other screens
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/router_helper.dart';
import '../../providers/document_provider.dart';

class SearchScreen extends StatefulWidget {
  /// 🔍 Search query từ other screens
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late String _query;

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery ?? '';
    _searchController = TextEditingController(text: _query);
    Future.microtask(() {
      final provider = context.read<DocumentProvider>();
      provider.loadDocuments().then((_) {
        if (_query.isNotEmpty) provider.searchDocuments(_query);
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm Python, Data Science...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() => _query = value);
            context.read<DocumentProvider>().searchDocuments(value);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() => _query = _searchController.text);
              context.read<DocumentProvider>().searchDocuments(_searchController.text);
            },
          ),
        ],
      ),
      body: _query.isEmpty
        ? const Center(child: Text('Nhập từ khóa tìm kiếm'))
        : Consumer<DocumentProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              final results = provider.filteredDocuments;
              if (results.isEmpty) {
                return _buildMockResults();
              }
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final document = results[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    elevation: 0.5,
                    child: ListTile(
                      leading: const Icon(Icons.description, color: AppColors.primary),
                      title: Text(document.title),
                      subtitle: Text('${document.category} • ${document.fileType}'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () {
                        RouterHelper.goDocumentDetail(
                          context,
                          documentId: document.id,
                          title: document.title,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
    );
  }

  Widget _buildMockResults() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        final resultTitle = 'Kết quả ${index + 1} cho "$_query"';
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          elevation: 0.5,
          child: ListTile(
            leading: const Icon(Icons.description, color: AppColors.primary),
            title: Text(resultTitle),
            subtitle: const Text('Tài liệu học tập • PDF'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              RouterHelper.goDocumentDetail(
                context,
                documentId: 'search_res_$index',
                title: resultTitle,
              );
            },
          ),
        );
      },
    );
  }
}
