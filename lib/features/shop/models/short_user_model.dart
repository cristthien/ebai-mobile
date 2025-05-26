
class ShortUserModel {
  final int id;
  final String username;
  final String email;

  ShortUserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory ShortUserModel.fromJson(Map<String, dynamic> json) {
    return ShortUserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}