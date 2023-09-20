import 'package:flutter/material.dart';
import 'package:wave/widgets/myAppBar.dart';

/* 신고 게시물 상세 목록 */

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '신고 게시물 상세 목록'),
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
            const SizedBox(height: 20),
            // 데이터 테이블
            Center(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('비고')),
                  DataColumn(label: Text('내용')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('신고 장소')),
                    DataCell(Text('강릉')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('신고 내용')),
                    DataCell(Text('강문해변에 알 수 없는 쓰레기 무덤🦈')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('처리 기관')),
                    DataCell(Text('강릉시 강릉관광개발공사')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('처리 내용')),
                    DataCell(Text('신고 감사합니다. 처리 완료했습니다.😆')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('처리 날짜')),
                    DataCell(Text('2023.07.25')),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 처리 전 이미지와 텍스트
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/trash.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '처리 전',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/after_trash.png',
                        width: 180,
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '처리 후',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
