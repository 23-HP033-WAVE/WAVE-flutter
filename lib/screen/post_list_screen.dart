import 'package:flutter/material.dart';
import 'package:wave/models/temp_webtoon_model.dart';
import 'package:wave/screen/post_detail.dart';
import 'package:wave/screen/search_screen.dart';
import 'package:wave/services/api_service.dart';
import 'package:wave/widgets/my_appbar.dart';

class PostList extends StatelessWidget {
  PostList({Key? key}) : super(key: key);

  // 임시
  Future<List<WebtoonModel>> webtoons = ApiService.getReports();
  // REAL
  // Future<List<ReportPostModel>> reportposts = ApiService.getReports();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '신고 목록'),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // futurebuilder와 비슷하지만 index로 요소에 접근함.
                  var webtoon = snapshot.data![index];
                  return Text(webtoon.title);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
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
}

// 리팩토링 이전  위젯
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
