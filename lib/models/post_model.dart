/* 백엔드 API 보고 변수명 바꾸기! */

class PostModel {
  final String title;
  final String content;
  //final List<String> imagePaths; // 이미지 파일 경로 list
  final String location;

  PostModel({
    required this.title,
    required this.content,
    //required this.imagePaths,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      //'image_paths': imagePaths,
      'location': location,
    };
  }
}
