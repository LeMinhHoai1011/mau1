/// Route Arguments - Lớp để truyền dữ liệu giữa các screens
class DocumentDetailArguments {
  final String documentId;
  final String? title;
  final String? imagePath;

  DocumentDetailArguments({
    required this.documentId,
    this.title,
    this.imagePath,
  });
}

class ReviewArguments {
  final String documentId;
  final String documentTitle;

  ReviewArguments({
    required this.documentId,
    required this.documentTitle,
  });
}

class SearchArguments {
  final String? initialQuery;

  SearchArguments({this.initialQuery});
}

class EditProfileArguments {
  final String? userId;

  EditProfileArguments({this.userId});
}

class CommunityFeedArguments {
  final String communityId;

  CommunityFeedArguments({required this.communityId});
}

class BookLendingArguments {
  final String documentId;

  BookLendingArguments({required this.documentId});
}
