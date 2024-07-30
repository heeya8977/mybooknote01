import 'package:flutter/material.dart';
import '../models/challenge.dart';
import '../widgets/challenge_card.dart';
import 'create_challenge_screen.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  // 챌린지 목록을 저장하는 리스트
  List<Challenge> _challenges = [
    Challenge(
      id: '1',
      title: '30일 독서 챌린지',
      description: '30일 동안 매일 30분씩 독서하기',
      participants: 128,
      duration: 30,
      type: ChallengeType.individual,
    ),
    Challenge(
      id: '2',
      title: '클래식 문학 읽기',
      description: '3개월 동안 10권의 클래식 문학 작품 읽기',
      participants: 75,
      duration: 90,
      type: ChallengeType.group,
    ),
    Challenge(
      id: '3',
      title: '새로운 장르 도전',
      description: '매월 다른 장르의 책 1권 읽기',
      participants: 93,
      duration: 30,
      type: ChallengeType.individual,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('독서 챌린지'),
      ),
      body: ListView.builder(
        itemCount: _challenges.length,
        itemBuilder: (context, index) {
          return ChallengeCard(
            challenge: _challenges[index],
            onTap: () {
              // TODO: 챌린지 상세 페이지로 이동
              _showChallengeDetails(_challenges[index]);
            },
          );
        },
      ),
      // 새로운 챌린지 생성 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateChallenge(context);
        },
        child: const Icon(Icons.add),
        tooltip: '새로운 챌린지 만들기',
      ),
    );
  }

  // 챌린지 상세 정보를 보여주는 다이얼로그
  void _showChallengeDetails(Challenge challenge) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(challenge.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('설명: ${challenge.description}'),
                Text('참여자: ${challenge.participants}명'),
                Text('기간: ${challenge.duration}일'),
                Text('유형: ${challenge.type == ChallengeType.individual ? '개인' : '그룹'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('참여하기'),
              onPressed: () {
                // TODO: 챌린지 참여 로직 구현
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 새로운 챌린지 생성 페이지로 이동하는 함수
  void _navigateToCreateChallenge(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateChallengeScreen()),
    );

    // 새로운 챌린지가 생성되면 목록에 추가
    if (result != null && result is Challenge) {
      setState(() {
        _challenges.add(result);
      });
    }
  }
}