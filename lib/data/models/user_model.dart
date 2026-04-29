// User Model
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final String bio;
  final int documentCount;
  final String contributionLevel;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.bio = '',
    this.documentCount = 0,
    this.contributionLevel = 'bronze',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'documentCount': documentCount,
      'contributionLevel': contributionLevel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'],
      bio: map['bio'] ?? '',
      documentCount: map['documentCount'] ?? 0,
      contributionLevel: map['contributionLevel'] ?? 'bronze',
    );
  }
}
