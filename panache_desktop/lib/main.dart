import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_services/panache_services.dart';
import 'package:panache_ui/panache_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:window_size/window_size.dart';

import 'services/desktop_export_service.dart';
import 'services/desktop_local_data.dart';
import 'services/io_link_service.dart';

const double _preferedWindowWidth = 1280;
const double _preferedWindowHeight = 1024;

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();

  final windowInfos = await getWindowInfo();

  // TODO new userPref : last window frame
  setWindowFrame(Rect.fromPoints(
    Offset.zero,
    Offset(
      min(_preferedWindowWidth, windowInfos.screen.visibleFrame.width),
      min(_preferedWindowHeight, windowInfos.screen.visibleFrame.height),
    ),
  ));

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
      child: MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(theme, panachePrimarySwatch),
          home: LaunchScreen(model: themeModel),
          routes: {
            '/home': (context) => LaunchScreen(model: themeModel),
            '/editor': (context) => PanacheEditorScreen(),
          },
        ),
        providers: <SingleChildCloneableWidget>[
          Provider<LinkService>.value(value: IOLinkService()),
          ChangeNotifierProvider<ExportService>.value(
              value: DesktopExportService())
        ],
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
