import 'package:flutter/material.dart';
import 'package:flutterial/theme_editor.dart';
import 'package:flutterial_components/flutterial_components.dart';

class FlutterialApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FlutterialAppState();
}

class FlutterialAppState extends State<FlutterialApp> {
  ThemeService _service;

  ThemeData get theme => _service.theme;
  set theme(ThemeData theme) =>
      _service.theme = theme; // this calls onThemeChanged, which calls setState

  void updateColor({String propertyName, Color color}) {
    assert(_service != null);
    assert(theme != null);

    theme = Function.apply(theme.copyWith, null, {Symbol(propertyName): color});
  }

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      _service = ThemeService();
    }

    return Row(
      children: [
        Expanded(child: _buildConfigurator()),
        AppPreviewContainer(_service, kIPhone6),
      ],
    );
  }

  Widget _buildConfigurator() => ThemeEditor(
        service: _service,
        onTargetChanged: (isAndroidMode) => theme = isAndroidMode
            ? theme.copyWith(platform: TargetPlatform.android)
            : theme.copyWith(platform: TargetPlatform.iOS),
        isAndroidMode: theme.platform == TargetPlatform.android,
        onBaseThemeChanged: (isDark) => theme = ThemeData.localize(
            isDark ? ThemeData.dark() : ThemeData.light(), theme.textTheme),
        hasDarkBase: theme.brightness == Brightness.dark,
        onPrimaryBrightnessChanged: (isDark) => theme = theme.copyWith(
            primaryColorBrightness:
                isDark ? Brightness.dark : Brightness.light),
        onAccentBrightnessChanged: (isDark) => theme = theme.copyWith(
            accentColorBrightness: isDark ? Brightness.dark : Brightness.light),
      );
}
