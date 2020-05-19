import 'package:flutter/material.dart';

// Todo 리스트의 아이템을 저장할 자료 구조
void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: MyApp(
      // TodosScreen 스크린을 홈으로 설정
      // Todo 타입의 아이템을 20개 List로 생성하여 전달
      todos: List.generate(
        20, // 생성할 아이템 갯수
        (i) => Todo(
            'Todo $i', 'A description of what needs to be done for Todo $i'),
      ),
    ),
  ));
}

class Todo {
  // final로 정의된 필드는 선언단계나 생성자를 통해 초기화해야함
  final String title;
  final String description;

  Todo(this.title, this.description); // 생성자로 필드 초기화
}
class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp 생성/반환
    return MaterialApp(
      title: 'Snackbar Demo',
      // 홈으로 Scaffold을 직접 구현
      home: Scaffold(
        appBar: AppBar(title: Text('SnackBar Demo')),
        // SncacBarpage 클래스 호출
        body: SnackBarPage(),
      ),
    );
  }
}

// 초기 스크린의 body를 구성
class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // 화면 중앙에 RaisedButton 추가
      child: RaisedButton(
        // RaisedButton에 텍스트 추가
        child: Text('Show SnackBar'),
        // RaisedButton을 누르면 호출
        onPressed: () {
          // 스낵바 생성
          final snackbar = SnackBar(
            // 컨텐트 구성. 텍스를 주입
            content: Text('Yay! A SncackBar!'),
            // 액션 구입
            action: SnackBarAction(
              // 스낵바에 label 추가
              label: 'Undo',
              // 스낵바에 label을 누를 때 호출
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          
          // 생성한 스낵바를 노출. 화면 하단에 스낵바가 출력됨
          Scaffold.of(context).showSnackBar(snackbar);
        },
      ),
    );
  }
}

// 앱 실행시 출력되는 라우트
class MyApp extends StatelessWidget{
  final List<Todo> todos; // Todo 아이템 리스트
 // 생성자에서 Todo 아이템 리스트를 받아서 필드에 저장
  MyApp({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen Home Screen'),
        
      ),
      body: ListView.builder(
        // 리스트뷰의 아이템 갯수. itemCount의 수만큼 itemBuilder가 호출됨
        itemCount: todos.length,
        // 리스트뷰의 아이템 생성
        itemBuilder: (context, index) {
          // ListTile을 반환
          return ListTile(
            title: Text(todos[index].title),
            // ListTile은 onTap과 onLongPress를 지원함함
            onTap: () {
              // ListTile이 탭되면 DetailScreen 스크린을 적재
              Navigator.push(
                context,
                MaterialPageRoute(
                  // 파라미터 todo로 tap된 index의 아이템을 전달
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),// 드로워(서랍) 추가
      drawer: Drawer(
        // 리스트뷰 추가
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 드로워해더 추가
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // 리스트타일 추가
            ListTile(
              title: Text('Item 1'),
              onTap: (){
               SnackBarDemo();
              },
            ),
            // 리스트타일 추가
            ListTile(
              title: Text('Item 2'),
              onTap: (){
                // 드로워를 닫음
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetailScreen  extends StatelessWidget{
  final Todo todo;

  // 생성자. 라우트 생성시 전달한 파라미터를 아규먼트로 넘겨받아 필드에 저장
  const DetailScreen({
    Key key,
    @required this.todo
  }):super(key:key);

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
                  child: Text(todo.title,  // 컨테이너의 자식으로 텍스트 삽입
                    style: TextStyle(
                        fontWeight: FontWeight.bold // 텍스트 강조 설정
                    ),
                  ),
                ),
                // 컬럼의 두번째 자식으로 텍스트 삽입
                Text(
                  todo.description,
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

    // 텍스트로 구성된 컨테이너를 구현하는 위젯
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        todo.description,
        softWrap: true, // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
      ),
    );

    // 매트리얼앱을 생성하여 반환
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
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
          titleSection,
          buttonSection,
          textSection,
        ],
      ),
    );
  }
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
}

// 라우트 생성시 전달할 아규먼트 클래스
class ScreenArguments{
  // 아규먼트의 타이틀과 메시지. 생성자에 의해서만 초기화되고 변경할 수 없음
  final String title;
  final String message;

  // 생성자
  ScreenArguments(this.title, this.message);
}
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