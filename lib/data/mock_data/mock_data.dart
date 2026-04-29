// Mock data for UI
import '../models/document_model.dart';
import '../models/user_model.dart';

final mockDocuments = [
  DocumentModel(
    id: '1',
    title: 'Document 1',
    author: 'Author 1',
    category: 'General',
    description: 'Content 1',
    uploadDate: '2024-01-01'
  ),
  DocumentModel(
    id: '2',
    title: 'Document 2',
    author: 'Author 2',
    category: 'General',
    description: 'Content 2',
    uploadDate: '2024-01-02'
  ),
];

final mockUsers = [
  UserModel(id: '1', name: 'User 1', email: 'user1@example.com'),
  UserModel(id: '2', name: 'User 2', email: 'user2@example.com'),
];
