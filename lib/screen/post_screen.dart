import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/models/post_model.dart';
import 'package:uuid/uuid.dart';
import 'package:wave/widgets/appbar_without_back.dart';
import 'package:wave/screen/my_posted_screen.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

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
    '서울',
    '인천',
    '강문해변',
    '동막해변',
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

  // 이미지 선택 후 화면에 표시 위해서 생성
  Image? selectedImage;

  // 임시 더미데이터 (모델 분류 결과) 보여주기 위해
  // 이미지 변경 여부를 나타내는 변수
  bool isResultImageVisible = false;
  // CircularProgressIndicator 사용 위해
  bool isLoading = false;

  // 이미지 선택하기
  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      // 이미지를 선택하면 그 경로를 컨트롤러에 설정
      imageKeyController.text = pickedFile.path;

      setState(() {
        selectedImage = Image.file(File(pickedFile.path));
      });
    }
  }

  Future<void> _uploadPost(PostModel postModel) async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/1'); // 백엔드 API 주소로 변경하기!! http://127.0.0.1:5000/posts/create

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
          content: Text('게시물이 성공적으로 등록되었습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // "쓰레기 분류하기" 버튼을 눌렀을 때 호출되는 함수
  void _classifyTrash() {
    setState(() {
      isResultImageVisible = false; // 딜레이 동안 결과 숨기기 (false로 해서)
      isLoading = true; // 로딩 상태 시작
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isResultImageVisible = true; // 결과 다시 표시
        isLoading = false; // 로딩 상태 종료
      });
    });
  }

  // 등록하기 버튼을 눌렀을 때 화면 전환
  void _registerScreen() {
    final postModel = PostModel(
      subject: subjectController.text,
      content: contentController.text,
      imageKey: imageKeyController.text,
      address: dropdownValue,
      userId: temporaryUserId,
    );
    _uploadPost(postModel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyPosted(), // 내가 신고한 내용으로 바로 연결
      ),
    );
  }

  //addressController
  final TextEditingController _addressController = TextEditingController();

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
              margin: const EdgeInsets.symmetric(horizontal: 10),
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
            // Container(
            //   margin: const EdgeInsets.only(right: 20, left: 20),
            //   child: Row(
            //     children: [
            //       const Text(
            //         '위치 분류 * (old)',
            //         style: TextStyle(
            //           color: Color(0xff545454),
            //           fontSize: 16,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 50.0),
            //         child: DropdownButton<String>(
            //           value: dropdownValue,
            //           onChanged: (String? newValue) {
            //             setState(() {
            //               dropdownValue = newValue!;
            //             });
            //           },
            //           items: itemList
            //               .map<DropdownMenuItem<String>>((String value) {
            //             return DropdownMenuItem<String>(
            //               value: value,
            //               child: Text(value),
            //             );
            //           }).toList(),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  addressText(),
                ],
              ),
            ),
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
                    _pickImage(ImageSource.gallery); // 갤러리에서 이미지 선택
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: const BoxDecoration(
                      color: Color(0xffD9D9D9),
                    ),
                    child:
                        imageKeyController.text.isNotEmpty // 이미지 경로가 비어있지 않으면
                            ? Image.file(
                                // 선택된 이미지 표시
                                File(imageKeyController.text),
                                width: 170,
                                height: 170,
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
            ElevatedButton(
              onPressed: () {
                _classifyTrash(); // "쓰레기 분류하기" 버튼 클릭 시 딜레이 추가
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xffF5D184),
                foregroundColor: const Color(0xff000000),
              ),
              child: isLoading // 로딩 중인 3초 동안 CircularProgressIndicator 표시
                  ? const CircularProgressIndicator()
                  : const Text('쓰레기 분류하기'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.only(right: 300),
              child: const Text(
                '인식 결과',
                style: TextStyle(
                  color: Color(0xff545454),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              width: 240,
              height: 240,
              decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
              ),
              child:
                  isResultImageVisible // isResultImageVisible 값에 따라 결과 visibility 달라짐
                      ? Image.asset(
                          'assets/images/detect_after.png', // 더미데이터
                          width: 240,
                          height: 240,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            '위 버튼을 눌러 \n쓰레기 분류 결과를 확인해 보세요!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff545454),
                              fontSize: 13,
                            ),
                          ),
                        ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Visibility(
              visible:
                  isResultImageVisible, // isResultImageVisible이 true일 때만 보이도록 설정
              child: Center(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('종류')),
                    DataColumn(label: Text('개수')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('플라스틱')),
                      DataCell(Text('3건')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('기타')),
                      DataCell(Text('1건')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('스티로폼')),
                      DataCell(Text('1건')),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
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
                    _registerScreen();
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

  Widget addressText() {
    return GestureDetector(
      onTap: () {
        _addressAPI();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '위치 분류 *',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff545454),
            ),
          ),
          TextFormField(
            enabled: false,
            decoration: const InputDecoration(
              isDense: false,
              hintText: '클릭해서 주소를 찾아주세요!',
              hintStyle: TextStyle(
                color: Color(0xffD9D9D9),
              ),
            ),
            controller: _addressController,
            style: const TextStyle(fontSize: 15),
            maxLines: null,
          ),
        ],
      ),
    );
  }

  _addressAPI() async {
    KopoModel? model = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    if (model != null) {
      // 주소 선택을 하지 않고 뒤로가기를 할 경우 에러 나서 조건 추가
      _addressController.text =
          '${model.zonecode!} ${model.address!} ${model.buildingName!}';
    }
  }
}
