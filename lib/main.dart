import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/flutterial.dart';
import 'package:flutterial_components/flutterial_components.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: FlutterialApp(service: ThemeService()),
      ),
    ),
  );
}
