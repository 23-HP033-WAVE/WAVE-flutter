import 'package:flutter/material.dart';
import 'package:wave/screen/home_screen.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appbar 그림자 0으로 제거
          shape: const Border(
            bottom: BorderSide(
              color: Color(0xff545454),
              width: 1,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff545454),
            ),
            onPressed: () {},
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0),
              const Center(
                child: Text(
                  '신고 목록',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 52),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 48, // 이미지의 너비 설정
                    height: 48, // 이미지의 높이 설정
                  ),
                  const SizedBox(width: 12), // 아이콘과 검색 필드 사이의 간격
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        // 검색 필드
                        decoration: InputDecoration(
                          hintText: '쓰레기 종류나 지역을 검색해보세요!',
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // 검색 버튼을 눌렀을 때의 동작 추가
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                '현재 진행 중',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
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
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '최근 해결된 건',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                  Text("전체 보기 >"),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // child: ,
                  ),
                ],
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CheckboxExample(),
                            Text('경포해변 유리 조각에 다칠뻔 했어요ㅜㅜ'),
                          ],
                        ),
                        Row(
                          children: [
                            CheckboxExample(),
                            Text('알 수 없는, 산소통이 해변가에 있어요!'),
                          ],
                        ),
                        Row(
                          children: [
                            CheckboxExample(),
                            Text('작은 어선 주위로 기름 쓰레기 확인부탁...'),
                          ],
                        ),
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
