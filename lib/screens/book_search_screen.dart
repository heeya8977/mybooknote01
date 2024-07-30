import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_search_service.dart';
import '../widgets/book_list_item.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({Key? key}) : super(key: key);

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final BookSearchService _bookSearchService = BookSearchService();
  List<Book> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    // 컨트롤러 해제
    _searchController.dispose();
    super.dispose();
  }

  // 책 검색 함수
  Future<void> _searchBooks(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // BookSearchService를 사용하여 책 검색
      final results = await _bookSearchService.searchBooks(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      // 에러 처리
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('검색 중 오류가 발생했습니다: $e');
    }
  }

  // 에러 다이얼로그를 표시하는 함수
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('책 검색'),
      ),
      body: Column(
        children: [
          // 검색 입력 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '책 제목, 저자, ISBN을 입력하세요',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _searchBooks(_searchController.text);
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _searchBooks(value);
                }
              },
            ),
          ),
          // 검색 결과 또는 로딩 인디케이터
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                ? const Center(child: Text('검색 결과가 없습니다.'))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final book = _searchResults[index];
                return BookListItem(
                  book: book,
                  onTap: () {
                    // TODO: 책 상세 정보 페이지로 이동
                  },
                );
              },
            ),
          ),
        ],
      ),
      // 카메라를 이용한 책 검색 기능 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 카메라를 이용한 책 검색 기능 구현
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}