// File Manager Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/library_provider.dart';

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<LibraryProvider>().loadLibrary());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Quản lý tải xuống')),
      body: Consumer<LibraryProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.downloadedDocuments.isEmpty) {
            return const Center(child: Text('Chưa có tài liệu đã tải'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.downloadedDocuments.length,
            itemBuilder: (context, index) {
              final item = provider.downloadedDocuments[index];
              final name = item.downloadPath.split(RegExp(r'[\\/]')).last;
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.download_done, color: AppColors.primary),
                  title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text('Hoàn tất • ${item.downloadDate.split('T').first}'),
                  onTap: () => provider.openDownloadedDocument(item.downloadPath),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => provider.deleteDownloadedDocument(item),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
