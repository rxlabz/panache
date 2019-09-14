import 'package:flutter/material.dart';

import '../converters/theme_converter.dart';

class ExportService extends ChangeNotifier {
  Map<String, bool> _exportParams = {
    'mainColors': true,
    'buttonTheme': false,
    'textTheme': false,
    'primaryTextTheme': false,
    'accentTextTheme': false,
    'inputDecorationTheme': false,
    'iconTheme': false,
    'primaryIconTheme': false,
    'accentIconTheme': false,
    'sliderTheme': false,
    'tabBarTheme': false,
    'chipTheme': false,
    'dialogTheme': false,
  };

  String toCode(ThemeData theme) => themeToCode(theme, _exportParams);

  void exportTheme(ThemeData theme, {String filename}) {
    print('ExportService.exportTheme :\n${toCode(theme)}');
  }

  void activate(String property, bool value) {
    _exportParams[property] = value;
    notifyListeners();
  }

  bool isActivated(String property) => _exportParams[property] ?? false;
}
