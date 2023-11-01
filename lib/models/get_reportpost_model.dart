class ReportPostModel {
  final String address, content, created_date, image_key, subject;
  final String? modified_date, processed_date;
  final int id, reporter_id;

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
