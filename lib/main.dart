// main.dart

import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'services/book_service.dart';
import 'services/user_service.dart';

/// 앱의 진입점
void main() {
  runApp(const MyApp());
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '독서기록노트',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 앱의 기본 글꼴 설정
        fontFamily: 'Pretendard',
        // 텍스트 테마 설정
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
          bodyText1: TextStyle(fontSize: 16.0, height: 1.5),
          bodyText2: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        // 앱 바 테마 설정
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        // 버튼 테마 설정
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      // 다크 모드 테마 설정 (옵션)
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
        // 다크 모드에 대한 추가 테마 설정을 여기에 추가
      ),
      // 시스템 설정에 따라 라이트/다크 모드 자동 전환
      themeMode: ThemeMode.system,
      // 디버그 배너 제거
      debugShowCheckedModeBanner: false,
      // 앱의 시작 화면 설정
      home: const WelcomeScreen(),
    );
  }
}

/// 홈 화면 위젯
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BookService 및 UserService 인스턴스 생성
    final BookService bookService = BookService();
    final UserService userService = UserService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('독서기록노트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '독서기록노트에 오신 것을 환영합니다!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // 예시: 책 서비스 사용
                final books = await bookService.getAllBooks();
                print('Total books: ${books.length}');
              },
              child: const Text('책 목록 가져오기'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // 예시: 사용자 서비스 사용
                final user = await userService.getUserById('1');
                print('User: ${user?.name}');
              },
              child: const Text('사용자 정보 가져오기'),
            ),
          ],
        ),
      ),
    );
  }
}