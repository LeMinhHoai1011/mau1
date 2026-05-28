// Community Provider
import 'package:flutter/material.dart';

class CommunityPost {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final String timestamp;
  final int likes;
  final int comments;

  CommunityPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.comments = 0,
  });
}

class CommunityProvider extends ChangeNotifier {
  List<CommunityPost> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CommunityPost> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      _posts = [
        CommunityPost(
          id: '1',
          userId: 'user1',
          userName: 'Alice',
          content: 'Great resource for Flutter development!',
          timestamp: DateTime.now().toIso8601String(),
          likes: 5,
          comments: 2,
        ),
        CommunityPost(
          id: '2',
          userId: 'user2',
          userName: 'Bob',
          content: 'Anyone have notes on Machine Learning?',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
          likes: 3,
          comments: 1,
        ),
      ];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addPost(String content) async {
    if (content.trim().isEmpty) {
      _errorMessage = 'Content cannot be empty';
      notifyListeners();
      return false;
    }

    try {
      final newPost = CommunityPost(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user', // TODO: Get from auth
        userName: 'Current User',
        content: content,
        timestamp: DateTime.now().toIso8601String(),
      );
      _posts.insert(0, newPost);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}