import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeService<D, F> {
  final Function(String, String) themeExporter;

  final Future<D> Function() dirProvider;
  D _dir;
  D get dir => _dir;

  ThemeData _theme;
  ThemeData get theme => _theme;

  List<F> _themes;
  List<F> get themes => _themes;

  VoidCallback _onChange;

  ThemeService({this.themeExporter, this.dirProvider});

  init(VoidCallback onChange) {
    _onChange = onChange;
    if (dirProvider != null)
      dirProvider().then((dir) {
        _dir = dir;
        _onChange();
      });
  }

  ThemeData _localize(ThemeData theme) =>
      ThemeData.localize(theme, Typography.englishLike2018);

  void initTheme(
      {MaterialColor primarySwatch: Colors.blue,
      Brightness brightness: Brightness.light}) {
    //final inputTheme = InputDecoration().applyDefaults(InputDecorationTheme());

    _theme = ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: primarySwatch,
      brightness: brightness,
      platform: TargetPlatform.iOS
      /*Platform.isAndroid
             ? TargetPlatform.android
             : TargetPlatform.iOS*/
      ,
    );
  }

  void updateTheme(ThemeData newTheme) => _theme = newTheme;

  void exportTheme({String filename, String code}) =>
      themeExporter(code, filename);

  void saveTheme(String filename);

  Future<ThemeData> loadTheme(String path);

  bool themeExists(String path) {}
}
