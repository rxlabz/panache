import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColorBrightness: Brightness.light,
          accentColorBrightness: Brightness.light),
      home: Scaffold(
        appBar: AppBar(title: Text('test theme')),
        body: Column(
          children: [
            FloatingActionButton(child: Icon(Icons.android), onPressed: null),
            RaisedButton(child: Text('test'), onPressed: () => print('test'))
          ],
        ),
      ),
    ),
  );
}
