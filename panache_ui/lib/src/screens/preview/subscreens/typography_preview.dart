import 'package:flutter/material.dart';

class TypographyPreview extends StatelessWidget {
  //final ThemeData theme;

  final TextTheme textTheme;
  final Brightness brightness;

  const TypographyPreview({Key key, @required this.textTheme, @required this.brightness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: brightness == Brightness.dark ? Colors.grey.shade700 : Colors.grey.shade100,
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text(
            'Headline\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.headline5,
          ),
          Text(
            'Subhead\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.subtitle1,
          ),
          Text(
            'Title\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.headline6,
          ),
          Text(
            'Subtitle\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.subtitle2,
          ),
          Text(
            'Caption\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.caption,
          ),
          Text(
            'Overline\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.overline,
          ),
          Text(
            'Body 1\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.bodyText2,
          ),
          Text(
            'Body 2\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\nThe quick brown fox jumps over the lazy dog\n',
            style: textTheme.bodyText1,
          ),
          TextButton(
              child: Text(
                'button',
                style: textTheme.button,
              ),
              onPressed: () {}),
          Text(
            'Display 1',
            style: textTheme.headline4,
          ),
          Text(
            'Display 2',
            style: textTheme.headline3,
          ),
          Text(
            'Display 3',
            style: textTheme.headline2,
          ),
          Text(
            'Display 4',
            style: textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
