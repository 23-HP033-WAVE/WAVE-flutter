class SignUpModel {
  final String username;
  final String email;
  final String password;
  final String pnum;
  final String location;

  SignUpModel({
    required this.username,
    required this.email,
    required this.password,
    required this.pnum,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'pnum': pnum.trim(),
      'location': location.trim(),
    };
  }
}
