import 'package:flutter/material.dart';
import 'package:flutterial/theme_editor.dart';
import 'package:flutterial_components/flutterial_components.dart';

class FlutterialApp extends StatefulWidget {
  final ThemeService service;

  FlutterialApp({this.service}) ;

  @override
  State<StatefulWidget> createState() => new ThemeExplorerAppState();
}

class ThemeExplorerAppState extends State<FlutterialApp> {
  ThemeData theme;

  bool targetAndroid = false;
  bool hasDarkBase = false;

  @override
  void initState() {
    super.initState();
    theme = new ThemeData.light()
        .copyWith(primaryColorBrightness: Brightness.light);
  }

  void updateColor({String propertyName, Color color}) {
    final args = <Symbol, dynamic>{};
    args[new Symbol(propertyName)] = color;
    setState(() => theme = Function.apply(theme.copyWith, null, args));
  }

  void updateTheme(ThemeData newValue) {
    setState(() {
      print('ThemeExplorerAppState.updateTheme... ');
      theme = newValue;
      widget.service.saveTheme(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(child: _buildConfigurator(widget.service)),
        new AppPreviewContainer(widget.service, kIPhone6),
      ],
    );
  }

  Widget _buildConfigurator(ThemeService service) => new ThemeEditor(
        service:service,
        /*currentTheme: theme,*/
        themeChangedHandler: (t) => updateTheme(t),
        onTargetChanged: (value) {
          updateTheme(value
              ? theme.copyWith(platform: TargetPlatform.iOS)
              : theme.copyWith(platform: TargetPlatform.android));
          setState(() => targetAndroid = value);
        },
        androidMode: targetAndroid,
        onBaseThemeChanged: (value) {
          updateTheme(value ? new ThemeData.dark() : new ThemeData.light());
          setState(() => hasDarkBase = value);
        },
        hasDarkBase: hasDarkBase,
        onPrimaryBrightnessChanged: (isDark) => updateTheme(theme.copyWith(
            primaryColorBrightness:
                isDark ? Brightness.dark : Brightness.light)),
        onAccentBrightnessChanged: (isDark) => setState(() => theme =
            theme.copyWith(
                accentColorBrightness:
                    isDark ? Brightness.dark : Brightness.light)),
      );
}
