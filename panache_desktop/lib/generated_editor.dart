import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_desktop/services/theme_preview.dart';
import 'package:panache_ui/panache_ui.dart';

import 'package:quiver/iterables.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(ProtoEditor());
}

class ProtoEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: ProtoEditorScreen());
}

class ProtoEditorScreen extends StatefulWidget {
  @override
  _ProtoEditorScreenState createState() => _ProtoEditorScreenState();
}

class _ProtoEditorScreenState extends State<ProtoEditorScreen> {
  Iterable<PanelConfiguration> themePanels;
  PanacheTheme theme;

  final ThemeFieldFactory _fieldFactory;

  _ProtoEditorScreenState() : _fieldFactory = ThemeFieldFactory();

  @override
  void initState() {
    themePanels = themeEditorConfiguration;

    theme = PanacheTheme(
      id: '123',
      name: 'Un theme',
      primarySwatch: Colors.cyan,
      brightness: Brightness.light,
      config: ThemeConfiguration(),
    )..addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: ExpansionPanelList(
                children: themePanels.map(_buildThemePanel).toList(),
                expansionCallback: (activeIndex, state) {
                  setState(() {
                    themePanels = enumerate(themeEditorConfiguration).map(
                      (item) => item.index == activeIndex
                          ? (item.value..closed = state)
                          : item.value,
                    );
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ThemePreview(theme:theme),
          )
        ],
      ),
    );
  }

  ExpansionPanel _buildThemePanel(PanelConfiguration config) {
    return ExpansionPanel(
      isExpanded: !config.closed,
      headerBuilder: (context, isExpanded) => Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(config.label),
        ),
      ]),
      body: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: config.properties
              .map((key, value) {
                final propertyValue = theme['${config.id}.$key'];
                return _themePropertyToField(
                    key, config.id, value, propertyValue);
              })
              .values
              .toList(),
        ),
      ),
    );
  }

  MapEntry<String, Widget> _themePropertyToField(
    String key,
    String panelId,
    PropertyDescription propertyDescription,
    dynamic propertyValue,
  ) =>
      MapEntry(
          key,
          _fieldFactory.build(
            key,
            panelId,
            propertyDescription,
            propertyValue,
            theme.updateTheme,
          ));
}

