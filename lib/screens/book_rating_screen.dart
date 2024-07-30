import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'home_screen.dart';

class BookRatingScreen extends StatefulWidget {
  final List<String> selectedGenres;
  final int targetBooks;

  // 생성자: 선택된 장르와 목표 독서 권수를 받아옵니다.
  const BookRatingScreen({
    Key? key,
    required this.selectedGenres,
    required this.targetBooks,
  }) : super(key: key);

  @override
  _BookRatingScreenState createState() => _BookRatingScreenState();
}

class _BookRatingScreenState extends State<BookRatingScreen> {
  late List<Book> recommendedBooks;
  final BookService _bookService = BookService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendedBooks();
  }

  // 추천 도서를 불러오는 비동기 함수
  Future<void> _loadRecommendedBooks() async {
    try {
      // BookService를 통해 추천 도서 목록을 가져옵니다.
      recommendedBooks = await _bookService.getRecommendedBooks(widget.selectedGenres);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // 오류 발생 시 처리
      print('Error loading recommended books: $e');
      setState(() {
        _isLoading = false;
        recommendedBooks = []; // 빈 리스트로 초기화
      });
      _showErrorDialog();
    }
  }

  // 오류 발생 시 표시할 다이얼로그
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류'),
          content: const Text('추천 도서를 불러오는 데 실패했습니다. 다시 시도해 주세요.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('책 평가'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: recommendedBooks.length,
        itemBuilder: (context, index) {
          final book = recommendedBooks[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (starIndex) {
                  return IconButton(
                    icon: Icon(
                      starIndex < book.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        book.rating = starIndex + 1;
                      });
                      // 여기서 평점 업데이트 및 새로운 추천 책 가져오기 로직 추가 가능
                    },
                  );
                }),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          // 홈 화면으로 이동
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                selectedGenres: widget.selectedGenres,
                targetBooks: widget.targetBooks,
                ratedBooks: recommendedBooks,
              ),
            ),
                (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }
}