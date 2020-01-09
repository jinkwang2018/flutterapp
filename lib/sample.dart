import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
        appBar: AppBar(
        title: Text('Startup Name Generator'),
    ),
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
         primarySwatch: Colors.blue, 
         accentColor: Colors.pinkAccent, 
         fontFamily: 'Ubuntu',
       ),

      title: 'Startup Name Generator',
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar( 
          title: new Text("ee"), 
          actions: <Widget>[ 
            new IconButton( 
              icon: new Icon(Icons.photo_album), 
              tooltip: 'Hi!', 
              onPressed: () => {}, 
            ), 
            new IconButton( 
              icon: new Icon(Icons.pie_chart), 
              tooltip: 'Wow', 
              onPressed: () => {}, 
            ) 
          ], 
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar( 
          items: [ 
            new BottomNavigationBarItem( 
              icon: new Icon(Icons.account_balance), 
              title: new Text('Bank'), 
            ), 
            new BottomNavigationBarItem( 
              icon: new Icon(Icons.apps), 
              title: new Text('Apps'), 
            ), 
            new BottomNavigationBarItem( 
              icon: new Icon(Icons.shopping_basket), 
              title: new Text('Shop'), 
            ), 
          ],
        ),
        body: new Container( 
          padding: const EdgeInsets.all(20.0), 
          child: new Column( 
            children: <Widget>[
              new Text("Hello World"),
              new TextField( 
                decoration: new InputDecoration( 
                  border: InputBorder.none, 
                  hintText: 'Please enter text!!!'
                  ), 
              ),
              new Checkbox( 
                value: true, 
                onChanged: (bool value) {}, 
              ), 
              new Radio<int>( 
                value: 0, 
                groupValue: 0, 
                onChanged: (_) {}, 
              ),
              new Switch( 
                value: false, 
                onChanged: (bool value) {}, 
              ),
              new ButtonBar( 
                mainAxisSize: MainAxisSize.min, 
                children: <Widget>[ 
                  new RaisedButton( 
                    child: const Text('Raised'), 
                    onPressed: null, 
                  ), 
                  const RaisedButton( 
                    child: const Text('Disabled'), 
                    onPressed: null, 
                  ), 
                ], 
              ), 
              new ButtonBar( 
                mainAxisSize: MainAxisSize.min, 
                children: <Widget>[ 
                  new FlatButton( 
                    child: const Text('Flat'), 
                    onPressed: null, 
                  ), 
                  const FlatButton( 
                    child: const Text('Disabled'), 
                    onPressed: null, 
                  ), 
                ], 
              ), 
              new ButtonBar( 
                mainAxisSize: MainAxisSize.min, 
                children: <Widget>[ 
                  new OutlineButton( 
                    child: const Text('OutLine'), 
                    onPressed: null, 
                  ), 
                  const RaisedButton( 
                    child: const Text('Disabled'), 
                    onPressed: null, 
                  ), 
                ], 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

