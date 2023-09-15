import 'package:flutter/material.dart';
import 'package:wave/screen/post_analysis_screen.dart';
import 'package:wave/widgets/myAppBar.dart';
import 'package:wave/screen/badge_screen.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '마이 페이지'),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              '반갑습니다! 예림님',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1B818F),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(16),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://picsum.photos/id/237/200/300'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _buildButton(
                //   icon: Icons.badge,
                //   text: '업적 배지',
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               const BadgePage()), // BadgePage로 이동
                //     );
                //   },
                // ),
                //const SizedBox(width: 20),
                _buildButton(
                  icon: Icons.list_alt_rounded,
                  text: '나의 목록',
                  onPressed: () {
                    // 추가 필요
                  },
                ),
                const SizedBox(width: 20),
                _buildButton(
                  icon: Icons.analytics_outlined,
                  text: '한눈에 보기',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PostAnalysis()), // BadgePage로 이동
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '배지 획득 확인하기🎖️',
                    style: TextStyle(fontSize: 17),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BadgePage()), // BadgePage로 이동
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff7091CF),
        elevation: 5,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(140, 80),
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
