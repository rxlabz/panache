import 'package:flutter/material.dart';

const panachePrimarySwatch = Colors.blueGrey;

ThemeData buildAppTheme(ThemeData theme, MaterialColor primarySwatch) {
  final textTheme = theme.textTheme;
  final accentColor = primarySwatch[500];
  final primaryColorDark = primarySwatch[700];

  var a = theme.copyWith(
    textTheme: textTheme.copyWith(
      bodyText1: textTheme.bodyText1.copyWith(fontSize: 12),
      bodyText2: textTheme.bodyText2.copyWith(fontSize: 12),
      subtitle2: textTheme.subtitle2.copyWith(color: primarySwatch[400], fontSize: 12),
      headline6: textTheme.headline6.copyWith(color: primarySwatch[300]),
      headline5: textTheme.headline5.copyWith(color: primarySwatch),
    ),
    primaryColor: primarySwatch,
    primaryColorBrightness: ThemeData.estimateBrightnessForColor(primarySwatch),
    primaryColorLight: primarySwatch[100],
    primaryColorDark: primaryColorDark,
    toggleableActiveColor: primarySwatch[600],
    accentColor: accentColor,
    primaryIconTheme: IconThemeData.fallback().copyWith(color: Colors.yellow),
    secondaryHeaderColor: primarySwatch[50],
    textSelectionTheme: theme.textSelectionTheme.copyWith(
      selectionColor: primarySwatch[100],
      selectionHandleColor: primarySwatch[300],
      cursorColor: primarySwatch[600],
    ),
    backgroundColor: primarySwatch[200],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primarySwatch,
      primaryColorDark: primarySwatch[700],
      accentColor: accentColor,
      cardColor: Colors.white,
    ),
  );

  print('CursorColor: ${a.textSelectionTheme.cursorColor}');
  print('SelectionColor: ${a.textSelectionTheme.selectionColor}');
  print('SelectionHandleColor: ${a.textSelectionTheme.selectionHandleColor}');

  return a;
}
