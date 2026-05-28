// Book Lending Screen
// 📚 Màn hình mượn/cho mượn sách - Parameter: documentId (optional) để mượn document cụ thể
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class BookLendingScreen extends StatefulWidget {
  /// 📚 Document ID to lend (if any)
  final String? documentId;

  const BookLendingScreen({super.key, this.documentId});

  @override
  State<BookLendingScreen> createState() => _BookLendingScreenState();
}

class _BookLendingScreenState extends State<BookLendingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  
  String _selectedCondition = 'Rất tốt';
  final List<Map<String, String>> _bookListings = [];

  @override
  void initState() {
    super.initState();
    // 📚 Nếu có documentId, có thể load thông tin document
    if (widget.documentId != null && widget.documentId!.isNotEmpty) {
      _loadDocumentInfo(widget.documentId!);
    }
  }

  /// Load thông tin document từ database (nếu có)
  void _loadDocumentInfo(String documentId) {
    // TODO: Load document info và set vào controllers
    // Example:
    // _titleController.text = document.title;
    // _authorController.text = document.author;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.bookLending),
      ),
      body: _bookListings.isEmpty
          ? _buildEmptyState()
          : _buildBookList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBookModal(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_books, size: 64, color: AppColors.primary.withValues(alpha: 0.3)),
          SizedBox(height: 16),
          Text(
            'Chưa có sách nào',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Nhấn + để thêm sách mua muốn mượn',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList() {
    return ListView(
      padding: EdgeInsets.all(12),
      children: _bookListings
          .map((book) => _buildBookCard(book))
          .toList(),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.book, color: AppColors.primary, size: 32),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book['title'] ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Tác giả: ${book['author']}',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                SizedBox(height: 4),
                Text(
                  'Tình trạng: ${book['condition']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: _getConditionColor(book['condition'] ?? ''),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Địa điểm: ${book['location']}',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.edit, size: 18),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete, size: 18, color: Colors.red),
                onPressed: () => _deleteBook(book),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddBookModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Thêm sách mượn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Title
              Text(
                AppStrings.bookTitle,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Nhập tiêu đề sách'),
              ),
              SizedBox(height: 12),

              // Author
              Text(
                AppStrings.bookAuthor,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(hintText: 'Nhập tên tác giả'),
              ),
              SizedBox(height: 12),

              // Condition
              Text(
                AppStrings.bookCondition,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCondition,
                items: ['Rất tốt', 'Tốt', 'Khá', 'Trung bình']
                    .map((condition) => DropdownMenuItem(
                          value: condition,
                          child: Text(condition),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCondition = value ?? 'Rất tốt'),
              ),
              SizedBox(height: 12),

              // Location
              Text(
                AppStrings.exchangeLocation,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(hintText: 'Nhập địa điểm'),
              ),
              SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _addBook(),
                  child: Text(AppStrings.lend),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addBook() {
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    setState(() {
      _bookListings.add({
        'title': _titleController.text,
        'author': _authorController.text,
        'condition': _selectedCondition,
        'location': _locationController.text,
      });
    });

    _titleController.clear();
    _authorController.clear();
    _locationController.clear();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sách đã được thêm thành công!')),
    );
  }

  void _deleteBook(Map<String, String> book) {
    setState(() => _bookListings.remove(book));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sách đã được xóa')),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case 'Rất tốt':
        return Colors.green;
      case 'Tốt':
        return Colors.blue;
      case 'Khá':
        return Colors.orange;
      case 'Trung bình':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

@override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
