// api 관련 처리하는 클래스

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wave/models/temp_webtoon_model.dart';
import 'package:wave/models/post_model.dart';
import 'package:wave/models/login_model.dart';

class ApiService {
  // url
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev"; // fake api - 임시
  static const String today = "today";
  // static const String reports = "posts/list"; // 실제 api path

  //  Future<List<WebtoonModel>> ->   Future<List<ReportPostModel>>
  static Future<List<WebtoonModel>> getReports() async {
    // 임시
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body); // 임시

      // 확인용 코드
      for (var w in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(w));
      }
      return webtoonInstances;

      // REAL -> 조금의 수정 필요. future 등
      // List<ReportPostModel> reportpostInstances = [];
      // final url = Uri.parse('$baseUrl/$reports');
      // final response = await http.get(url);
      // final List<dynamic> reportposts = jsonDecode(response.body);
      // for (var reportpost in reportposts) {
      //   final report = ReportPostModel.fromJson(reportpost);
      //   reportpostInstances.add(ReportPostModel.fromJson(reportpost));
      //   print(report.subject); // 제목 출력해보기
      // }
      // return reportpostInstances;
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
