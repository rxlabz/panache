import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_services/panache_services.dart';
import 'package:panache_ui/panache_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'services/desktop_local_data.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();

  final localData = DesktopLocalStorage();
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

exportTheme(String code, [String filename = 'theme']) async {
  final dir = await getApplicationDocumentsDirectory();
  final themeFile = File('${dir.path}/themes/$filename.dart');
  print('exportTheme... ${themeFile.path}');
  themeFile.createSync(recursive: true);
  themeFile.writeAsStringSync(code);
}

class DesktopCloudService implements CloudService {
  @override
  Future<bool> get authenticated => Future.value(true);

  @override
  // TODO: implement currentUser$
  Stream<User> get currentUser$ => null;

  @override
  Future login() {
    print('DesktopCloudService.login... ');
    // TODO: implement login
    return null;
  }

  @override
  Future logout() {
    print('DesktopCloudService.logout... ');
    // TODO: implement logout
    return null;
  }

  @override
  Future save(String content) {
    print('DesktopCloudService.save... ');
    // TODO: implement save
    return null;
  }
}
