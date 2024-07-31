// book.dart

import 'package:flutter/foundation.dart';

/// 책 정보를 나타내는 모델 클래스
class Book {
  /// 책의 고유 식별자
  final String id;

  /// 책 제목
  final String title;

  /// 저자
  final String author;

  /// 장르
  final String genre;

  /// 책 표지 이미지 URL
  final String? coverUrl;

  /// 사용자의 평점 (0-5)
  int rating;

  /// 읽음 여부
  bool isRead;

  /// 완독 날짜
  DateTime? dateCompleted;

  /// ISBN (국제 표준 도서 번호)
  final String? isbn;

  /// 출판사
  final String? publisher;

  /// 출판일
  final DateTime? publishDate;

  /// 책 설명
  final String? description;

  /// Book 클래스 생성자
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.coverUrl,
    this.rating = 0,
    this.isRead = false,
    this.dateCompleted,
    this.isbn,
    this.publisher,
    this.publishDate,
    this.description,
  });

  /// JSON 데이터로부터 Book 객체를 생성하는 팩토리 생성자
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      genre: json['genre'] as String,
      coverUrl: json['coverUrl'] as String?,
      rating: json['rating'] as int? ?? 0,
      isRead: json['isRead'] as bool? ?? false,
      dateCompleted: json['dateCompleted'] != null
          ? DateTime.parse(json['dateCompleted'] as String)
          : null,
      isbn: json['isbn'] as String?,
      publisher: json['publisher'] as String?,
      publishDate: json['publishDate'] != null
          ? DateTime.parse(json['publishDate'] as String)
          : null,
      description: json['description'] as String?,
    );
  }

  /// Book 객체를 JSON 형태로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'coverUrl': coverUrl,
      'rating': rating,
      'isRead': isRead,
      'dateCompleted': dateCompleted?.toIso8601String(),
      'isbn': isbn,
      'publisher': publisher,
      'publishDate': publishDate?.toIso8601String(),
      'description': description,
    };
  }

  /// Book 객체의 복사본을 생성하는 메서드
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? genre,
    String? coverUrl,
    int? rating,
    bool? isRead,
    DateTime? dateCompleted,
    String? isbn,
    String? publisher,
    DateTime? publishDate,
    String? description,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      coverUrl: coverUrl ?? this.coverUrl,
      rating: rating ?? this.rating,
      isRead: isRead ?? this.isRead,
      dateCompleted: dateCompleted ?? this.dateCompleted,
      isbn: isbn ?? this.isbn,
      publisher: publisher ?? this.publisher,
      publishDate: publishDate ?? this.publishDate,
      description: description ?? this.description,
    );
  }

  /// Book 객체의 문자열 표현을 반환하는 메서드
  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, genre: $genre)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          author == other.author &&
          genre == other.genre &&
          coverUrl == other.coverUrl &&
          rating == other.rating &&
          isRead == other.isRead &&
          dateCompleted == other.dateCompleted &&
          isbn == other.isbn &&
          publisher == other.publisher &&
          publishDate == other.publishDate &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      author.hashCode ^
      genre.hashCode ^
      coverUrl.hashCode ^
      rating.hashCode ^
      isRead.hashCode ^
      dateCompleted.hashCode ^
      isbn.hashCode ^
      publisher.hashCode ^
      publishDate.hashCode ^
      description.hashCode;
}
