import 'package:flutter/material.dart';

//신고하기
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String dropdownValue = '선택 안 함';
  List<String> itemList = [
    '선택 안 함',
    '강릉',
    '강문해변',
    '인천',
    '동막해변',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
        toolbarHeight: 80.0,
        title: const Text(
          '신고 등록하기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            height: 1.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black38,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            Container(
              margin: const EdgeInsets.only(right: 280),
              child: const Text(
                '게시물 제목 *',
                style: TextStyle(
                  color: Color(0xff545454),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const TextField(
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffA9A9A9),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              margin: const EdgeInsets.only(right: 280),
              child: const Text(
                '게시물 내용 *',
                style: TextStyle(
                  color: Color(0xff545454),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '게시물 내용을 작성해주세요:)',
                  hintStyle: TextStyle(
                    color: Color(0xffD9D9D9),
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(height: 70.0),
            Container(
              margin: const EdgeInsets.only(right: 300),
              child: const Text(
                '위치 분류',
                style: TextStyle(
                  color: Color(0xff545454),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 13.0,
                ),
                child: const Divider(
                  color: Color(0xffA9A9A9),
                  height: 1.0,
                )),
            const SizedBox(height: 30.0),
            Container(
              margin: const EdgeInsets.only(right: 300),
              child: const Text(
                '첨부 파일',
                style: TextStyle(
                  color: Color(0xff545454),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xffD9D9D9),
                  ),
                  child: const Icon(
                    Icons.photo_camera,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xffD9D9D9),
                  ),
                  child: const Icon(
                    Icons.photo_camera,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xffD9D9D9),
                  ),
                  child: const Icon(
                    Icons.photo_camera,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 0,
              ),
              child: const Text(
                '이미지 파일(GIF, PNG, JPG)를 기준으로 최대 \n10MB이하 최대 3개까지 첨부 가능합니다.',
                style: TextStyle(
                  color: Color(0xffD9D9D9),
                  fontSize: 14,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 13.0,
                ),
                child: const Divider(
                  color: Color(0xffA9A9A9),
                  height: 1.0,
                )),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xffD9D9D9),
                    foregroundColor: const Color(0xff000000),
                  ),
                  child: const Text('   취소   '),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xffF5D184),
                    foregroundColor: const Color(0xff000000),
                  ),
                  child: const Text('등록하기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
