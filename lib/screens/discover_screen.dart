import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_grid_item.dart';
import '../services/book_recommendation_service.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  // 책 추천 서비스 인스턴스
  final BookRecommendationService _recommendationService = BookRecommendationService();

  // 추천 책 목록
  List<Book> _recommendedBooks = [];

  // 로딩 상태
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  // 추천 책 목록을 불러오는 함수
  Future<void> _loadRecommendations() async {
    try {
      final recommendations = await _recommendationService.getRecommendations();
      setState(() {
        _recommendedBooks = recommendations;
        _isLoading = false;
      });
    } catch (e) {
      // 에러 처리
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('추천 목록을 불러오는 데 실패했습니다: $e');
    }
  }

  // 에러 다이얼로그를 표시하는 함수
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadRecommendations,
        child: CustomScrollView(
          slivers: [
            // 친구의 서재 섹션
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '친구의 서재',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // 임시로 5개의 아이템 표시
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        child: Center(child: Text('친구 $index의 서재')),
                      ),
                    );
                  },
                ),
              ),
            ),
            // 추천 책 섹션
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '추천 도서',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return BookGridItem(
                    book: _recommendedBooks[index],
                    onTap: () {
                      // TODO: 책 상세 정보 페이지로 이동
                    },
                  );
                },
                childCount: _recommendedBooks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}