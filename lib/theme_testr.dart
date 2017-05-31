import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      theme: new ThemeData.dark().copyWith(
          primaryColorBrightness: Brightness.light,
          accentColorBrightness: Brightness.light),
      home: new Scaffold(
        appBar: new AppBar(title: new Text('test theme')),
        body: new Column(children: [
          new FloatingActionButton(
              child: new Icon(Icons.android), onPressed: null),
          new RaisedButton(
              child: new Text('test'), onPressed: () => print('test'))
        ]),
      )));
}
