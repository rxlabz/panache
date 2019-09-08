import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class ThemeCodePreview extends StatelessWidget {
  final ThemeModel model;
  String get code => model.themeCode;

  const ThemeCodePreview(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style =
        SyntaxHighlighterStyle.panacheThemeStyle();

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.blueGrey.shade800)),
          color: Colors.blueGrey.shade900),
      padding: EdgeInsets.only(top: 24, left: 24),
      child: SingleChildScrollView(
        child: RichText(
          text: TextSpan(
              style: const TextStyle(fontSize: 12.0),
              children: <TextSpan>[DartSyntaxHighlighter(style).format(code)]),
        ),
      ),
    );
  }
}
