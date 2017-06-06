import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/flutterial.dart';
import 'package:flutterial_components/flutterial_components.dart';

void main() {
  runApp(new MaterialApp(
      theme: flutterialTheme,
      home: new Scaffold(
        body: new FlutterialApp(service: new ThemeService()),
      )));
}

final flutterialTheme =
    new ThemeData.light().copyWith(accentColor: Colors.blueGrey);
