import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/models/post_model.dart';
import 'package:uuid/uuid.dart';
import 'package:wave/widgets/myAppBar.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String dropdownValue = '선택 안 함'; // 드롭다운 메뉴 기본값
  List<String> itemList = [
    '선택 안 함',
    '강릉',
    '강문해변',
    '인천',
    '동막해변',
    '서울',
  ];

  TextEditingController subjectController = TextEditingController(); // 제목
  TextEditingController contentController = TextEditingController(); // 내용
  TextEditingController imageKeyController = TextEditingController(); // 이미지
  TextEditingController addressController = TextEditingController(); // 주소

  // 임시 사용자 ID 생성
  // 로그인을 안 만들었으니까.. 이걸로 UserID 대신 사용 (랜덤 값 기반인 v4가 제일 많이 사용된다 함)
  String temporaryUserId = const Uuid().v4();

  // 갤러리에서 선택한 이미지 경로 저장용 list
  List<String> selectedImages = [];

  // 이미지 선택 후 표시 위해 생성
  Image? selectedImage;

  // 이미지 선택하기!
  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      // 이미지를 선택하면 경로를 컨트롤러에 설정
      imageKeyController.text = pickedFile.path;

      setState(() {
        selectedImage = Image.file(File(pickedFile.path));
      });
    }
  }

  Future<void> _uploadPost(PostModel postModel) async {
    final url =
        Uri.parse('http://127.0.0.1:5000/posts/create'); // 백엔드 API 주소로 변경하기!!

    // 임시 사용자 ID -> postModel에 추가 위해서 copyWith사용
    postModel = postModel.copyWith(userId: temporaryUserId);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postModel.toJson()),
    );

    if (response.statusCode == 200) {
      // Post 성공 시
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('게시물이 성공적으로 등록되었습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
      // 등록 성공 시 다른 화면 이동 필요!!
    } else {
      // Post 실패 시
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('게시물 등록에 실패했습니다. 다시 시도해주세요.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '신고 등록하기'),
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
                controller: subjectController,
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
                    _pickImage(ImageSource.gallery); // 갤러리에서 이미지 선택가능
                  },
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Color(0xffD9D9D9),
                    ),
                    child:
                        imageKeyController.text.isNotEmpty // 이미지 경로가 비어있지 않으면
                            ? Image.file(
                                // 선택된 이미지 표시
                                File(imageKeyController.text),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
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
                '이미지 파일(GIF, PNG, JPG)를 기준으로 \n최대 10MB 이하만 첨부 가능합니다.',
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
                    // 취소 버튼 동작 추가하기!
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
                      subject: subjectController.text,
                      content: contentController.text,
                      imageKey: imageKeyController.text,
                      address: dropdownValue,
                      userId: temporaryUserId,
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
