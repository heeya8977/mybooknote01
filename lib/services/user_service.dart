// user_service.dart

import 'dart:async';
import '../models/user.dart';
import '../models/book.dart';

/// 사용자 관련 서비스를 제공하는 클래스
class UserService {
  // 실제 앱에서는 이 부분이 데이터베이스나 API와 연결됩니다.
  final List<User> _users = [
    User(
      id: '1',
      name: '홍길동',
      email: 'hong@example.com',
      yearlyReadingGoal: 20,
      preferredGenres: ['소설', '역사'],
    ),
    User(
      id: '2',
      name: '김철수',
      email: 'kim@example.com',
      yearlyReadingGoal: 30,
      preferredGenres: ['과학', '철학'],
    ),
  ];

  /// 사용자 정보를 가져오는 메서드
  Future<User?> getUserById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    return _users.firstWhere((user) => user.id == id, orElse: () => null as User);
  }

  /// 새로운 사용자를 등록하는 메서드
  Future<User> registerUser(String name, String email) async {
    await Future.delayed(Duration(milliseconds: 500));
    final newUser = User(
      id: (int.parse(_users.last.id) + 1).toString(),
      name: name,
      email: email,
    );
    _users.add(newUser);
    return newUser;
  }

  /// 사용자 정보를 업데이트하는 메서드
  Future<void> updateUser(User updatedUser) async {
    await Future.delayed(Duration(milliseconds: 500));
    final index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
    } else {
      throw Exception('User not found');
    }
  }

  /// 사용자의 연간 독서 목표를 설정하는 메서드
  Future<void> setYearlyReadingGoal(String userId, int goal) async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = await getUserById(userId);
    if (user != null) {
      user.yearlyReadingGoal = goal;
      await updateUser(user);
    } else {
      throw Exception('User not found');
    }
  }

  /// 사용자의 선호 장르를 업데이트하는 메서드
  Future<void> updatePreferredGenres(String userId, List<String> genres) async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = await getUserById(userId);
    if (user != null) {
      user.preferredGenres = genres;
      await updateUser(user);
    } else {
      throw Exception('User not found');
    }
  }

  /// 사용자의 읽은 책 목록에 책을 추가하는 메서드
  Future<void> addBookToReadList(String userId, Book book) async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = await getUserById(userId);
    if (user != null) {
      user.readBooks.add(book);
      await updateUser(user);
    } else {
      throw Exception('User not found');
    }
  }

  /// 사용자의 현재 읽고 있는 책 목록에 책을 추가하는 메서드
  Future<void> addBookToCurrentlyReading(String userId, Book book) async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = await getUserById(userId);
    if (user != null) {
      user.currentlyReadingBooks.add(book);
      await updateUser(user);
    } else {
      throw Exception('User not found');
    }
  }

  /// 사용자의 독서 진행 상황을 계산하는 메서드
  Future<double> calculateReadingProgress(String userId) async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = await getUserById(userId);
    if (user != null && user.yearlyReadingGoal > 0) {
      return user.readBooks.length / user.yearlyReadingGoal;
    } else {
      return 0.0;
    }
  }
}

// 사용 예시
void main() async {
  final userService = UserService();

  // 사용자 정보 가져오기
  final user = await userService.getUserById('1');
  print('사용자 정보: $user');

  // 새 사용자 등록하기
  final newUser = await userService.registerUser('이영희', 'lee@example.com');
  print('새로 등록된 사용자: $newUser');

  // 연간 독서 목표 설정하기
  await userService.setYearlyReadingGoal('1', 25);
  print('목표 설정 후 사용자 정보: ${await userService.getUserById('1')}');

  // 선호 장르 업데이트하기
  await userService.updatePreferredGenres('1', ['소설', '역사', '과학']);
  print('장르 업데이트 후 사용자 정보: ${await userService.getUserById('1')}');

  // 읽은 책 추가하기
  await userService.addBookToReadList('1', Book(id: '1', title: '1984', author: 'George Orwell', genre: '소설'));
  print('책 추가 후 사용자 정보: ${await userService.getUserById('1')}');

  // 독서 진행 상황 계산하기
  final progress = await userService.calculateReadingProgress('1');
  print('사용자의 독서 진행 상황: ${progress * 100}%');
}