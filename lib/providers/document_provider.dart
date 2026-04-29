// Document Provider
import 'package:flutter/material.dart';
import '../data/models/document_model.dart';
import '../data/database/document_dao.dart';

class DocumentProvider extends ChangeNotifier {
  final DocumentDAO _documentDAO = DocumentDAO();
  List<DocumentModel> _documents = [];
  List<DocumentModel> _filteredDocuments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<DocumentModel> get documents => _documents;
  List<DocumentModel> get filteredDocuments => _filteredDocuments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Lấy tất cả tài liệu
  Future<void> loadDocuments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _documents = await _documentDAO.getAllDocuments();
      _filteredDocuments = _documents;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Lấy tài liệu theo danh mục
  Future<void> loadDocumentsByCategory(String category) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _filteredDocuments = await _documentDAO.getDocumentsByCategory(category);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Tìm kiếm tài liệu
  Future<void> searchDocuments(String query) async {
    if (query.isEmpty) {
      _filteredDocuments = _documents;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _filteredDocuments = await _documentDAO.searchDocuments(query);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Thêm tài liệu
  Future<bool> addDocument(DocumentModel document) async {
    try {
      await _documentDAO.insertDocument(document);
      _documents.add(document);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Cập nhật rating
  Future<bool> updateDocumentRating(String documentId, double newRating) async {
    try {
      final doc = await _documentDAO.getDocumentById(documentId);
      if (doc != null) {
        final updatedDoc = DocumentModel(
          id: doc.id,
          title: doc.title,
          author: doc.author,
          category: doc.category,
          description: doc.description,
          rating: newRating,
          downloadCount: doc.downloadCount,
          fileType: doc.fileType,
          uploadDate: doc.uploadDate,
          thumbnailUrl: doc.thumbnailUrl,
        );
        await _documentDAO.updateDocument(updatedDoc);
        await loadDocuments();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
