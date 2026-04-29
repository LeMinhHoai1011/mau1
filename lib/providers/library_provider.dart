import 'package:flutter/material.dart';
import '../data/models/document_model.dart';

class LibraryProvider extends ChangeNotifier {
  List<DocumentModel> _savedDocuments = [];
  List<DocumentModel> _downloadedDocuments = [];
  bool _isLoading = false;

  List<DocumentModel> get savedDocuments => _savedDocuments;
  List<DocumentModel> get downloadedDocuments => _downloadedDocuments;
  bool get isLoading => _isLoading;

  Future<void> loadLibrary() async {
    _isLoading = true;
    notifyListeners();
    // Load from DB/mock
    await Future.delayed(Duration(milliseconds: 500));
    _isLoading = false;
    notifyListeners();
  }

  void toggleSave(DocumentModel document) {
    if (_savedDocuments.contains(document)) {
      _savedDocuments.remove(document);
    } else {
      _savedDocuments.add(document);
    }
    notifyListeners();
  }

  void addDownloaded(DocumentModel document) {
    _downloadedDocuments.add(document);
    notifyListeners();
  }
}
