import 'package:flutter/material.dart';

const panachePrimarySwatch = Colors.blueGrey;

/*final panacheTheme = ThemeData.localize(
  ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: panachePrimarySwatch,
      textTheme: Typography.blackCupertino.copyWith(
        body1: Typography.blackCupertino.body1.copyWith(fontSize: 12),
        body2: Typography.blackCupertino.body2.copyWith(fontSize: 12),
        subtitle: Typography.blackCupertino.subtitle
            .copyWith(color: panachePrimarySwatch.shade400, fontSize: 12),
        title: Typography.blackCupertino.title
            .copyWith(color: panachePrimarySwatch.shade300),
        headline: Typography.blackCupertino.headline
            .copyWith(color: panachePrimarySwatch),
      ),
      primaryIconTheme: IconThemeData.fallback().copyWith(color: Colors.yellow),
      sliderTheme: ThemeData.light().sliderTheme),
  Typography.blackCupertino,
);*/

ThemeData buildAppTheme(ThemeData theme, MaterialColor primarySwatch) {
  final textTheme = theme.textTheme;
  final accentColor = primarySwatch[500];
  final primaryColorDark = primarySwatch[700];

  return theme.copyWith(
    textTheme: textTheme.copyWith(
      body1: textTheme.body1.copyWith(fontSize: 12),
      body2: textTheme.body2.copyWith(fontSize: 12),
      subtitle:
          textTheme.subtitle.copyWith(color: primarySwatch[400], fontSize: 12),
      title: textTheme.title.copyWith(color: primarySwatch[300]),
      headline: textTheme.headline.copyWith(color: primarySwatch),
    ),
    primaryColor: primarySwatch,
    primaryColorBrightness: ThemeData.estimateBrightnessForColor(primarySwatch),
    primaryColorLight: primarySwatch[100],
    primaryColorDark: primaryColorDark,
    toggleableActiveColor: primarySwatch[600],
    accentColor: accentColor,
    primaryIconTheme: IconThemeData.fallback().copyWith(color: Colors.yellow),
    secondaryHeaderColor: primarySwatch[50],
    textSelectionColor: primarySwatch[200],
    textSelectionHandleColor: primarySwatch[300],
    backgroundColor: primarySwatch[200],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primarySwatch,
      primaryColorDark: primarySwatch[700],
      accentColor: accentColor,
      cardColor: Colors.white,
    ),
  );
}
