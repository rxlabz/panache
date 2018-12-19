import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/flutterial.dart';
import 'package:flutterial_components/flutterial_components.dart';
import 'package:scoped_model/scoped_model.dart';

const primarySwatch = Colors.blueGrey;

final _flutterialTheme = ThemeData.localize(
  ThemeData(
    primarySwatch: primarySwatch,
    textTheme: Typography.blackCupertino.copyWith(
      subtitle: Typography.blackCupertino.subtitle
          .copyWith(color: primarySwatch.shade400),
      title: Typography.blackCupertino.title
          .copyWith(color: primarySwatch.shade300),
      headline:
          Typography.blackCupertino.headline.copyWith(color: primarySwatch),
    ), /*
    primaryTextTheme: Typography.englishLike2018.copyWith(
        subtitle: Typography.englishLike2018.subtitle
            .copyWith(color: primarySwatch.shade400)),
    accentTextTheme: Typography.englishLike2018.copyWith(
        subtitle: Typography.englishLike2018.subtitle
            .copyWith(color: primarySwatch.shade400)),*/
  ),
  Typography.blackCupertino,
);

void main() {
  final themeModel = ThemeModel(service: ThemeService());

  runApp(
    ScopedModel<ThemeModel>(
      model: themeModel,
      child: MaterialApp(
        theme: _flutterialTheme,
        home: Scaffold(
          body: FlutterialApp(),
        ),
      ),
    ),
  );
}
