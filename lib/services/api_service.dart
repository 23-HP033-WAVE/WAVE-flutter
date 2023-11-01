// api 관련 처리하는 클래스

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wave/models/get_reportpost_model.dart';
import 'package:wave/models/post_model.dart';
import 'package:wave/models/login_model.dart';

class ApiService {
  static const String baseUrl = "http://3.39.112.66:5000";
  static const String reports = "posts/list";
  static Future<List<ReportPostModel>> getReports() async {
    List<ReportPostModel> reportInstances = [];
    final url = Uri.parse("$baseUrl/$reports");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> reportposts =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var reportpost in reportposts) {
        reportInstances.add(ReportPostModel.fromJson(reportpost));
      }
      print(reportInstances.runtimeType);
      return reportInstances;
    }
    throw Error();
  }

  static const String apiUrl =
      'https://jsonplaceholder.typicode.com/albums/1'; // 주소 변경 필요

  // Upload Post
  static Future<bool> uploadPost(PostModel postModel) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postModel.toJson()),
    );
    return response.statusCode == 200;
  }

  //로그인
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('https://어쩌구 저쩌구/login');
    final loginModel = LoginModel(username: username, password: password);

    final response = await http.post(
      url,
      body: jsonEncode(loginModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final status = responseData['status'];
      if (status == 'success') {
        // 로그인 성공
        return true;
      } else {
        // 로그인 실패
        return false;
      }
    } else {
      // 서버 오류
      throw Exception('서버 오류: ${response.statusCode}');
    }
  }
}
