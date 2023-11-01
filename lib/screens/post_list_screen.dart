import 'package:flutter/material.dart';
import 'package:wave/models/get_reportpost_model.dart';
import 'package:wave/screens/home_screen.dart';
import 'package:wave/screens/post_detail.dart';
import 'package:wave/screens/search_screen.dart';
import 'package:wave/services/api_service.dart';
import 'package:wave/widgets/appbar_without_back.dart';

class PostList extends StatelessWidget {
  PostList({Key? key}) : super(key: key);

  Future<List<ReportPostModel>> reportposts = ApiService.getReports();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '신고 목록'),
      body: FutureBuilder(
        future: reportposts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SearchScreen())),
                    child: const SearchField(textenabled: false),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                    '최근 게시물',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(child: makeList(snapshot)),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ReportPostModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var counter = index + 1;
        return Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/images/thumb$counter.jpg',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const PostDetail())),
              child: SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          snapshot.data![index].subject,
                          // reportposts[index]
                          // reportlist[index]["title"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const IsCheckedboxExample(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        snapshot.data![index].content,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 109, 109, 109),
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Text(
                      '게시 일자: ${snapshot.data![index].created_date}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '작성자: ${snapshot.data![index].reporter_id}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 14,
      ),
    );
  }
}
