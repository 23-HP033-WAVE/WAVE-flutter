import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/models/post_model.dart';

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
    '서울',
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  //List<String> selectedImages = []; // 갤러리에서 선택한 이미지 경로 저장용 list

  Future<void> _uploadPost(PostModel postModel) async {
    final url =
        Uri.parse('https://jsonplaceholder.typicode.com/posts'); //주소 수정해

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postModel.toJson()),
    );

    if (response.statusCode == 200) {
      //post 성공 시
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('게시물이 성공적으로 등록되었습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
      // 성공 시 다른 화면 이동 필요
    } else {
      // post 실패 시
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('게시물 등록에 실패했습니다. 다시 시도해주세요.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  /*Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        selectedImages.add(pickedFile.path);
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: TextField(
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffA9A9A9),
                    ),
                  ),
                ),
                controller: titleController,
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
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '게시물 내용을 작성해주세요 :)',
                  hintStyle: TextStyle(
                    color: Color(0xffD9D9D9),
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                controller: contentController,
              ),
            ),
            const SizedBox(height: 70.0),
            Container(
              margin: const EdgeInsets.only(right: 30, left: 20),
              child: Row(
                children: [
                  const Text(
                    '위치 분류 *',
                    style: TextStyle(
                      color: Color(0xff545454),
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: itemList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
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
                '첨부 파일 *',
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
                GestureDetector(
                  onTap: () {
                    //_pickImage(ImageSource.gallery); // 갤러리에서 이미지 선택하기
                  },
                  child: Container(
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
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //_pickImage(ImageSource.gallery);
                  },
                  child: Container(
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
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //_pickImage(ImageSource.gallery);
                  },
                  child: Container(
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
                  onPressed: () {
                    // 동작 추가하기!
                  },
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
                  onPressed: () {
                    final postModel = PostModel(
                      title: titleController.text,
                      content: contentController.text,
                      //imagePaths: selectedImages,
                      location: dropdownValue,
                    );
                    _uploadPost(postModel);
                  },
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
