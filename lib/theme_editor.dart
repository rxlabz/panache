import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/color_widgets.dart';
import 'package:flutterial/components/brightness_control.dart';
import 'package:flutterial/components/font_size_slider.dart';
import 'package:flutterial/components/panel_header.dart';
import 'package:flutterial/theme_model.dart';

const EdgeInsets _kPadding = const EdgeInsets.all(8.0);

class ThemeEditor extends StatefulWidget {
  final ThemeData theme;

  ThemeEditor(this.theme);

  @override
  State<StatefulWidget> createState() => ThemeEditorState();
}

const h3 = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.blueGrey);

class ThemeEditorState extends State<ThemeEditor> {
  ThemeModel themeModel;
  ThemeData get theme => widget.theme;

  bool colorPanelExpanded = true;
  bool textPanelExpanded = false;
  bool primaryTextPanelExpanded = false;

  bool accentTextPanelExpanded = false;

  get _isAndroidMode => theme.platform == TargetPlatform.android;

  get _hasDarkBase => theme.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    themeModel = ThemeModel.of(context);
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: EdgeInsets.only(top: 24.0),
        child: ListView(
          children: [
            Padding(
              padding: _kPadding,
              child: _buildGlobalOptionsBar(),
            ),
            ExpansionPanelList(
              expansionCallback: onExpansionPanelUpdate,
              children: [
                _buildColorsPanel(),
                _buildTextPanel(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalOptionsBar() => Row(
        children: [
          Text('Platform: Android'),
          Switch(onChanged: _onTargetChanged, value: _isAndroidMode),
          Text('iOS'),
          Expanded(child: Container()),
          Text('Base Theme: Light'),
          Switch(onChanged: _onBaseThemeChanged, value: _hasDarkBase),
          Text('Dark'),
        ],
      );

  onExpansionPanelUpdate(int panelIndex, bool isExpanded) => setState(
        () {
          switch (panelIndex) {
            case 0:
              colorPanelExpanded = !isExpanded;
              break;
            case 1:
              textPanelExpanded = !isExpanded;
              break;
            case 2:
              primaryTextPanelExpanded = !isExpanded;
              break;
            case 3:
              accentTextPanelExpanded = !isExpanded;
              break;
          }
        },
      );

  ExpansionPanel _buildTextPanel() => ExpansionPanel(
        isExpanded: textPanelExpanded,
        headerBuilder: (context, isExpanded) => ExpanderHeader(
            label: 'Text Theme', icon: Icons.font_download, color: Colors.grey),
        body: Padding(
          padding: _kPadding,
          child: Column(
            children: getTextThemeEditorChildren(),
          ),
        ),
      );

  Widget _getTextThemeForm(
    String label, {
    @required ColorChanged onColorChanged,
    @required ValueChanged<double> onSizeChanged,
    @required ValueChanged<bool> onWeightChanged,
    @required ValueChanged<bool> onFontStyleChanged,
    @required Color colorValue,
    @required double fontSize,
    @required bool isBold,
    @required bool isItalic,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: FractionalOffset.centerLeft,
            child: Text(
              label,
              style: h3,
              textAlign: TextAlign.left,
            ),
          ),
          getFieldRow(
            ColorSelector('Color', colorValue, onColorChanged),
            FontSizeSelector(fontSize, onSizeChanged, min: 8.0),
          ),
          getFieldRow(
            Row(
              children: [
                Text('FontWeight : Normal '),
                Switch(value: isBold, onChanged: onWeightChanged),
                Text(' Bold'),
              ],
            ),
            Row(
              children: [
                Text('FontStyle: Normal '),
                Switch(value: isItalic, onChanged: onFontStyleChanged),
                Text(' Italic'),
              ],
            ),
          ),
        ],
      );

  ExpansionPanel _buildColorsPanel() {
    return ExpansionPanel(
      isExpanded: colorPanelExpanded,
      headerBuilder: (context, isExpanded) => ExpanderHeader(
            icon: Icons.color_lens,
            color: theme.primaryColor,
            label: 'Colors',
          ),
      body: Padding(
        padding: _kPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getColorBrightnessSelector(
                label: 'Primary color',
                currentColor: theme.primaryColor,
                changeHandler: (c) =>
                    updateColor(property: "primaryColor", color: c),
                isDark: theme.primaryColorBrightness == Brightness.dark,
                brightnessChangeHandler: (bool isDark) =>
                    _onPrimaryBrightnessChanged(
                        isDark ? Brightness.dark : Brightness.light)),
            getColorBrightnessSelector(
                label: 'Accent color',
                currentColor: theme.accentColor,
                changeHandler: (c) =>
                    updateColor(property: "accentColor", color: c),
                isDark: theme.accentColorBrightness == Brightness.dark,
                brightnessChangeHandler: (bool isDark) =>
                    _onAccentBrightnessChanged(
                        isDark ? Brightness.dark : Brightness.light)),
            getColorBrightnessSelector(
              label: 'Scaffold background color',
              currentColor: theme.scaffoldBackgroundColor,
              changeHandler: (c) =>
                  updateColor(property: "scaffoldBackgroundColor", color: c),
              isDark: theme.brightness == Brightness.dark,
              brightnessChangeHandler: (isDark) {
                final updatedTheme = theme.copyWith(
                    brightness: isDark ? Brightness.dark : Brightness.light);
                themeModel.updateTheme(updatedTheme);
              },
            ),
            getFieldRow(
              ColorSelector(
                'Button color',
                theme.buttonColor,
                (c) => updateColor(property: "buttonColor", color: c),
              ),
              ColorSelector(
                'Divider color',
                theme.dividerColor,
                (c) => updateColor(property: "dividerColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Canvas color',
                theme.canvasColor,
                (c) => updateColor(property: "canvasColor", color: c),
              ),
              ColorSelector(
                'Card color',
                theme.cardColor,
                (c) => updateColor(property: "cardColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Disabled color',
                theme.disabledColor,
                (c) => updateColor(property: "disabledColor", color: c),
              ),
              ColorSelector(
                'Background color',
                theme.backgroundColor,
                (c) => updateColor(property: "backgroundColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Highlight color',
                theme.highlightColor,
                (c) => updateColor(property: "highlightColor", color: c),
              ),
              ColorSelector(
                'Splash color',
                theme.splashColor,
                (c) => updateColor(property: "splashColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Dialog background color',
                theme.dialogBackgroundColor,
                (c) => updateColor(property: "dialogBackgroundColor", color: c),
              ),
              ColorSelector(
                'Hint color',
                theme.hintColor,
                (c) => updateColor(property: "hintColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Error color',
                theme.errorColor,
                (c) => updateColor(property: "errorColor", color: c),
              ),
              ColorSelector(
                'Indicator color',
                theme.indicatorColor,
                (c) => updateColor(property: "indicatorColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Selected row color',
                theme.selectedRowColor,
                (c) => updateColor(property: "selectedRowColor", color: c),
              ),
              ColorSelector(
                'Unselected widget color',
                theme.unselectedWidgetColor,
                (c) => updateColor(property: "unselectedWidgetColor", color: c),
              ),
            ),
            getFieldRow(
              ColorSelector(
                'Secondary header widget color',
                theme.secondaryHeaderColor,
                (c) => updateColor(property: "secondaryHeaderColor", color: c),
              ),
              ColorSelector(
                'Text selection color',
                theme.textSelectionColor,
                (c) => updateColor(property: "textSelectionColor", color: c),
              ),
            ),
            ColorSelector(
              'Text selection handler color',
              theme.textSelectionHandleColor,
              (c) =>
                  updateColor(property: "textSelectionHandleColor", color: c),
            ),
          ],
        ),
      ),
    );
  }

  void updateColor({String property, Color color}) {
    final args = <Symbol, dynamic>{};
    args[Symbol(property)] = color;
    final updatedTheme = Function.apply(theme.copyWith, null, args);
    themeModel.updateTheme(updatedTheme);
  }

  Widget getColorBrightnessSelector(
          {String label,
          Color currentColor,
          ColorChanged changeHandler,
          bool isDark,
          ValueChanged<bool> brightnessChangeHandler}) =>
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ColorSelector(label, currentColor, changeHandler)),
          Expanded(
              child: BrightnessSelector(
                  label: 'Brightness',
                  isDark: isDark,
                  onChange: brightnessChangeHandler))
        ],
      );

  Widget getFieldRow(w1, w2) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [Expanded(child: w1), Expanded(child: w2)],
      );

  List<Widget> getTextThemeEditorChildren() {
    //final txtTheme = Theme.of(context).textTheme;
    final txtTheme = theme.textTheme;
    final body1 = txtTheme.body1;
    final body2 = txtTheme.body2;
    final headline = txtTheme.headline;
    final subhead = txtTheme.subhead;
    final title = txtTheme.title;
    final button = txtTheme.button;
    final display1 = txtTheme.display1;
    final display2 = txtTheme.display2;
    final display3 = txtTheme.display3;
    final display4 = txtTheme.display4;

    return [
      _getTextThemeForm(
        'Body 1',
        colorValue: body1.color,
        fontSize: body1.fontSize ?? 24,
        isBold: body1.fontWeight == FontWeight.bold,
        isItalic: body1.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(body1: body1.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(body1: body1.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body1: body1.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body1: body1.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Body 2',
        colorValue: body2.color,
        fontSize: body2.fontSize,
        isBold: body2.fontWeight == FontWeight.bold,
        isItalic: body2.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(body2: body2.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(body2: body2.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body2: body2.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body2: body2.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Headline',
        colorValue: headline.color,
        fontSize: headline.fontSize,
        isBold: headline.fontWeight == FontWeight.bold,
        isItalic: headline.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(headline: headline.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(headline: headline.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  headline: headline.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  headline: headline.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Subhead',
        colorValue: subhead.color,
        fontSize: subhead.fontSize,
        isBold: subhead.fontWeight == FontWeight.bold,
        isItalic: subhead.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(subhead: subhead.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(subhead: subhead.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  subhead: subhead.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  subhead: subhead.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Title',
        colorValue: title.color,
        fontSize: title.fontSize,
        isBold: title.fontWeight == FontWeight.bold,
        isItalic: title.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(title: title.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(title: title.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  title: title.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  title: title.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Button',
        colorValue: button.color,
        fontSize: button.fontSize,
        isBold: button.fontWeight == FontWeight.bold,
        isItalic: button.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(button: button.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(button: button.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  button: button.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  button: button.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Display 1',
        colorValue: display1.color,
        fontSize: display1.fontSize,
        isBold: display1.fontWeight == FontWeight.bold,
        isItalic: display1.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display1: display1.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display1: display1.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display1: display1.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display1: display1.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Display 2',
        colorValue: display2.color,
        fontSize: display2.fontSize,
        isBold: display2.fontWeight == FontWeight.bold,
        isItalic: display2.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display2: display2.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display2: display2.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display2: display2.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display2: display2.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Display 3',
        colorValue: display3.color,
        fontSize: display3.fontSize,
        isBold: display3.fontWeight == FontWeight.bold,
        isItalic: display3.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display3: display3.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display3: display3.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display3: display3.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display3: display3.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
      _getTextThemeForm(
        'Display 4',
        colorValue: display4.color,
        fontSize: display4.fontSize,
        isBold: display4.fontWeight == FontWeight.bold,
        isItalic: display4.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display4: display4.copyWith(color: c)));
          themeModel.updateTheme(updatedTheme);
        },
        onSizeChanged: (s) {
          final updatedTheme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display4: display4.copyWith(fontSize: s)));
          themeModel.updateTheme(updatedTheme);
        },
        onWeightChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display4: display4.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          themeModel.updateTheme(updatedTheme);
        },
        onFontStyleChanged: (v) {
          final updatedTheme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display4: display4.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          themeModel.updateTheme(updatedTheme);
        },
      ),
    ];
  }

  void _onTargetChanged(bool targetAndroid) => themeModel.updateTheme(
        targetAndroid
            ? theme.copyWith(platform: TargetPlatform.android)
            : theme.copyWith(platform: TargetPlatform.iOS),
      );

  void _onBaseThemeChanged(bool darkMode) => ThemeData.localize(
      darkMode ? ThemeData.dark() : ThemeData.light(), theme.textTheme);

  void _onPrimaryBrightnessChanged(Brightness brightness) =>
      theme.copyWith(primaryColorBrightness: brightness);

  void _onAccentBrightnessChanged(Brightness brightness) =>
      theme.copyWith(primaryColorBrightness: brightness);
}
