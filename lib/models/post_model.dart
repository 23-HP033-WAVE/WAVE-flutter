class PostModel {
  final String subject;
  final String content;
  final String imageKey;
  final String address;
  final String user_id;

  PostModel({
    required this.subject,
    required this.content,
    required this.imageKey,
    required this.address,
    required this.user_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'content': content,
      'image_key': imageKey,
      'address': address,
      'user_id': user_id,
    };
  }
}
