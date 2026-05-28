// Downloaded Document Model
class DownloadedDocumentModel {
  final String id;
  final String documentId;
  final String downloadPath;
  final String downloadDate;

  DownloadedDocumentModel({
    required this.id,
    required this.documentId,
    required this.downloadPath,
    required this.downloadDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'documentId': documentId,
      'downloadPath': downloadPath,
      'downloadDate': downloadDate,
    };
  }

  factory DownloadedDocumentModel.fromMap(Map<String, dynamic> map) {
    return DownloadedDocumentModel(
      id: map['id'] ?? '',
      documentId: map['documentId'] ?? '',
      downloadPath: map['downloadPath'] ?? '',
      downloadDate: map['downloadDate'] ?? '',
    );
  }
}