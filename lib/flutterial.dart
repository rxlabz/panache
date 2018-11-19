import 'package:flutter/material.dart';
import 'package:flutterial/theme_editor.dart';
import 'package:flutterial_components/flutterial_components.dart';

class FlutterialApp extends StatefulWidget {
  final ThemeService service;

  FlutterialApp({this.service});

  @override
  State<StatefulWidget> createState() => ThemeExplorerAppState();
}

class ThemeExplorerAppState extends State<FlutterialApp> {
  ThemeData get theme => widget.service.theme;
  set theme(ThemeData theme) => widget.service.theme = theme;

  @override
  void initState() {
    super.initState();
    widget.service.themeNotifier.addListener(() => setState(() {}));
  }

  void updateColor({String propertyName, Color color}) {
    final args = <Symbol, dynamic>{};
    args[Symbol(propertyName)] = color;
    updateTheme(Function.apply(theme.copyWith, null, args));
  }

  void updateTheme(ThemeData newValue) {
    theme = newValue;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: _buildConfigurator(widget.service)),
          AppPreviewContainer(widget.service, kIPhone6),
        ],
      );

  Widget _buildConfigurator(ThemeService service) => ThemeEditor(
        service: service,
        //themeChangedHandler: (t) => updateTheme(t),
        onTargetChanged: (isAndroidMode) => updateTheme(isAndroidMode
            ? theme.copyWith(platform: TargetPlatform.android)
            : theme.copyWith(platform: TargetPlatform.iOS)),
        isAndroidMode: theme.platform == TargetPlatform.android,
        onBaseThemeChanged: (hasDarkBase) =>
            updateTheme(hasDarkBase ? ThemeData.dark() : ThemeData.light()),
        hasDarkBase: theme.brightness == Brightness.dark,
        onPrimaryBrightnessChanged: (isDark) => updateTheme(theme.copyWith(
            primaryColorBrightness:
                isDark ? Brightness.dark : Brightness.light)),
        onAccentBrightnessChanged: (isDark) => updateTheme(theme.copyWith(
            accentColorBrightness:
                isDark ? Brightness.dark : Brightness.light)),
      );
}
