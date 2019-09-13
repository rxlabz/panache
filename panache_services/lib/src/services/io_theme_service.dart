import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panache_core/panache_core.dart';

typedef Future<Directory> DirectoryProvider();

class IOThemeService extends ThemeService<Directory, File> {
  final Function(String, String) themeExporter;

  final DirectoryProvider dirProvider;
  Directory _dir;
  Directory get dir => _dir;

  ThemeData _theme;
  ThemeData get theme => _theme;

  List<File> _themes;
  List<File> get themes => _themes;

  VoidCallback _onChange;

  IOThemeService({this.themeExporter, this.dirProvider});

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

  void saveTheme(String filename) async {
    final map = themeToMap(_theme);

    if (_dir == null) {
      print('!!!! ThemeService.saveTheme... IMPLEMENT ME');
      return;
    }
    try {
      final _themeFile = File('${_dir.path}/themes/$filename.json');
      print('ThemeService.saveTheme...\n${_themeFile.path}');
      final jsonTheme = json.encode(map);
      await _themeFile.create(recursive: true);
      await _themeFile.writeAsString(jsonTheme, flush: true);
      _onChange();
    } catch (error) {
      throw Exception('Error : The theme can\'t be saved. $error');
    }
  }

  Future<ThemeData> loadTheme(String path) async {
    final _themeFile = File('${_dir.path}/themes/$path');

    if (!(await _themeFile.exists())) {
      throw Exception('ERROR : Theme file not founded !');
    }

    final jsonTheme = await _themeFile.readAsString();
    _theme = themeFromJson(jsonTheme);
    return _theme;
  }

  bool themeExists(String path) {
    return File(path).existsSync();
  }
}
