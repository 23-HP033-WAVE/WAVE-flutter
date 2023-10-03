import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../Models/auth.dart';
// import 'successful_screen.dart';

// 신진영이 중복으로 만든..ㅠ

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // static const routeName = '/login-screen';
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: renderBody()),
    );
  }

  Container renderBody() {
    return Container(
      color: const Color(0xff72B8C1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 180),
          const Center(
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Wave에 오신 걸 환영합니다!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 60),
          Container(
            height: 370,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
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
                          // print(emailController);
                          // print(passwordController);
                          // Provider.of<Auth>(context, listen: false).login(
                          //     emailController.text, passwordController.text);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (ctx) => SuccessfulScreen()));
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
                    const Center(
                      child: Text('간편 로그인'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // 임시 로고
                            simpleLogin(Icons.add),
                            simpleLogin(Icons.add),
                            simpleLogin(Icons.add),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('회원이 아니신가요?'),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                            foregroundColor: const Color(0xffFF5959),
                          ),
                          onPressed: () {},
                          child: const Text('회원가입'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget simpleLogin(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
        ],
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
}
