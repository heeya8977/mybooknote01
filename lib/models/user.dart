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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profileImageUrl == profileImageUrl &&
        other.yearlyReadingGoal == yearlyReadingGoal &&
        listEquals(other.preferredGenres, preferredGenres) &&
        listEquals(other.readBooks, readBooks) &&
        listEquals(other.currentlyReadingBooks, currentlyReadingBooks);
  }

  /// User 객체의 해시코드를 생성하는 메서드
  @override
  int get hashCode {
    return hashValues(
      id,
      name,
      email,
      profileImageUrl,
      yearlyReadingGoal,
      Object.hashAll(preferredGenres),
      Object.hashAll(readBooks),
      Object.hashAll(currentlyReadingBooks),
    );
  }
}

// 예시 코드
void main() {
  // 새로운 User 객체 생성
  var myUser = User(
    id: '1',
    name: '홍길동',
    email: 'hong@example.com',
    yearlyReadingGoal: 20,
    preferredGenres: ['소설', '역사', '과학'],
  );

  print('새로 생성된 사용자: $myUser');

  // JSON 데이터로부터 User 객체 생성
  var jsonData = {
    'id': '2',
    'name': '김철수',
    'email': 'kim@example.com',
    'yearlyReadingGoal': 30,
    'preferredGenres': ['판타지', '미스터리'],
    'readBooks': [
      {
        'id': '1',
        'title': '해리 포터',
        'author': 'J.K. 롤링',
        'genre': '판타지',
      }
    ],
  };
  var userFromJson = User.fromJson(jsonData);

  print('JSON에서 생성된 사용자: $userFromJson');

  // User 객체 수정
  var updatedUser = myUser.copyWith(
    yearlyReadingGoal: 25,
    profileImageUrl: 'https://example.com/profile.jpg',
  );

  print('수정된 사용자: $updatedUser');

  // User 객체를 JSON으로 변환
  var userJson = updatedUser.toJson();
  print('JSON으로 변환된 사용자: $userJson');

  // 두 User 객체 비교
  print('원본 사용자와 수정된 사용자가 같은가? ${myUser == updatedUser}');
}