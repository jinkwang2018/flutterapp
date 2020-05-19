import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Flutter Layout Demo', // 앱의 타이틀
      theme: ThemeData( // 앱의 테마 설정
        primarySwatch: Colors.red,  // 주요 테마 색상
      ),
      // initialRoute 설정. home이 아닌 초기 라우트로 설정
      // '/'은 앱의 첫 라우트(root 라우트)를 의미함
      initialRoute: '/',

      // 라우트들을 등록
      routes: {
        '/': (context) => FirstScreen(),  // 초기 라우트로 FirstScreen을 설정
        '/second': (context) => SecondScreen(), // '/second'란 경로로 SecondScrrent을 설정정
      },  
    )
  );
}

// 첫번째 라우트
class FirstScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Flutter Layout Demo')
      ),
      body: Center(
        // RaisedButton을 자식으로 등록
        // RaisedButton: 평평한 레이아웃 위에 올라와있는 형태의 버튼
        // 반대로 평평한 모양을 가지는 FlatButton 도 존재함
        child: RaisedButton(
          child: Text('Open second route'),
          onPressed: (){  // 버튼이 눌렸을 때 처리
            // 라우트의 이름으로 새로운 라우트 적재
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 본 앱의 테마의 대표색상을 필드에 저장
    Color color = Theme.of(context).primaryColor;
    // 버튼 로우 구성을 위한 컨테이너 위젯
    Widget buttonSection = Container(
      child: Row( // 로우를 자식으로 가짐
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 자식들이 여유 공간을 공편하게 나눠가짐
        children: <Widget>[ // 세개의 위젯들을 자식들로 가짐
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTH'),
          _buildButtonColumn(color, Icons.share, 'SHARE')
        ],
      ),
    );

    // 매트리얼앱을 생성하여 반환
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter layout demo"),
      ),
      body: ListView( // 리스트로 교체
        // 자식들을 추가
        children: <Widget>[
          // 이미지 추가
          Image.asset(
            'images/cat.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,  // titleSection 컨테이너 추가
          buttonSection,
          textSection,
        ],
      ),
    );
  }
   // 컨테이터 위젯 구현
  Widget titleSection = Container(
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
        // Icon(
        //   Icons.star, // 별모양 아이콘 삽입
        //   color: Colors.red[500], // 빨간색으로 설정
        // ),
        // // 세번째 자식
        // Text('43')  // 텍스트 표시
        FavoriteWidget()
      ],
    ),
  );

  // 버튼과 텍스트로 구성된 컬럼을 생성하여 반환하는 함수
  Column _buildButtonColumn(Color color,IconData icon, String label){
    // 컬럼을 생성하여 반환
    return Column(
      mainAxisSize: MainAxisSize.min, // 여유공간을 최소로 할당
      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
      // 컬럼의 자식들로 아이콘과 컨테이너를 등록
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),  // 컨테이너 상단에 8픽셀의 마진을 할당
          child: Text(  // 텍스트 할당
            label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color
            ),
          ),
        )
      ],
    );
  }

  // 텍스트로 구성된 컨테이너를 구현하는 위젯
  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true, // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
    ),
  );
}

// StatefulWidget을 상속하는 클래스
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
class _FavoriteWidgetState extends State<FavoriteWidget>{

  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    // 로우를 생성
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // 컨테이너 생성
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
              icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.red[500],
              // 아이콘 버튼을 클릭하면 _toggleFavorite 함수를 호출
              onPressed: _toggleFavorite
          ),
        ),
        // 텍스트를 출력하는 SizedBox 추가
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }

  // 아이콘 버튼을 클릭하면 호출
  void _toggleFavorite() {
    setState(() {
      if(_isFavorited){
        _favoriteCount -= 1;
        _isFavorited = false;
      }else{
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}