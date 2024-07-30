import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_list_item.dart';
import '../widgets/reading_progress_chart.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({Key? key}) : super(key: key);

  @override
  _MyLibraryScreenState createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  // 사용자의 책 목록을 저장하는 리스트
  final List<Book> _userBooks = [
    Book(id: '1', title: '1984', author: 'George Orwell', genre: '소설', rating: 5, isRead: true),
    Book(id: '2', title: '햄릿', author: '윌리엄 셰익스피어', genre: '희곡', rating: 4, isRead: true),
    Book(id: '3', title: '사피엔스', author: '유발 하라리', genre: '역사', rating: 5, isRead: false),
    Book(id: '4', title: '데미안', author: '헤르만 헤세', genre: '소설', rating: 4, isRead: true),
    Book(id: '5', title: '침묵의 봄', author: '레이첼 카슨', genre: '과학', rating: 5, isRead: false),
  ];

  // 현재 선택된 필터 (전체, 읽은 책, 읽고 있는 책)
  String _currentFilter = '전체';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 서재'),
        actions: [
          // 책 추가 버튼
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 책 추가 기능 구현
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 독서 진행 상황 차트
          ReadingProgressChart(readBooks: _userBooks.where((book) => book.isRead).length),

          // 필터 버튼들
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('전체'),
                _buildFilterButton('읽은 책'),
                _buildFilterButton('읽고 있는 책'),
              ],
            ),
          ),

          // 책 목록
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredBooks().length,
              itemBuilder: (context, index) {
                final book = _getFilteredBooks()[index];
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
    );
  }

  // 필터 버튼 위젯을 생성하는 메서드
  Widget _buildFilterButton(String filter) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: _currentFilter == filter ? Colors.blue : Colors.grey,
      ),
      child: Text(filter),
      onPressed: () {
        setState(() {
          _currentFilter = filter;
        });
      },
    );
  }

  // 현재 필터에 따라 책 목록을 필터링하는 메서드
  List<Book> _getFilteredBooks() {
    switch (_currentFilter) {
      case '읽은 책':
        return _userBooks.where((book) => book.isRead).toList();
      case '읽고 있는 책':
        return _userBooks.where((book) => !book.isRead).toList();
      default:
        return _userBooks;
    }
  }
}