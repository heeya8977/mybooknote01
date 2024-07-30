// book_item.dart

import 'package:flutter/material.dart';
import '../models/book.dart';

/// 책 정보를 표시하는 위젯
class BookItem extends StatelessWidget {
  /// 표시할 책 정보
  final Book book;

  /// 책 아이템 탭 시 호출될 콜백 함수
  final VoidCallback? onTap;

  /// BookItem 위젯 생성자
  const BookItem({
    Key? key,
    required this.book,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 책 표지 이미지
              Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(book.coverUrl ??
                        'https://via.placeholder.com/80x120?text=No+Cover'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              // 책 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.genre,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 8),
                    // 평점 표시
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < book.rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          );
                        }),
                        const SizedBox(width: 4),
                        Text(
                          '(${book.rating}/5)',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 사용 예시
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 Book 객체
    final exampleBook = Book(
      id: '1',
      title: '1984',
      author: 'George Orwell',
      genre: '소설',
      coverUrl: 'https://example.com/1984-cover.jpg',
      rating: 4,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Book Item Example')),
      body: Center(
        child: BookItem(
          book: exampleBook,
          onTap: () {
            print('Book tapped: ${exampleBook.title}');
            // 여기에 책 상세 정보 페이지로 이동하는 로직을 추가할 수 있습니다.
          },
        ),
      ),
    );
  }
}