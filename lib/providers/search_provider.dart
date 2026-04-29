// Search Provider
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  List<String> _searchHistory = [];
  List<String> _suggestions = [];

  List<String> get searchHistory => _searchHistory;
  List<String> get suggestions => _suggestions;

  SearchProvider() {
    _loadSearchHistory();
  }

  // Tải lịch sử tìm kiếm
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('search_history') ?? [];
    notifyListeners();
  }

  // Thêm vào lịch sử tìm kiếm
  Future<void> addSearchQuery(String query) async {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('search_history', _searchHistory);
      notifyListeners();
    }
  }

  // Xóa lịch sử tìm kiếm
  Future<void> clearSearchHistory() async {
    _searchHistory.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history');
    notifyListeners();
  }

  // Xóa một mục khỏi lịch sử
  Future<void> removeSearchQuery(String query) async {
    _searchHistory.remove(query);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _searchHistory);
    notifyListeners();
  }

  // Cập nhật gợi ý
  void updateSuggestions(List<String> suggestions) {
    _suggestions = suggestions;
    notifyListeners();
  }

  // Danh sách các danh mục phổ biến
  List<String> getPopularCategories() {
    return [
      'Lập trình',
      'Toán học',
      'Vật lý',
      'Hóa học',
      'Tiếng Anh',
      'Quản trị',
      'Kinh tế',
      'Luật',
    ];
  }

  // Danh sách ngôn ngữ lập trình
  List<String> getProgrammingLanguages() {
    return ['Python', 'Java', 'C++', 'JavaScript', 'Go', 'Rust', 'PHP', 'C#'];
  }
}
