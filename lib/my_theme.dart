import 'package:flutter/material.dart';
import 'package:flutterial/theme.dart';

void main() {
  runApp(ThemeExample());
}

class ThemeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My app'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton.icon(
                onPressed: () {}, icon: Icon(Icons.create), label: Text('Yo'))
          ],
        ),
      ),
    );
  }
}
