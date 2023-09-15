class PostModel {
  final String subject;
  final String content;
  //final String imageKey;
  final String address;
  final String userId;

  PostModel({
    required this.subject,
    required this.content,
    //required this.imageKey,
    required this.address,
    required this.userId,
  });

  // copyWith 메서드 정의
  PostModel copyWith({
    String? subject,
    String? content,
    //String? imageKey,
    String? address,
    String? userId,
  }) {
    return PostModel(
      subject: subject ?? this.subject,
      content: content ?? this.content,
      //imageKey: imageKey ?? this.imageKey,
      address: address ?? this.address,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'content': content,
      //'image_key': imageKey,
      'address': address,
      'user_id': userId,
    };
  }
}


// class PostModel {
//   final String title;
//   final String content;
//   //final List<String> imagePaths; // 이미지 파일 경로 list
//   final String location;

//   PostModel({
//     required this.title,
//     required this.content,
//     //required this.imagePaths,
//     required this.location,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'content': content,
//       //'image_paths': imagePaths,
//       'location': location,
//     };
//   }
// }
