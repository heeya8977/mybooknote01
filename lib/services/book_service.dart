// book_service.dart

import 'dart:async';
import 'dart:math';
import '../models/book.dart';

/// 책 관련 서비스를 제공하는 클래스
class BookService {
  // 실제 앱에서는 이 부분이 데이터베이스나 API와 연결됩니다.
  final List<Book> _books = [
    Book(id: '1', title: '1984', author: 'George Orwell', genre: '소설'),
    Book(id: '2', title: '햄릿', author: '윌리엄 셰익스피어', genre: '희곡'),
    Book(id: '3', title: '사피엔스', author: '유발 하라리', genre: '역사'),
    Book(id: '4', title: '데미안', author: '헤르만 헤세', genre: '소설'),
    Book(id: '5', title: '침묵의 봄', author: '레이첼 카슨', genre: '과학'),
  ];

  /// 모든 책 목록을 가져오는 메서드
  Future<List<Book>> getAllBooks() async {
    // API 호출을 시뮬레이션하기 위해 지연을 추가합니다.
    await Future.delayed(Duration(seconds: 1));
    return _books;
  }

  /// 특정 ID의 책을 가져오는 메서드
  Future<Book?> getBookById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _books.firstWhere((book) => book.id == id, orElse: () => null as Book);
  }

  /// 새로운 책을 추가하는 메서드
  Future<void> addBook(Book book) async {
    await Future.delayed(Duration(milliseconds: 500));
    _books.add(book);
  }

  /// 책 정보를 업데이트하는 메서드
  Future<void> updateBook(Book updatedBook) async {
    await Future.delayed(Duration(milliseconds: 500));
    final index = _books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
    }
  }

  /// 책을 삭제하는 메서드
  Future<void> deleteBook(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    _books.removeWhere((book) => book.id == id);
  }

  /// 장르별로 책을 필터링하는 메서드
  Future<List<Book>> getBooksByGenre(String genre) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _books.where((book) => book.genre.toLowerCase() == genre.toLowerCase()).toList();
  }

  /// 책을 검색하는 메서드 (제목 또는 저자로 검색)
  Future<List<Book>> searchBooks(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    query = query.toLowerCase();
    return _books.where((book) =>
    book.title.toLowerCase().contains(query) ||
        book.author.toLowerCase().contains(query)).toList();
  }

  /// 추천 책 목록을 가져오는 메서드
  Future<List<Book>> getRecommendedBooks() async {
    await Future.delayed(Duration(seconds: 1));
    // 실제 앱에서는 사용자의 선호도, 독서 이력 등을 기반으로 추천 알고리즘을 구현해야 합니다.
    // 여기서는 간단히 랜덤으로 3권의 책을 선택합니다.
    final random = Random();
    return List.generate(3, (_) => _books[random.nextInt(_books.length)]);
  }
}

// 사용 예시
void main() async {
  final bookService = BookService();

  // 모든 책 가져오기
  final allBooks = await bookService.getAllBooks();
  print('모든 책: $allBooks');

  // ID로 책 가져오기
  final book = await bookService.getBookById('1');
  print('ID가 1인 책: $book');

  // 새 책 추가하기
  await bookService.addBook(Book(id: '6', title: '클린 코드', author: '로버트 C. 마틴', genre: '프로그래밍'));
  print('책 추가 후 모든 책: ${await bookService.getAllBooks()}');

  // 책 정보 업데이트하기
  await bookService.updateBook(Book(id: '1', title: '1984', author: 'George Orwell', genre: '소설', rating: 5));
  print('업데이트 후 ID가 1인 책: ${await bookService.getBookById('1')}');

  // 책 삭제하기
  await bookService.deleteBook('2');
  print('삭제 후 모든 책: ${await bookService.getAllBooks()}');

  // 장르별로 책 필터링하기
  final novelBooks = await bookService.getBooksByGenre('소설');
  print('소설 장르의 책들: $novelBooks');

  // 책 검색하기
  final searchResults = await bookService.searchBooks('george');
  print('검색 결과: $searchResults');

  // 추천 책 가져오기
  final recommendedBooks = await bookService.getRecommendedBooks();
  print('추천 책들: $recommendedBooks');
}