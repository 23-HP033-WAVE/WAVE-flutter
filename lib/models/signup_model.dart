class SignUpModel {
  final String username;
  final String email;
  final String password;

  SignUpModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };
  }
}
