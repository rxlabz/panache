import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_services/panache_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:panache_ui/panache_ui.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'https://www.googleapis.com/auth/drive.file'],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localData = LocalData();
  await localData.init();
  final dir = await getApplicationDocumentsDirectory();

  final themeModel = ThemeModel(
      localData: localData,
      service: IOThemeService(
        themeExporter: exportTheme,
        dirProvider: getApplicationDocumentsDirectory,
      ),
      screenService: LocalScreenshotService(dir));

  runApp(PanacheApp(themeModel: themeModel));
}

class PanacheApp extends StatelessWidget {
  final ThemeModel themeModel;

  const PanacheApp({Key key, @required this.themeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScopedModel<ThemeModel>(
      model: themeModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(theme, panachePrimarySwatch),
        home: LaunchScreen(model: themeModel),
        routes: {
          '/home': (context) => LaunchScreen(model: themeModel),
          '/editor': (context) => PanacheEditorScreen(),
        },
      ),
    );
  }
}

exportTheme(String code, String filename) async {
  var dir = await getApplicationDocumentsDirectory();
  final themeFile = File('${dir.path}/themes/$filename.dart');
  //print('exportTheme... ${themeFile.path}');
  themeFile.createSync(recursive: true);
  themeFile.writeAsStringSync(code);
}
