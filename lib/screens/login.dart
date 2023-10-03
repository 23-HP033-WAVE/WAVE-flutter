import 'package:flutter/material.dart';
import 'package:wave/main.dart';
import 'package:wave/screens/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF72B8C1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Positioned.fill(
              child: Image.asset(
                // 임시파일
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
              // width: 427,
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
                      userInput(idController, 'ID', TextInputType.emailAddress),
                      userInput(passwordController, 'Password',
                          TextInputType.visiblePassword),
                      Container(
                        height: 55,
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: const Color(0xff72B8C1),
                          ),
                          onPressed: () {
                            // _login(context);
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
                      const SizedBox(height: 16),
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
                              // signup 페이지로 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
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
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20),
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(1, 3), // changes position of shadow
                blurStyle: BlurStyle.normal),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
          child: TextField(
            controller: userInput,
            autocorrect: false,
            enableSuggestions: false,
            autofocus: false,
            decoration: InputDecoration.collapsed(
              hintText: hintTitle,
              hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black38,
                  fontStyle: FontStyle.normal),
            ),
            keyboardType: keyboardType,
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final id = idController.text;
    final password = passwordController.text;

    // 서버쪽 URL
    final url = Uri.parse('https://어쩌구 저쩌구/login');

    final loginModel = LoginModel(userId: id, password: password);
    // // 로그인 데이터
    // final Map<String, String> data = {
    //   'id': id,
    //   'password': password,
    // };

    // ScaffoldMessenger를 이용하여 SnackBar를 표시
    final scaffoldContext = _scaffoldKey.currentContext;
    ScaffoldMessenger.of(scaffoldContext!).showSnackBar(
      const SnackBar(
        content: Text('로그인 중...'),
      ),
    );

    final response = await http.post(
      url,
      body: jsonEncode(loginModel.toJson()), // JSON 형태로 전송
      headers: {'Content-Type': 'application/json'}, // 헤더
    );

    if (response.statusCode == 200) {
      // http OK 응답 시
      final responseData = jsonDecode(response.body);
      final status = responseData['status'];
      // 로그인 성공
      if (status == 'success') {
        final userId = responseData['user_id']; // 플라스크에 userId가 어떻게 저장되었는지 보기
        if (!mounted) return; // 비동기 시 async뒤에 context에 null값 있을 수 있으므로
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('로그인 성공! 사용자 ID: $userId'),
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
