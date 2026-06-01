// Upload Document Screen
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/document_model.dart';
import '../../providers/document_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  
  String? _selectedCategory;
  PlatformFile? _selectedFile;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.uploadDocument),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File Selection
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload, color: AppColors.primary, size: 48),
                  SizedBox(height: 12),
                  Text(
                    AppStrings.selectFile,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'PDF, DOCX, PPTX (Max 50MB)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (_selectedFile != null) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.description, color: AppColors.primary),
                      title: Text(_selectedFile!.name),
                      subtitle: Text(_formatBytes(_selectedFile!.size)),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => setState(() => _selectedFile = null),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  ElevatedButton.icon(
                    icon: Icon(Icons.folder_open),
                    label: Text(_selectedFile == null ? 'Chọn file' : 'Đổi file'),
                    onPressed: _pickFile,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Title
            Text(
              AppStrings.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Nhập tiêu đề tài liệu',
              ),
            ),
            SizedBox(height: 16),

            // Category
            Text(
              AppStrings.category,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                hintText: 'Chọn chủ đề',
              ),
              items: [
                'Lập trình',
                'Toán học',
                'Vật lý',
                'Tiếng Anh',
                'Quản trị',
              ]
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedCategory = value);
              },
            ),
            SizedBox(height: 16),

            // Description
            Text(
              AppStrings.description,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Mô tả nội dung tài liệu...',
              ),
            ),
            SizedBox(height: 16),

            // Tags
            Text(
              AppStrings.tags,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _tagsController,
              decoration: InputDecoration(
                hintText: 'Nhập tags, cách nhau bởi dấu phẩy',
              ),
            ),
            SizedBox(height: 24),

            // Upload Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isUploading ? null : () => _uploadDocument(),
                child: _isUploading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(AppStrings.upload),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadDocument() {
    if (_selectedFile == null ||
        _titleController.text.trim().isEmpty ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng chọn file, nhập tiêu đề và chọn danh mục')),
      );
      return;
    }

    setState(() => _isUploading = true);
    
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      _saveDocument();
    });
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
      withData: false,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.single;
    const maxBytes = 50 * 1024 * 1024;
    if (file.size > maxBytes) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File vượt quá giới hạn 50MB')),
      );
      return;
    }

    setState(() {
      _selectedFile = file;
      if (_titleController.text.trim().isEmpty) {
        _titleController.text = file.name.replaceFirst(RegExp(r'\.[^.]+$'), '');
      }
    });
  }

  Future<void> _saveDocument() async {
    final file = _selectedFile!;
    final extension = file.extension?.toUpperCase() ?? 'PDF';
    final document = DocumentModel(
      id: 'upload_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      author: 'Nguyễn Văn A',
      category: _selectedCategory!,
      description: _descriptionController.text.trim(),
      rating: 0,
      downloadCount: 0,
      fileType: extension,
      uploadDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      thumbnailUrl: file.path,
    );

    final success = await context.read<DocumentProvider>().addDocument(document);
    if (!mounted) return;
    setState(() => _isUploading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Tài liệu đã được tải lên thành công!' : 'Không thể lưu tài liệu',
        ),
      ),
    );
    if (success && mounted) Navigator.pop(context);
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}
