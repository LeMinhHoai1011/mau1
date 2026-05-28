// Book Lending Provider
import 'package:flutter/material.dart';

class LendingRequest {
  final String id;
  final String documentId;
  final String requesterId;
  final String requesterName;
  final String requestDate;
  final String status; // pending, approved, rejected

  LendingRequest({
    required this.id,
    required this.documentId,
    required this.requesterId,
    required this.requesterName,
    required this.requestDate,
    this.status = 'pending',
  });
}

class BookLendingProvider extends ChangeNotifier {
  List<LendingRequest> _requests = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<LendingRequest> get requests => _requests;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadRequests() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      _requests = [
        LendingRequest(
          id: '1',
          documentId: 'doc1',
          requesterId: 'user1',
          requesterName: 'Alice',
          requestDate: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
          status: 'pending',
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

  Future<bool> requestLending(String documentId) async {
    try {
      final request = LendingRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        documentId: documentId,
        requesterId: 'current_user', // TODO: Get from auth
        requesterName: 'Current User',
        requestDate: DateTime.now().toIso8601String(),
      );
      _requests.add(request);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> approveRequest(String requestId) async {
    try {
      final index = _requests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        _requests[index] = LendingRequest(
          id: _requests[index].id,
          documentId: _requests[index].documentId,
          requesterId: _requests[index].requesterId,
          requesterName: _requests[index].requesterName,
          requestDate: _requests[index].requestDate,
          status: 'approved',
        );
        notifyListeners();
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