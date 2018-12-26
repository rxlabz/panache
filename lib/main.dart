import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_lib/panache_lib.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final themeModel =
      ThemeModel(service: ThemeService(themeExporter: exportTheme));

  runApp(
    ScopedModel<ThemeModel>(
      model: themeModel,
      child: MaterialApp(
        theme: panacheTheme,
        home: LaunchScreen(),
        routes: {
          '/home': (context) => LaunchScreen(),
          '/editor': (context) => PanacheEditorScreen(),
        },
      ),
    ),
  );
}

exportTheme(String code, String filename) async {
  var dir = await getApplicationDocumentsDirectory();
  final themeFile = File('${dir.path}/themes/$filename.dart');
  print('exportTheme... ${themeFile.path}');
  themeFile.createSync(recursive: true);
  themeFile.writeAsStringSync(code);
}
