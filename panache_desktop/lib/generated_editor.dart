import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/panache_ui.dart';

import 'package:quiver/iterables.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(ProtoEditor());
}

class ProtoEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProtoEditorScreen(),
    );
  }
}

class ProtoEditorScreen extends StatefulWidget {
  @override
  _ProtoEditorScreenState createState() => _ProtoEditorScreenState();
}

class _ProtoEditorScreenState extends State<ProtoEditorScreen> {
  Iterable<PanelConfiguration> themePanels;
  PanacheTheme theme;

  @override
  void initState() {
    themePanels = themeEditorConfiguration;

    theme = PanacheTheme(
      id: '123',
      name: 'Un theme',
      primarySwatch: Colors.cyan,
      brightness: Brightness.light,
      config: ThemeConfiguration(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          children: themePanels.map(_buildThemePanel).toList(),
          expansionCallback: (activeIndex, state) {
            print('ProtoEditorScreen.build... $activeIndex $state');
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
    );
  }

  ExpansionPanel _buildThemePanel(PanelConfiguration config) {
    return ExpansionPanel(
      isExpanded: !config.closed,
      headerBuilder: (context, isExpanded) => Row(children: <Widget>[
        Text(config.label),
      ]),
      body: Column(
        children: config.properties.map(_themePropertyToField).values.toList(),
      ),
    );
  }

  MapEntry<String, Widget> _themePropertyToField(String key, Type value) =>
      MapEntry(key, fieldForType(key, value));
}

fieldForType(String label, Type value) {
  switch (value) {
    case Color:
      return ColorSelector(label, Color(0xFFFF0000), (c) => print('COLOR $c'));
    case Brightness:
      return Text('Brightness');
    default:
      return Text('...');
  }
}
