import 'package:flutter/material.dart';
import 'package:wave/widgets/myAppBar.dart';

/* Post_Screen에서 등록하기 버튼 눌렀을 때 나오는 신고한 내용 */

class MyPosted extends StatefulWidget {
  const MyPosted({Key? key}) : super(key: key);

  @override
  State<MyPosted> createState() => _MyPostedState();
}

class _MyPostedState extends State<MyPosted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '신고한 내용'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Row(
              children: [
                const SizedBox(width: 20),
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF5D184),
                  ),
                  child: IconButton(
                    iconSize: 40,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '김크림',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '대한민국 : 강릉',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('게시물 제목')),
                  DataColumn(label: Text('쓰레기를 치워주세요!!')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('게시물 내용')),
                    DataCell(Text('강문해변에 알 수 없는 쓰레기 무덤🦈')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('위치 분류')),
                    DataCell(Text('강문해변')),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/detect_after.png',
                      width: 220,
                      height: 220,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    '업로드한 이미지',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
