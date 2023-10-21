import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wave/models/post_title_model.dart';
import 'package:wave/screens/mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<Album> fetchReportPosts() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('신고 게시물을 불러오지 못했습니다.');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Album> futureReportPosts;

  @override
  void initState() {
    super.initState();
    futureReportPosts = fetchReportPosts();
  }

  @override
  Widget build(BuildContext context) {
    const String name = '진영';
    return Scaffold(
      appBar: renderAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '안녕하세요! $name님',
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
                  radius: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 43,
                      backgroundImage: AssetImage('assets/images/myAvatar.png'),
                      // NetworkImage('https://picsum.photos/id/237/200/300'),
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
                      children: [
                        Row(
                          children: [
                            IsCheckedboxExample(),
                            Text("경포해변 유리 조각에 다칠뻔 했어요ㅜㅜ"),
                            // FutureBuilder<Album>(
                            //   future: futureAlbum,
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       // return Text(snapshot.data!.title); // 임시로 주석처리
                            //       return const Text("경포해변 유리 조각에 다칠뻔 했어요ㅜㅜ");
                            //     } else if (snapshot.hasError) {
                            //       return Text('${snapshot.error}');
                            //     }

                            //     // By default, show a loading spinner.
                            //     return const CircularProgressIndicator();
                            //   },
                            // )
                          ],
                        ),
                        Row(
                          children: [
                            IsCheckedboxExample(),
                            Text('쓰레기 더미가 너무 많아서 미관상 안 좋네요'),
                          ],
                        ),
                        Row(
                          children: [
                            IsCheckedboxExample(),
                            Text('누군가가 쓰레기를 버렸나봐요.. 쓰레기가 ...'),
                          ],
                        ),
                        Center(
                          child: Icon(
                            Icons.more_horiz,
                          ),
                        ),
                        Text('게시물을 클릭하면 자세한 확인이 가능합니다.'),
                        SizedBox(
                          height: 10,
                        )
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
                Text('각종 쓰레기가 너무 많습니다.'),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// AppBar부분 구현 함수
PreferredSize renderAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(64),
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff7091CF),
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
          icon: const Icon(Icons.person),
          tooltip: '마이페이지',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: '설정',
          onPressed: () {},
        )
      ],
    ),
  );
}

class IsCheckedboxExample extends StatefulWidget {
  const IsCheckedboxExample({super.key});

  @override
  State<IsCheckedboxExample> createState() => _IsCheckedboxExampleState();
}

class _IsCheckedboxExampleState extends State<IsCheckedboxExample> {
  bool isChecked = true;

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
