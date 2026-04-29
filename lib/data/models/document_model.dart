// Document Model
class DocumentModel {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final double rating;
  final int downloadCount;
  final String fileType;
  final String uploadDate;
  final String? thumbnailUrl;

  DocumentModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    this.description = '',
    this.rating = 0.0,
    this.downloadCount = 0,
    this.fileType = 'PDF',
    required this.uploadDate,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'description': description,
      'rating': rating,
      'downloadCount': downloadCount,
      'fileType': fileType,
      'uploadDate': uploadDate,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      downloadCount: map['downloadCount'] ?? 0,
      fileType: map['fileType'] ?? 'PDF',
      uploadDate: map['uploadDate'] ?? '',
      thumbnailUrl: map['thumbnailUrl'],
    );
  }
}
