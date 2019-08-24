import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(new MyApp());
}

class RandomEnglishWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomEnglishWordsState();
  }
}

class RandomEnglishWordsState extends State<RandomEnglishWords> {
  final _words = <WordPair>[];
  final _checkWords = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("list of english word"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushToSavedWordsScreen)
        ],
      ),
      body: new ListView.builder(itemBuilder: (context, index){
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index], index);
      }),
    );
  }

  _pushToSavedWordsScreen(){
    print("You Press To The Right Icon");
    final pageRoute = new MaterialPageRoute(builder: (context) {
      final listTiles = _checkWords.map((workPair) {
        return new ListTile(
          title: new Text(
            workPair.asUpperCase,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        );
      });
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Checked words"),
        ),
        body: new ListView(children: listTiles.toList(),),
      );
    });
    Navigator.of(context).push(pageRoute);
  }

  Widget _buildRow(WordPair wordPair, int index) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkWords.contains(wordPair);
    return new ListTile(
      leading: new Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: color,
      ),
      title: new Text(
          wordPair.asUpperCase,
        style: new TextStyle(fontSize: 18.0, color: color),
      ),
      trailing: new Text("Trailing Text"),
      onTap: (){
        setState(() {
          if (isChecked){
            _checkWords.remove(wordPair);
          }else {
            _checkWords.add(wordPair);
          }
        });
      },
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'This is my flutter app',
      home: new RandomEnglishWords(),
    );
  }
}