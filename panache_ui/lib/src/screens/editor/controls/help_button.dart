import 'package:flutter/material.dart';
import '../../../help/help.dart';

class HelpButton extends StatelessWidget {
  final HelpData help;

  const HelpButton({Key key, this.help}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.help),
      color: Colors.blueGrey.shade300,
      onPressed: () => showHelp(
        context,
        title: help.title,
        content: help.content,
      ),
    );
  }

  showHelp(BuildContext context, {String content, String title}) {
    final textTheme = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(title),
        contentPadding: const EdgeInsets.all(24),
        children: [Text(content, style: textTheme.subhead)],
      ),
    );
  }
}
