import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panache_core/src/converters/theme_converter.dart';

const codeStart = '''
  import 'package:flutter/material.dart';
  final ThemeData myTheme = ThemeData(''';

void main() {
  test('can export theme to code', () {
    final theme = ThemeData.light();
    final themeCode = themeToCode(theme);
    expect(themeCode.contains(codeStart), true);
    expect(themeCode.contains('primarySwatch: Colors.blue,'), true);
    expect(themeCode.contains('sliderTheme: SliderThemeData('), true);
    expect(themeCode.contains('tabBarTheme: TabBarTheme('), true);
    expect(themeCode.contains('chipTheme: ChipThemeData('), true);
    expect(themeCode.contains('dialogTheme: DialogTheme('), true);
  });

  test('can save theme to / load theme from JSON', () {
    final theme = ThemeData.light();
    final themeMap = themeToMap(theme);
    final generatedTheme = themeFromJson(json.encode(themeMap));
    expect(generatedTheme.primaryColor.value, Colors.blue.value);
    expect(themeMap, themeToMap(generatedTheme));
  });
}
