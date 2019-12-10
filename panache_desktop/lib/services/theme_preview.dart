import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class ThemePreview extends StatefulWidget {
  final PanacheTheme theme;

  const ThemePreview({Key key, this.theme}) : super(key: key);

  @override
  _ThemePreviewState createState() => _ThemePreviewState();
}

class _ThemePreviewState extends State<ThemePreview> {
  Widget currentPreview;

  @override
  void initState() {
    currentPreview = BasilPreview(theme: widget.theme.themeData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: 500),
      color: Colors.grey.shade700,
      child: Stack(
        children: <Widget>[
          Center(child: currentPreview),
        ],
      ),
    );
  }
}

const _creamyPesto = '''
Guilt-free gluten-free spaghetti pasta is sautéed in a garlic, kale pesto.
It's an easy and healthy dinner
''';

const greenBasil = Color(0xff356859);
const orangeBasil = Color(0xfffd5523);
const greenBasilMedium = Color(0xff37966f);

final ThemeData basilTheme = ThemeData(
  primarySwatch: swatchFor(color: greenBasil),
  primaryColorDark: greenBasilMedium,
  primaryColorLight: Color(0xffb9e4c9),
  accentColor: orangeBasil,
  scaffoldBackgroundColor: Color(0xfffffbe6),
  dividerColor: greenBasil,
  textTheme: Typography.blackCupertino
      .merge(Typography.englishLike2018)
      .apply(bodyColor: greenBasil, displayColor: greenBasil),
  primaryTextTheme: Typography.blackCupertino
      .merge(Typography.englishLike2018)
      .apply(bodyColor: greenBasil, displayColor: greenBasil),
  accentTextTheme: Typography.blackCupertino
      .merge(Typography.englishLike2018)
      .apply(bodyColor: orangeBasil, displayColor: orangeBasil),
  iconTheme: IconThemeData(color: greenBasil, opacity: 1),
  primaryIconTheme: IconThemeData(color: greenBasilMedium, opacity: 1),
  platform: TargetPlatform.iOS,
);

class BasilPreview extends StatefulWidget {
  final ThemeData theme;

  const BasilPreview({Key key, this.theme}) : super(key: key);

  @override
  _BasilPreviewState createState() => _BasilPreviewState();
}

class _BasilPreviewState extends State<BasilPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 640,
      child: Theme(
        data: basilTheme,
        child: BasilMobileScreen(),
      ),
    );
  }
}

class BasilMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.primaryTextTheme;
    final headerStyle = textTheme.headline.copyWith(fontSize: 16);
    final titleStyle = textTheme.title;
    final accentTitle = theme.accentTextTheme.display2;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 96, bottom: 16),
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.primaryColorLight, width: 3),
            ),
            child: Icon(Icons.bookmark_border),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Text('SHOPPING LIST', style: headerStyle),
            ),
          ),
          FractionallySizedBox(
              widthFactor: 0.3, child: Divider(/*color: greenBasil*/)),
          ...['APPETIZERS', 'ENTREES', 'DESSERTS', 'COCKTAILS']
              .map(_buildMenuButton)
              .toList(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: Text('BASiL', style: textTheme.display3),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            color: Colors.greenAccent.shade100,
            height: 200,
            child: Center(child: Text('photo')),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 64, left: 24, right: 24),
                    padding:
                        const EdgeInsets.only(top: 96, left: 24, right: 24),
                    color: theme.primaryColorLight.withOpacity(0.2),
                    child: Text(
                      _creamyPesto,
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'Creamy Pesto Pasta',
                    style: accentTitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(children: <Widget>[Text('Calories'), Text('865')]),
                Container(width: 1, height: 32, color: Colors.black),
                Column(children: <Widget>[Text('Protein'), Text('27g')]),
                Container(width: 1, height: 32, color: Colors.black),
                Column(children: <Widget>[Text('Fat'), Text('12g')]),
              ],
            ),
          ),
          FractionallySizedBox(widthFactor: 0.8, child: Divider()),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String label) => Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Text(label),
      ));
}
