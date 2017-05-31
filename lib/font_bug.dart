import 'package:flutter/material.dart';

void main() {
  runApp(new ThemedApp());
}

class ThemedApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ThemedAppState();
}

class ThemedAppState extends State<ThemedApp> {
  ThemeData theme = new ThemeData.light();

  @override
  Widget build(BuildContext context) {
    print('ThemedAppState.build... ');
    return new MaterialApp(
      theme: theme,
      home: new Scaffold(
        body: new Center(
          child: new Column( mainAxisSize: MainAxisSize.min, children: [
            new RaisedButton(
              onPressed: () => setState(
                  () => theme = theme.copyWith(accentColor: Colors.green)),
              child: new Text('Un bouton'),
            ),
            new FloatingActionButton(
                child: const Icon(Icons.check),
                onPressed: () => print('FAB... ')),
          ]),
        ),
      ),
    );
  }
}
