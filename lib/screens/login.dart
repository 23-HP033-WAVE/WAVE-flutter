import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/models/login_model.dart';
import 'package:wave/screens/signup.dart';
import 'package:wave/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final username = idController.text;
      final password = passwordController.text;

      final url = Uri.parse('https://어쩌구 저쩌구/login');

      final loginModel = LoginModel(username: username, password: password);

      //final scaffoldContext = Scaffold.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('로그인 중...'),
        ),
      );

      final response = await http.post(
        url,
        body: jsonEncode(loginModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final status = responseData['status'];
        if (status == 'success') {
          final username = responseData['username'];
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('로그인 성공! 사용자 ID: $username'),
                duration: const Duration(seconds: 2)),
          );
        } else {
          final message = responseData['message'];
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('로그인 실패: $message'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('서버 오류: ${response.statusCode}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF72B8C1),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 80,
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(top: 10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Wave에 오신 것을 환영합니다!',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 370,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        // ID 입력 필드
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: idController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ID를 입력해주세요.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'ID',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        // 비밀번호 입력 필드
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 입력해주세요.';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, right: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                backgroundColor: const Color(0xff72B8C1),
                              ),
                              onPressed: () {
                                //_login(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TabPage()));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 770,
                          right: 0,
                          left: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '- 간편 로그인 -',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/naver_circle.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/btn_google_light_pressed_ios.png',
                                width: 40,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 870,
                          right: 0,
                          left: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: '회원이 아니신가요? ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '회원가입',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
