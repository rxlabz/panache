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
      body: SingleChildScrollView(
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
    Type propertyType,
    dynamic propertyValue,
  ) =>
      MapEntry(
          key,
          _fieldFactory.build(
            key,
            panelId,
            propertyType,
            propertyValue,
            theme.updateTheme,
          ));
}

class ThemeFieldFactory {
  Widget build(
    String propertyName,
    String panelId,
    Type fieldContentType,
    dynamic propertyValue,
    Function(String name, String panelId, dynamic value) onChange,
  ) {
    switch (fieldContentType) {
      case Color:
        return ColorSelector(propertyName, propertyValue ?? Color(0x00000000),
            (color) => onChange(propertyName, panelId, color));

      case Brightness:
        return BrightnessSelector(
          label: propertyName,
          isDark:
              propertyValue != null ? propertyValue == Brightness.dark : false,
        );

      case ButtonTextTheme:
        return EnumDropDownField<ButtonTextTheme>(
          fieldValue: propertyValue,
          fieldOptions: ButtonTextTheme.values,
          onChange: (textTheme) => onChange(propertyName, panelId, textTheme),
        );

      case ButtonBarLayoutBehavior:
        return EnumDropDownField<ButtonBarLayoutBehavior>(
          fieldValue: propertyValue,
          fieldOptions: ButtonBarLayoutBehavior.values,
          onChange: (behavior) => onChange(propertyName, panelId, behavior),
        );

      case double:
      /*case int:*/
        return SliderPropertyControl(
          propertyValue,
          (value) => onChange(propertyName, panelId, value),
          label: propertyName,
        );

      case EdgeInsetsGeometry:
        return SliderPropertyControl(
          (propertyValue as EdgeInsetsGeometry)?.horizontal ?? 4
              /*const EdgeInsets.all(4)*/,
          (value) => onChange(
              propertyName, panelId, EdgeInsets.symmetric(horizontal: value)),
          label: propertyName,
        );

      case bool:
        return SwitcherControl(
          label: propertyName,
          /* FIXME checkedLabel: propertyValue,*/
          checked: propertyValue,
          onChange: (value) => onChange(propertyName, panelId, value),
        );

      case ShapeBorder:
        return ShapeFormControl(
          shape: propertyValue,
          onShapeChanged: (value) => onChange(propertyName, panelId, value),
        );

      case TextStyle:
        print('ThemeFieldFactory.build... $propertyName $propertyValue');
        return TextStyleControl(
          propertyName,
          style: propertyValue,
          onChange: (TextStyle textStyle) =>
              onChange(propertyName, panelId, textStyle),
        );
      default:
        return Text('...');
    }
  }

  DropdownMenuItem<ButtonTextTheme> _buildButtonTextThemeSelectorItem(
          ButtonTextTheme buttonTextTheme) =>
      DropdownMenuItem<ButtonTextTheme>(
        child: Text('$buttonTextTheme'.split('.').last),
        value: buttonTextTheme,
      );
}
