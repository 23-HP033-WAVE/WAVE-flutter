class ReportPostModel {
  final String address,
      content,
      created_date,
      id,
      image_key,
      modified_date,
      processed_date,
      reporter_id,
      subject;

  ReportPostModel.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        content = json['content'],
        created_date = json['created_date'],
        id = json['id'],
        image_key = json['image_key'],
        modified_date = json['modified_date'],
        processed_date = json['processed_date'],
        reporter_id = json['reporter_id'],
        subject = json['subject'];
}
