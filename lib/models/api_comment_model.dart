class ApiCommentModel {
  final int id;
  final String body;
  final int postId;
  final int likes;
  final ApiUserModel user;

  ApiCommentModel({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });

  factory ApiCommentModel.fromJson(Map<String, dynamic> json) {
    return ApiCommentModel(
      id: json['id'] as int,
      body: json['body'] as String,
      postId: json['postId'] as int,
      likes: json['likes'] as int,
      user: ApiUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class ApiUserModel {
  final int id;
  final String username;
  final String fullName;

  ApiUserModel({
    required this.id,
    required this.username,
    required this.fullName,
  });

  factory ApiUserModel.fromJson(Map<String, dynamic> json) {
    return ApiUserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );
  }
}

