class LoginModel {
  final String userId;
  final String password;

  LoginModel({
    required this.userId,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json['user_id'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId.trim(),
      'password': password.trim(),
    };
  }
}
