import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/panache_ui.dart';
import 'package:panache_web/src/web_link_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';

import 'src/theme_exporter_web.dart';
import 'src/web_local_data.dart';
import 'src/web_theme_service.dart';

void main() async {
  clearPersisted();
  final localData = WebLocalData();
  await localData.init();

  final themeModel = ThemeModel(
    localData: localData,
    service: WebThemeService(
      themeExporter: exportTheme,
      dirProvider: null,
    ),
  );

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
          theme: /*panacheTheme*/ buildAppTheme(theme, panachePrimarySwatch),
          home: LaunchScreen(model: themeModel),
          routes: {
            '/home': (context) => LaunchScreen(model: themeModel),
            '/editor': (context) => PanacheEditorScreen(),
          },
        ),
        providers: <SingleChildCloneableWidget>[
          Provider<LinkService>.value(value: WebLinkService())
        ],
      ),
    );
  }
}

exportTheme(String code, String filename) async {
  // print('exportTheme... $code');
  jsSaveTheme(code, filename, (success) => print('export $success'));
}
