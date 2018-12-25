import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial_components/flutterial_components.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'flutterial.dart';

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
    ),
    primaryIconTheme: IconThemeData.fallback().copyWith(color: Colors.yellow),
  ),
  Typography.blackCupertino,
);

void main() async {
  final appDir = await getApplicationDocumentsDirectory();
  final themeModel = ThemeModel(service: ThemeService(dir: appDir));

  runApp(
    ScopedModel<ThemeModel>(
      model: themeModel,
      child: MaterialApp(
        theme: _flutterialTheme,
        home: LaunchScreen(),
        routes: {
          '/home': (context) => LaunchScreen(),
          '/editor': (context) => PanacheEditorScreen(),
        },
      ),
    ),
  );
}
