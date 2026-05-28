// Document Provider
import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/document_model.dart';
import '../data/database/document_dao.dart';

enum DocumentStatus { idle, loading, success, error }

class DocumentProvider extends ChangeNotifier {
  final DocumentDAO _documentDAO = DocumentDAO();
  List<DocumentModel> _documents = [];
  List<DocumentModel> _filteredDocuments = [];
  DocumentStatus _status = DocumentStatus.idle;
  String? _errorMessage;
  Timer? _debounceTimer;

  List<DocumentModel> get documents => _documents;
  List<DocumentModel> get filteredDocuments => _filteredDocuments;
  DocumentStatus get status => _status;
  bool get isLoading => _status == DocumentStatus.loading;
  bool get isSuccess => _status == DocumentStatus.success;
  bool get hasError => _status == DocumentStatus.error;
  String? get errorMessage => _errorMessage;

  // Lấy tất cả tài liệu
  Future<void> loadDocuments() async {
    _status = DocumentStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _documents = await _documentDAO.getAllDocuments();
      _filteredDocuments = _documents;
      _status = DocumentStatus.success;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = DocumentStatus.error;
      notifyListeners();
    }
  }

  // Lấy tài liệu theo danh mục
  Future<void> loadDocumentsByCategory(String category) async {
    _status = DocumentStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _filteredDocuments = await _documentDAO.getDocumentsByCategory(category);
      _status = DocumentStatus.success;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = DocumentStatus.error;
      notifyListeners();
    }
  }

  // Tìm kiếm với debounce
  void searchWithDebounce(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      searchDocuments(query);
    });
  }

  // Tìm kiếm tài liệu
  Future<void> searchDocuments(String query) async {
    if (query.isEmpty) {
      _filteredDocuments = _documents;
      _status = DocumentStatus.success;
      notifyListeners();
      return;
    }

    _status = DocumentStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _filteredDocuments = await _documentDAO.searchDocuments(query);
      _status = DocumentStatus.success;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = DocumentStatus.error;
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
