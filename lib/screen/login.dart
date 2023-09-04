import 'package:flutter/material.dart';
import 'package:wave/screen/signup.dart';
// import 'package:wave_login/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                      SizedBox(height: 60),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // 이부분 진영 userInput위젯으로 리팩토링
                    Positioned(
                      top: 520,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 350,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const TextField(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'ID',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 600,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 350,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const TextField(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 680,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 350,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              // onPressed 수행 (아직 안함)
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              backgroundColor: const Color(0xFF72B8C1),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
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
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 810,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.center,
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
          ],
        ),
      ),
    );
  }
}
