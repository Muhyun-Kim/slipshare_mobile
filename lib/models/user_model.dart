class UserModel {
  final int id;
  final String username;
  final String? detail;
  final String user_id;

  UserModel({
    required this.id,
    required this.username,
    this.detail,
    required this.user_id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      detail: json['detail'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'detail': detail,
      'user_id': user_id,
    };
  }
}
