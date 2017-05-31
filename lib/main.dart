import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/theme_editor.dart';
import 'package:flutterial/themify/themified.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new ThemeExplorerApp(),
      )));
}

const kThumbSize = 36.0;

ThemeData buildTheme() => new ThemeData.light()
    .copyWith(primaryColor: Colors.blueGrey, accentColor: Colors.cyan);

class ThemeExplorerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ThemeExplorerAppState();
}

class ThemeExplorerAppState extends State<ThemeExplorerApp> {
  ThemeData theme;

  bool hasDarkBase = false;
  bool targetAndroid = false;

  @override
  void initState() {
    super.initState();
    theme = new ThemeData.light()
        .copyWith(primaryColorBrightness: Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(child: _buildConfigurator()),
        new Expanded(child: _buildPreview(theme)),
      ],
    );
  }

  Widget _buildConfigurator() => new ThemeEditor(
        themeChangedHandler: (t) => setState(() => theme = t),
        onTargetChanged: (value) {
          setState(() {
            theme = value
                ? theme.copyWith(platform: TargetPlatform.iOS)
                : theme.copyWith(platform: TargetPlatform.android);
            targetAndroid = value;
          });
        },
        androidMode: targetAndroid,
        onBaseThemeChanged: (value) => setState(() {
              theme = value ? new ThemeData.dark() : new ThemeData.light();
              hasDarkBase = value;
            }),
        hasDarkBase: hasDarkBase,
        updatePrimaryColor: (c) =>
            updateColor(propertyName: "primaryColor", color: c),
        updateAccentColor: (c) =>
            updateColor(propertyName: "accentColor", color: c),
        updateScaffoldBGColor: (c) =>
            updateColor(propertyName: "scaffoldBackgroundColor", color: c),
        updateDividerColor: (c) =>
            updateColor(propertyName: "dividerColor", color: c),
        updateButtonColor: (c) =>
            updateColor(propertyName: "buttonColor", color: c),
        updateCanvasColor: (c) =>
            updateColor(propertyName: "canvasColor", color: c),
        updateCardColor: (c) =>
            updateColor(propertyName: "cardColor", color: c),
        updateDisabledColor: (c) =>
            updateColor(propertyName: "disabledColor", color: c),
        updateBackgroundColor: (c) =>
            updateColor(propertyName: "backgroundColor", color: c),
        updateHighlightColor: (c) =>
            updateColor(propertyName: "highlightColor", color: c),
        updateSplashColor: (c) =>
            updateColor(propertyName: "splashColor", color: c),
        updateIndicatorColor: (c) =>
            updateColor(propertyName: "indicatorColor", color: c),
        updateSelectedRowColor: (c) =>
            updateColor(propertyName: "selectedRowColor", color: c),
        updateUnselectedWidgetColor: (c) =>
            updateColor(propertyName: "unselectedWidgetColor", color: c),
        updateSecondaryHeaderColor: (c) =>
            updateColor(propertyName: "secondaryHeaderColor", color: c),
        updateTextSelectionColor: (c) =>
            updateColor(propertyName: "textSelectionColor", color: c),
        updateDialogBackgroundColor: (c) =>
            updateColor(propertyName: "dialogBackgroundColor", color: c),
        updateHintColor: (c) =>
            updateColor(propertyName: "hintColor", color: c),
        updateErrorColor: (c) =>
            updateColor(propertyName: "errorColor", color: c),
        updateTextSelectionHandleColor: (c) =>
            updateColor(propertyName: "textSelectionHandleColor", color: c),
        onPrimaryBrightnessChanged: (isDark) => setState(() => theme =
            theme.copyWith(
                primaryColorBrightness:
                    isDark ? Brightness.dark : Brightness.light)),
        onAccentBrightnessChanged: (isDark) => setState(() => theme =
            theme.copyWith(
                accentColorBrightness:
                    isDark ? Brightness.dark : Brightness.light)),
        onBrightnessChanged: (isDark) => setState(() => theme = theme.copyWith(
            brightness: isDark ? Brightness.dark : Brightness.light)),
        currentTheme: theme,
      );

  /*
✅ Color primaryColor,
✅ Color accentColor,
✅ Color scaffoldBackgroundColor,
✅ TargetPlatform platform
✅ Color dividerColor,
✅ Color buttonColor,
✅ Color canvasColor,
✅ Color cardColor,
✅ Color disabledColor,
✅ Color backgroundColor,
✅ Color highlightColor,
✅ Color splashColor,
✅ Color dialogBackgroundColor,
✅ Color indicatorColor, // tab

✅ Color selectedRowColor,
✅ Color hintColor,
✅ Color errorColor
✅ Color unselectedWidgetColor, // not selected sheckbox, radio...
✅ Color secondaryHeaderColor,
✅ Color textSelectionColor,
✅ Color textSelectionHandleColor,

✅ Brightness brightness,
✅ Brightness primaryColorBrightness,
✅ Brightness accentColorBrightness,

✅ TextTheme textTheme,
✅ TextTheme primaryTextTheme,
TextTheme accentTextTheme,

IconThemeData iconTheme,
IconThemeData primaryIconTheme,
IconThemeData accentIconTheme,
*/

  Widget _buildPreview(ThemeData theme) => new Container(
      color: Colors.grey.shade300,
      child: new Center(
          child: new Container(
              width: 750.0 / 2,
              height: 1334.0 / 2,
              decoration: new BoxDecoration(boxShadow: [
                new BoxShadow(blurRadius: 4.0, color: Colors.grey.shade500)
              ]),
              child: new Themified(theme))));

  void updateColor({String propertyName, Color color}) {
    final args = <Symbol, dynamic>{};
    args[new Symbol(propertyName)] = color;
    setState(() => theme = Function.apply(theme.copyWith, null, args));
  }
}
