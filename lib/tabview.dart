import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

boxWidget() {
    return Container(
      // 컨테이너 내부 상하좌우에 32픽셀만큼의 패딩 삽입
    padding: const EdgeInsets.all(32),
    // 자식으로 로우를 추가
      child: Row(
        // 로우에 위젯들(Expanded, Icon, Text)을 자식들로 추가
        children: <Widget>[
          // 첫번째 자식
          Expanded(
            // 첫번째 자식의 자식으로 컬럼 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 왼쪽정렬로 배치함
              // 컬럼의 자식들로 컨테이너와 텍스트를 추가
              children: <Widget>[
                // 컬럼의 첫번째 자식 컨테이너
                Container(
                  padding: const EdgeInsets.only(bottom: 8), // 컨테이너 내부 하단에 8픽셀만큼 패딩 삽입
                  child: Text(  // 컨테이너의 자식으로 텍스트 삽입
                    "Oeschinen Lake Campground",
                    style: TextStyle(
                        fontWeight: FontWeight.bold // 텍스트 강조 설정
                    ),
                  ),
                ),
                // 컬럼의 두번째 자식으로 텍스트 삽입
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                      color: Colors.grey[500] // 텍스트의 색상을 설정
                  ),
                )
              ],
            ),
          ),
          // 두번째 자식 아이콘
          Icon(
            Icons.star, // 별모양 아이콘 삽입
            color: Colors.red[500], // 빨간색으로 설정
          ),
          // 세번째 자식
          Text('43')  // 텍스트 표시
        ],
      ),
    );
  }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /**
       * Tab 사용법
       * 스크린을 TabController 위젯으로 구성함
       * TabBar: 사용할 탭을 구성. appBar의 bottom으로 구현
       * TabBarView: 탭이 선택될 시 디스플레이할 컨텐트 구성. body로 구현
       */
      home: DefaultTabController(
        // 탭의 수 설정
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tabs Demo'),
            // TabBar 구현. 각 컨텐트를 호출할 탭들을 등록
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
          // TabVarView 구현. 각 탭에 해당하는 컨텐트 구성
          body: TabBarView(
            children: [
              RandomWords(),
              boxWidget(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}