import 'dart:ffi';

class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  factory LoginModel.fromJson(Map<Int, dynamic> json) {
    return LoginModel(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username.trim(),
      'password': password.trim(),
    };
  }
}
