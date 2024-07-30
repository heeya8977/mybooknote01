import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  final List<String> selectedGenres;
  final int targetBooks;

  const HomeScreen({
    Key? key,
    required this.selectedGenres,
    required this.targetBooks,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // 각 탭에 해당하는 화면 위젯들
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
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
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('선택한 장르: ${widget.selectedGenres.join(", ")}'),
          const SizedBox(height: 20),
          Text('목표 독서량: ${widget.targetBooks}권'),
        ],
      ),
    );
  }

  Widget _buildMyLibraryTab() {
    return const Center(
      child: Text('나의 서재 탭'),
    );
  }

  Widget _buildDiscoverTab() {
    return const Center(
      child: Text('Discover 탭'),
    );
  }

  Widget _buildChallengeTab() {
    return const Center(
      child: Text('챌린지 탭'),
    );
  }

  Widget _buildBookSearchTab() {
    return const Center(
      child: Text('책 찾기 탭'),
    );
  }
}