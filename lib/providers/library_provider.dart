import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../data/models/document_model.dart';
import '../data/models/downloaded_document_model.dart';
import '../data/database/downloaded_document_dao.dart';

class LibraryProvider extends ChangeNotifier {
  final DownloadedDocumentDAO _downloadedDAO = DownloadedDocumentDAO();
  final List<DocumentModel> _savedDocuments = [];
  List<DownloadedDocumentModel> _downloadedDocuments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<DocumentModel> get savedDocuments => _savedDocuments;
  List<DownloadedDocumentModel> get downloadedDocuments => _downloadedDocuments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadLibrary() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _downloadedDocuments = await _downloadedDAO.getAllDownloadedDocuments();
      // TODO: Load saved documents from DB if needed
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleSave(DocumentModel document) {
    if (_savedDocuments.contains(document)) {
      _savedDocuments.remove(document);
    } else {
      _savedDocuments.add(document);
    }
    notifyListeners();
  }

  Future<bool> addDownloadedDocument(String documentId, String downloadPath) async {
    try {
      final downloadedDoc = DownloadedDocumentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        documentId: documentId,
        downloadPath: downloadPath,
        downloadDate: DateTime.now().toIso8601String(),
      );
      await _downloadedDAO.insertDownloadedDocument(downloadedDoc);
      await loadLibrary(); // Reload list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Download document with permission check
  Future<bool> downloadDocument(DocumentModel document) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        _errorMessage = 'Storage permission denied';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Get download directory
      Directory? downloadDir;
      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadDir = await getApplicationDocumentsDirectory();
      }

      if (!downloadDir.existsSync()) {
        downloadDir.createSync(recursive: true);
      }

      // Simulate download (in real app, download from URL)
      final fileName = '${document.title.replaceAll(' ', '_')}.${document.fileType.toLowerCase()}';
      final filePath = '${downloadDir.path}/$fileName';

      // For demo, create empty file
      final file = File(filePath);
      await file.writeAsString('Downloaded content for ${document.title}');

      // Save to DB
      await addDownloadedDocument(document.id, filePath);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Open downloaded document
  Future<void> openDownloadedDocument(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        _errorMessage = 'Cannot open file: ${result.message}';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
