import 'package:flutter/material.dart';
import 'package:wave/widgets/appbar_with_back.dart';

class BadgePage extends StatefulWidget {
  const BadgePage({Key? key}) : super(key: key);

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '업적 배지 페이지'),
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
              '배지를 얼마나 모았을까요?',
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
                _buildBadgeImage('환경을 향한 첫 걸음!', 'assets/images/blowfish.png'),
                const SizedBox(
                  width: 40,
                ),
                _buildBadgeImage(
                    '일주일 간 5번 수거 달성', 'assets/images/bluefish.png'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBadgeImage('대왕 쓰레기의 포착', 'assets/images/swirl.png'),
                const SizedBox(
                  width: 45,
                ),
                _buildBadgeImage(
                    '설정한 목표 1회 달성', 'assets/images/tropicalfish.png'),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              color: const Color(0xff72B8C1), // 푸른색 배경 색상
              padding: const EdgeInsets.all(16),
              child: const Text(
                '🐡업적을 달성하여, 바다 친구들을 모두 모아주세요!🐙',
                style: TextStyle(
                  color: Colors.white, // 텍스트 색상
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeImage(String text, String imagePath) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
