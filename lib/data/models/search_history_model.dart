// Search History Model
class SearchHistoryModel {
  final int? id;
  final String query;
  final String searchDate;

  SearchHistoryModel({
    this.id,
    required this.query,
    required this.searchDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
      'searchDate': searchDate,
    };
  }

  factory SearchHistoryModel.fromMap(Map<String, dynamic> map) {
    return SearchHistoryModel(
      id: map['id'],
      query: map['query'] ?? '',
      searchDate: map['searchDate'] ?? '',
    );
  }
}