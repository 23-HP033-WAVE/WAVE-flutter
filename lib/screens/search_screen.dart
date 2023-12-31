import 'package:flutter/material.dart';
import 'package:wave/widgets/appbar_with_back.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(titleText: '신고 목록'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const SearchField(textenabled: true),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('최근 검색어'),
            ),
            const SizedBox(
              height: 18,
            ),
            // 리팩토링; row자체를 위젯으로 빼고 '최근 검색어 리스트'만 input으로 받도록 하기
            Row(
              children: [
                RecentSearchWidget(
                  searchText: '폐어구',
                  onDelete: () {
                    // Handle delete action
                    // print('Deleted');
                  },
                ),
                const SizedBox(width: 12),
                RecentSearchWidget(
                  searchText: '폐어망',
                  onDelete: () {
                    // Handle delete action
                    // print('Deleted');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecentSearchWidget extends StatelessWidget {
  final String searchText;
  final Function onDelete;

  const RecentSearchWidget(
      {super.key, required this.searchText, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            searchText,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          //
          SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              icon: const Icon(Icons.clear),
              style: const ButtonStyle(),
              onPressed: () {
                onDelete();
              },
              iconSize: 16,
              // padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.textenabled});
  final bool textenabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 48,
          height: 48,
        ),
        const SizedBox(width: 12), // 아이콘과 검색 필드 사이의 간격
        Expanded(
          child: SizedBox(
            height: 48,
            // error
            child: TextField(
              enabled: textenabled,
              autofocus: textenabled,
              textAlignVertical: TextAlignVertical.center,
              // 검색 필드
              decoration: InputDecoration(
                hintText: '쓰레기 종류나 지역을 검색해보세요!',
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // 검색 버튼을 눌렀을 때의 동작 추가
          },
        ),
      ],
    );
  }
}
