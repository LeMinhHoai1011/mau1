// Search Provider with DB integration
import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/search_history_model.dart';
import '../data/database/search_history_dao.dart';

class SearchProvider extends ChangeNotifier {
  final SearchHistoryDAO _searchHistoryDAO = SearchHistoryDAO();
  List<SearchHistoryModel> _searchHistory = [];
  List<String> _suggestions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<SearchHistoryModel> get searchHistory => _searchHistory;
  List<String> get suggestions => _suggestions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  SearchProvider() {
    loadSearchHistory();
  }

  // Load search history from DB
  Future<void> loadSearchHistory() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchHistory = await _searchHistoryDAO.getAllSearchHistory();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add search query to history
  Future<void> addSearchQuery(String query) async {
    if (query.isNotEmpty) {
      try {
        final historyItem = SearchHistoryModel(
          query: query,
          searchDate: DateTime.now().toIso8601String(),
        );
        await _searchHistoryDAO.insertSearchHistory(historyItem);
        await loadSearchHistory(); // Reload to get updated list
      } catch (e) {
        _errorMessage = e.toString();
        notifyListeners();
      }
    }
  }

  // Clear all search history
  Future<void> clearSearchHistory() async {
    try {
      await _searchHistoryDAO.clearAllSearchHistory();
      _searchHistory.clear();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Remove specific search query
  Future<void> removeSearchQuery(int id) async {
    try {
      await _searchHistoryDAO.deleteSearchHistory(id);
      await loadSearchHistory();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
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
