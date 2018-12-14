import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/flutterial.dart';
import 'package:flutterial/theme_model.dart';
import 'package:flutterial_components/flutterial_components.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final themeModel = ThemeModel(service: ThemeService());

  runApp(
    ScopedModel<ThemeModel>(
      model: themeModel,
      child: MaterialApp(
        home: Scaffold(
          body: FlutterialApp(),
        ),
      ),
    ),
  );
}
