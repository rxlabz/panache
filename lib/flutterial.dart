import 'package:flutter/material.dart';
import 'package:flutterial/theme_editor.dart';
import 'package:flutterial_components/flutterial_components.dart';

class FlutterialApp extends StatefulWidget {
  final ThemeService service;

  FlutterialApp({this.service});

  @override
  State<StatefulWidget> createState() => FlutterialAppState();
}

class FlutterialAppState extends State<FlutterialApp> {
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
    theme = Function.apply(theme.copyWith, null, args);
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
        onTargetChanged: (isAndroidMode) => theme = isAndroidMode
            ? theme.copyWith(platform: TargetPlatform.android)
            : theme.copyWith(platform: TargetPlatform.iOS),
        isAndroidMode: theme.platform == TargetPlatform.android,
        onBaseThemeChanged: (hasDarkBase) =>
            theme = hasDarkBase ? ThemeData.dark() : ThemeData.light(),
        hasDarkBase: theme.brightness == Brightness.dark,
        onPrimaryBrightnessChanged: (isDark) => theme = theme.copyWith(
            primaryColorBrightness:
                isDark ? Brightness.dark : Brightness.light),
        onAccentBrightnessChanged: (isDark) => theme = theme.copyWith(
            accentColorBrightness: isDark ? Brightness.dark : Brightness.light),
      );
}
