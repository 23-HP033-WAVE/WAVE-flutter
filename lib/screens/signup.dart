import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/models/signup_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pnumController = TextEditingController();
  final locationController = TextEditingController();

  final baseUrl = 'http://3.39.112.66:5000';
  final signup = '/auth/signup/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF72B8C1),
        title: const Text('회원 가입'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: '이메일',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: pnumController,
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: '주소',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signUp(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: const Color(0xFF72B8C1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text('회원 가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final pnum = pnumController.text;
    final location = locationController.text;

    // 서버 URL 생성
    final url = Uri.parse('$baseUrl$signup');

    final signUpModel = SignUpModel(
      username: username,
      email: email,
      password: password,
      pnum: pnum,
      location: location,
    );

    final scaffoldContext = ScaffoldMessenger.of(context);
    scaffoldContext.showSnackBar(
      const SnackBar(
        content: Text('회원가입 중...'),
      ),
    );

    final response = await http.post(
      url,
      body: jsonEncode(signUpModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final status = responseData['status'];
      if (status == 'success') {
        if (!mounted) return;
        scaffoldContext.showSnackBar(
          const SnackBar(
            content: Text('회원가입 성공!'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } else {
        final message = responseData['message'];
        if (!mounted) return;
        scaffoldContext.showSnackBar(
          SnackBar(
            content: Text('회원가입 실패: $message'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (!mounted) return;
      scaffoldContext.showSnackBar(
        SnackBar(
          content: Text('서버 오류: ${response.statusCode}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
