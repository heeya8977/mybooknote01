// user.dart

import 'package:flutter/foundation.dart';
import 'book.dart';

/// 사용자 정보를 나타내는 모델 클래스
class User {
  /// 사용자의 고유 식별자
  final String id;

  /// 사용자 이름
  final String name;

  /// 이메일 주소
  final String email;

  /// 프로필 이미지 URL
  String? profileImageUrl;

  /// 연간 독서 목표
  int yearlyReadingGoal;

  /// 선호하는 장르 목록
  List<String> preferredGenres;

  /// 읽은 책 목록
  List<Book> readBooks;

  /// 현재 읽고 있는 책 목록
  List<Book> currentlyReadingBooks;

  /// User 클래스 생성자
  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.yearlyReadingGoal = 0,
    this.preferredGenres = const [],
    this.readBooks = const [],
    this.currentlyReadingBooks = const [],
  });

  /// JSON 데이터로부터 User 객체를 생성하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      yearlyReadingGoal: json['yearlyReadingGoal'] as int? ?? 0,
      preferredGenres: (json['preferredGenres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      readBooks: (json['readBooks'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      currentlyReadingBooks: (json['currentlyReadingBooks'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  /// User 객체를 JSON 형태로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'yearlyReadingGoal': yearlyReadingGoal,
      'preferredGenres': preferredGenres,
      'readBooks': readBooks.map((book) => book.toJson()).toList(),
      'currentlyReadingBooks':
      currentlyReadingBooks.map((book) => book.toJson()).toList(),
    };
  }

  /// User 객체의 복사본을 생성하는 메서드
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    int? yearlyReadingGoal,
    List<String>? preferredGenres,
    List<Book>? readBooks,
    List<Book>? currentlyReadingBooks,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      yearlyReadingGoal: yearlyReadingGoal ?? this.yearlyReadingGoal,
      preferredGenres: preferredGenres ?? this.preferredGenres,
      readBooks: readBooks ?? this.readBooks,
      currentlyReadingBooks: currentlyReadingBooks ?? this.currentlyReadingBooks,
    );
  }

  /// User 객체의 문자열 표현을 반환하는 메서드
  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, yearlyReadingGoal: $yearlyReadingGoal)';
  }


  /// User 객체의 동등성을 비교하는 메서드
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          profileImageUrl == other.profileImageUrl &&
          yearlyReadingGoal == other.yearlyReadingGoal &&
          preferredGenres == other.preferredGenres &&
          readBooks == other.readBooks &&
          currentlyReadingBooks == other.currentlyReadingBooks;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      profileImageUrl.hashCode ^
      yearlyReadingGoal.hashCode ^
      preferredGenres.hashCode ^
      readBooks.hashCode ^
      currentlyReadingBooks.hashCode;
}