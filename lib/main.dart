import 'package:wave/screen/post_list_screen.dart';
import 'package:wave/screen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:wave/screen/splash_screen.dart';
import 'package:wave/screen/mypage_screen.dart';
import 'package:wave/screen/post_detail.dart';
// import 'package:wave/screen/home_screen.dart';
// import 'package:wave/screen/mypage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            // MyPage 화면 구현 전 임시 추가
            // 로직을 어떻게 해야되지?????
            MyPage(),
            //HomeScreen(),
            PostScreen(),
            PostList(),
            PostDetail(), //PostAnalysis
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xff72B8C1),
      selectedItemColor: const Color(0xffF5D184),
      unselectedItemColor: const Color(0xffF8F8F8),
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: '마이페이지'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.report_gmailerrorred,
          ),
          label: '신고하기',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.format_list_bulleted,
          ),
          label: '신고 목록',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart,
          ),
          label: '분석 리포트',
        ),
      ],
    );
  }
}
