import 'package:flutter/material.dart';

void main() {
  runApp(ThemedApp());
}

class ThemedApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemedAppState();
}

class ThemedAppState extends State<ThemedApp> {
  ThemeData theme = ThemeData.light();

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  onPressed: () => setState(
                      () => theme = theme.copyWith(accentColor: Colors.green)),
                  child: Text('Un bouton'),
                ),
                FloatingActionButton(
                    child: const Icon(Icons.check),
                    onPressed: () => print('FAB... ')),
              ],
            ),
          ),
        ),
      );
}
