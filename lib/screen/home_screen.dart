import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: renderBody(),
    );
  }

  Padding renderBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '안녕하세요! 예림님',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: CircleAvatar(
                backgroundColor: Color(0xff1B818F),
                radius: 70,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    // backgroundImage: AssetImage('assets/images/logo.png'),
                    backgroundImage:
                        NetworkImage('https://picsum.photos/id/237/200/300'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '진행 중',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            checkLists(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '해결 완료!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    // 알 수 없는 틈의 빈 공간 존재
                    children: [
                      Row(
                        children: [
                          CheckboxExample(),
                          Text('경포해변 유리 조각에 다칠 뻔 했어요ㅜㅜ'),
                        ],
                      ),
                      Row(
                        children: [
                          CheckboxExample(),
                          Text('쓰레기 더미가 너무 많아서 미관상 안 좋네요'),
                        ],
                      ),
                      Row(
                        children: [
                          CheckboxExample(),
                          Text('누군가가 쓰레기를 버렸나봐요.. 쓰레기가 ...'),
                        ],
                      ),
                      Center(
                        child: Icon(
                          Icons.more_horiz,
                        ),
                      ),
                      Text('게시물을 클릭하면 자세한 확인이 가능합니다.')
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

  Center checkLists() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            // 알 수 없는 틈의 빈 공간 존재
            children: [
              Row(
                children: [
                  CheckboxExample(),
                  Text('인천 동막해변에 스티로폼 쓰레기 있어😖'),
                ],
              ),
              Row(
                children: [
                  CheckboxExample(),
                  Text('강릉 강문해변에 알 수 없는 쓰레기 무덤😫'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar부분 구현 함수
  PreferredSize renderAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: AppBar(
        backgroundColor: const Color(0xff7091CF),
        // title: const Text('Wave'),
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 52,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Wave'),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: '설정',
            onPressed: () => {},
          )
        ],
      ),
    );
  }

  // BottomNavigationBar부분 구현
  // BottomNavigationBar renderBottomNavigation() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: const Color(0xff72B8C1),
  //     selectedItemColor: const Color(0xffF5D184),
  //     unselectedItemColor: const Color(0xffF8F8F8),
  //     items: const [
  //       BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.account_circle,
  //           ),
  //           label: '마이페이지'),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.report_gmailerrorred,
  //         ),
  //         label: '신고하기',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.format_list_bulleted,
  //         ),
  //         label: '신고 목록',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.favorite,
  //         ),
  //         label: '한눈에 보기',
  //       ),
  //     ],
  //   );
  // }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red; // 색상 적용 안됨
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
