import 'package:flutter/material.dart';
import 'package:wave/models/temp_webtoon_model.dart';
import 'package:wave/screen/home_screen.dart';
import 'package:wave/screen/my_posted_screen.dart';
import 'package:wave/screen/post_detail.dart';
import 'package:wave/screen/search_screen.dart';
import 'package:wave/services/api_service.dart';
import 'package:wave/widgets/appbar_with_back.dart';

// 빠른 개발을 위해 post_list_screen 복붙 후 수정함 .. 코드 더러움 ㅠㅠ//

class MyPostList extends StatelessWidget {
  MyPostList({Key? key}) : super(key: key);

  // 임시
  Future<List<WebtoonModel>> webtoons = ApiService.getReports();
  // REAL
  // Future<List<ReportPostModel>> reportposts = ApiService.getReports();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '나의 신고 목록'),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchField(),
                  const SizedBox(
                    height: 22,
                  ),
                  // const Text(
                  //   '최근 게시물',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 20,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(child: makeList(snapshot)),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    var counter = 0; // 이미지 접근을 위한 변수
    // 신고 게시물 더미 데이터
    List<Map<String, dynamic>> reportlist = [
      {
        "post_id": 2,
        "title": "쓰레기를 치워주세요!!",
        "content": "강문해변에 알 수 없는 쓰레기 무덤",
        "date": "2023.09.16",
        "작성자": "김크림",
        "처리 전 사진": ""
      },
      {
        "post_id": 3,
        "title": "포항 구룡포 해변",
        "content": "스티로폼과 플라스틱, 이상한 쓰레기들이 많이 있어요",
        "date": "2023.07.22",
        "작성자": "둘기맘",
        "처리 전 사진": ""
      },
      {
        "post_id": 4,
        "title": "포항 도구해수욕장",
        "content": "이상한 플라스틱 쓰레기가 많이 있어서 잘못 밟을 뻔 했어요",
        "date": "2023.07.23",
        "작성자": "둘기맘",
        "처리 전 사진": ""
      },
      {
        "post_id": 5,
        "title": "포항 오도리 해안",
        "content": "쓰레기가 엄청 많이 있어요.",
        "date": "2023.07.23",
        "작성자": "둘기맘",
        "처리 전 사진": ""
      },
      {
        "post_id": 6,
        "title": "포항 임곡리 해안",
        "content": "플라스틱에 발이 찔릴 뻔 했어요",
        "date": "2023.07.24",
        "작성자": "둘기맘",
        "처리 전 사진": ""
      },
      {
        "post_id": 7,
        "title": "포항 지경리 해안",
        "content": "이상한 쓰레기들이 많이 있어요",
        "date": "2023.07.25",
        "작성자": "둘기맘",
        "처리 전 사진": ""
      }
    ];
    // var reportlist = jsonDecode(jsonReportpost);
    // print(reportlist is List);

    return ListView.separated(
      // itemCount: snapshot.data!.length, // 데이터 받아올때 코드
      itemCount: 1, // 임시
      itemBuilder: (context, index) {
        // futurebuilder와 비슷하지만 index로 요소에 접근함.
        // var webtoon = snapshot.data![index]; // 임시

        counter += 1;
        return Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/images/detect_after.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const MyPosted())),
              child: SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          reportlist[0]["title"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const CheckboxExample(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        reportlist[0]["content"],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 109, 109, 109),
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ), // 임시
                    Text(
                      '게시 일자: ${reportlist[0]["date"]}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ), // 임시
                    Text(
                      '작성자: ${reportlist[0]["작성자"]}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ), // 임시
                  ],
                ),
              ),
            ), // 임시

            // Text(reportlist[index]["title"]) // 에러 이유 모르겠음
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 14,
      ),
    );
  }
}

////// 리팩토링 이전 위젯
class TempColumn extends StatelessWidget {
  const TempColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchField(),
        SizedBox(
          height: 18,
        ),
        Text(
          '최근 게시물',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                PostPreview(),
              ],
            )
          ],
        )
      ],
    );
  }
}

class PostPreview extends StatelessWidget {
  const PostPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              'assets/images/trash.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.fill,
            ),
          ),
          // Container(
          //   width: 100.0, // 원하는 박스의 너비
          //   height: 100.0, // 원하는 박스의 높이
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 1.0, color: Colors.black),
          //     borderRadius:
          //         BorderRadius.circular(20.0), // 원하는 border radius 값으로 설정
          //   ),
          //   child: Image.asset(
          //     'assets/images/trash.png', // 이미지 경로를 수정해야 합니다.
          //     fit: BoxFit.cover, // 이미지를 박스 크기에 꽉 차게 조절
          //   ),
          // ),
          // 요 아래 놈들이 원래 Expanded로 둘러싸였고 +flex속성값까지 있었음
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const PostDetail())),
            child: Container(
              width: 230,
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '강릉 경포 해변',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '경포해변 유리조각에 다칠 뻔 했어요.',
                    style: TextStyle(fontSize: 16.0),
                    softWrap: true,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '촬영 일자: 2023-09-17', // 촬영 일자를 원하는 형식으로 수정하세요.
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}