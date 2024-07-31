import 'package:bookshelf_app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

// HomeScreen 위젯 정의
class HomeScreen extends StatefulWidget {
  final List<String> selectedGenres;
  final int targetBooks;

  // 생성자: 선택된 장르와 목표 독서량을 받습니다.
  const HomeScreen({
    Key? key,
    required this.selectedGenres,
    required this.targetBooks,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스

  // 각 탭에 해당하는 화면 위젯들
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // 각 탭에 해당하는 화면 초기화
    _screens = [
      _buildHomeTab(),
      _buildMyLibraryTab(),
      _buildDiscoverTab(),
      _buildChallengeTab(),
      _buildBookSearchTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('독서 기록 노트'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex], // 현재 선택된 탭의 화면 표시
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 선택된 탭 업데이트
          });
        },
      ),
    );
  }

  // 홈 탭 화면 구성
  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('선택한 장르: ${widget.selectedGenres.join(", ")}'),
          const SizedBox(height: 20),
          Text('목표 독서량: ${widget.targetBooks}권'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 여기에 독서 시작 로직 추가
              print('독서 시작!');
            },
            child: const Text('독서 시작', style: TextStyle(fontSize: 20, color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // 나의 서재 탭 화면 구성
  Widget _buildMyLibraryTab() {
    return const Center(
      child: Text('나의 서재 탭 - 구현 예정'),
    );
  }

  // Discover 탭 화면 구성
  Widget _buildDiscoverTab() {
    return const Center(
      child: Text('Discover 탭 - 구현 예정'),
    );
  }

  // 챌린지 탭 화면 구성
  Widget _buildChallengeTab() {
    return const Center(
      child: Text('챌린지 탭 - 구현 예정'),
    );
  }

  // 책 찾기 탭 화면 구성
  Widget _buildBookSearchTab() {
    return const Center(
      child: Text('책 찾기 탭 - 구현 예정'),
    );
  }
}