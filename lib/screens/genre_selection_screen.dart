import 'package:flutter/material.dart';
import 'book_rating_screen.dart';

class GenreSelectionScreen extends StatefulWidget {
  final int targetBooks;

  // 생성자: 목표 독서 권수를 받아옵니다.
  const GenreSelectionScreen({Key? key, required this.targetBooks}) : super(key: key);

  @override
  _GenreSelectionScreenState createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  // 장르 목록
  final List<String> genres = [
    '소설', '시', '에세이', '인문', '가정', '요리', '건강', '취미', '경제/경영',
    '자기계발', '정치/사회', '역사/문화', '종교', '예술', '기술', '외국어', '과학', '여행', '컴퓨터/IT'
  ];

  // 선택된 장르를 저장하는 Set
  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('장르 선택'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '좋아하는 장르를 선택해주세요 (최소 1개)',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final genre = genres[index];
                return CheckboxListTile(
                  title: Text(genre),
                  value: selectedGenres.contains(genre),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedGenres.add(genre);
                      } else {
                        selectedGenres.remove(genre);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: selectedGenres.isNotEmpty
            ? () {
          // 최소 1개 이상의 장르가 선택되었을 때 다음 화면으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookRatingScreen(
                selectedGenres: selectedGenres.toList(),
                targetBooks: widget.targetBooks,
              ),
            ),
          );
        }
            : null, // 선택된 장르가 없으면 버튼 비활성화
      ),
    );
  }
}