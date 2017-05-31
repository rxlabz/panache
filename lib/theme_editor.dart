import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/color_widgets.dart';

const double kPadding = 8.0;

class ThemeEditor extends StatefulWidget {
  final ThemeData currentTheme;
  final ValueChanged<ThemeData> themeChangedHandler;
  final ValueChanged<bool> onTargetChanged;
  final bool androidMode;
  final ValueChanged<bool> onBaseThemeChanged;
  final bool hasDarkBase;

  final ColorChanged updatePrimaryColor;
  final ValueChanged<bool> onPrimaryBrightnessChanged;
  final ColorChanged updateAccentColor;
  final ValueChanged<bool> onAccentBrightnessChanged;
  final ColorChanged updateScaffoldBGColor;
  final ValueChanged<bool> onBrightnessChanged;
  final ColorChanged updateDividerColor;
  final ColorChanged updateButtonColor;
  final ColorChanged updateCanvasColor;
  final ColorChanged updateCardColor;
  final ColorChanged updateDisabledColor;
  final ColorChanged updateBackgroundColor;
  final ColorChanged updateHighlightColor;
  final ColorChanged updateSplashColor;
  final ColorChanged updateIndicatorColor;
  final ColorChanged updateSelectedRowColor;
  final ColorChanged updateUnselectedWidgetColor;
  final ColorChanged updateSecondaryHeaderColor;
  final ColorChanged updateTextSelectionColor;
  final ColorChanged updateDialogBackgroundColor;
  final ColorChanged updateHintColor;
  final ColorChanged updateErrorColor;
  final ColorChanged updateTextSelectionHandleColor;

  ThemeEditor({
    @required this.currentTheme,
    @required this.themeChangedHandler,
    @required this.onTargetChanged,
    @required this.androidMode,
    @required this.onBaseThemeChanged,
    @required this.updatePrimaryColor,
    @required this.updateAccentColor,
    @required this.updateScaffoldBGColor,
    @required this.hasDarkBase,
    @required this.updateDividerColor,
    @required this.updateButtonColor,
    @required this.updateCanvasColor,
    @required this.updateCardColor,
    @required this.updateDisabledColor,
    @required this.updateBackgroundColor,
    @required this.updateHighlightColor,
    @required this.updateSplashColor,
    @required this.updateIndicatorColor,
    @required this.onPrimaryBrightnessChanged,
    @required this.onAccentBrightnessChanged,
    @required this.onBrightnessChanged,
    @required this.updateSelectedRowColor,
    @required this.updateUnselectedWidgetColor,
    @required this.updateSecondaryHeaderColor,
    @required this.updateTextSelectionColor,
    @required this.updateDialogBackgroundColor,
    @required this.updateHintColor,
    @required this.updateErrorColor,
    @required this.updateTextSelectionHandleColor,
  });

  @override
  State<StatefulWidget> createState() => new ThemeEditorState(currentTheme);
}

class ThemeEditorState extends State<ThemeEditor> {
  bool colorPanelExpanded = true;
  bool textPanelExpanded = false;
  bool primaryTextPanelExpanded = false;
  bool accentTextPanelExpanded = false;
  ThemeData theme;

  final h3 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.blueGrey);

  ThemeEditorState(this.theme);

  @override
  void didUpdateWidget(ThemeEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    theme = widget.currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    print(
        'ThemeEditorState.build => widget.currentTheme.textTheme.body1.fontSize,'
        ' ${widget.currentTheme.textTheme.body1.fontSize}');
    return new Container(
        color: Colors.grey.shade200,
        child: new Padding(
            padding: new EdgeInsets.only(top: 24.0),
            child: new ListView(
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: _buildGlobalOptionsBar()),
                new ExpansionPanelList(
                    expansionCallback: onExpansionPanelUpdate,
                    children: [
                      _buildColorsPanel(),
                      _buildTextPanel(),
                      /*_buildPrimaryTextPanel(),*/
                    ])
              ],
            )));
  }

  _buildGlobalOptionsBar() => new Row(children: [
        new Text('Platform Android'),
        new Switch(
            onChanged: widget.onTargetChanged, value: widget.androidMode),
        new Text('iOS'),
        new Expanded(child: new Container()),
        new Text('Base Theme : Light'),
        new Switch(
            onChanged: widget.onBaseThemeChanged, value: widget.hasDarkBase),
        new Text('Dark'),
        new Expanded(child: new Container()),
      ]);

  onExpansionPanelUpdate(int panelIndex, bool isExpanded) => setState(() {
        switch (panelIndex) {
          case 0:
            colorPanelExpanded = !isExpanded;
            return;
          case 1:
            textPanelExpanded = !isExpanded;
            return;
          case 2:
            primaryTextPanelExpanded = !isExpanded;
            return;
          case 3:
            accentTextPanelExpanded = !isExpanded;
            return;
          default:
            return;
        }
      });

  _buildTextPanel() => new ExpansionPanel(
      isExpanded: textPanelExpanded,
      headerBuilder: (context, isExpanded) => new Center(
              child: new Row(children: [
            new Icon(
              Icons.font_download,
              color: Colors.grey,
            ),
            new Text(
              'Text Theme',
              style: Theme.of(context).textTheme.headline,
            ),
          ])),
      body: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            children: getTextThemeEditorChildren(),
          )));

  _buildPrimaryTextPanel() => new ExpansionPanel(
      isExpanded: primaryTextPanelExpanded,
      headerBuilder: (context, isExpanded) => new Center(
              child: new Row(children: [
            new Icon(
              Icons.font_download,
              color: theme.primaryColor,
            ),
            new Text(
              'Primary Text Theme',
              style: Theme.of(context).textTheme.headline,
            ),
          ])),
      body: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            children: getTextThemeEditorChildren(),
          )));

  _getTextThemeForm(
    String label, {
    @required ColorChanged onColorChanged,
    @required ValueChanged<double> onSizeChanged,
    @required ValueChanged<bool> onWeightChanged,
    @required ValueChanged<bool> onFontStyleChanged,
    @required Color colorValue,
    @required double fontSize,
    @required bool isBold,
    @required bool isItalic,
  }) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Align(
            alignment: FractionalOffset.centerLeft,
            child: new Text(
              label,
              style: h3,
              textAlign: TextAlign.left,
            )),
        getFieldRow(getColorSelector('Color', colorValue, onColorChanged),
            getSizeSelector(fontSize, onSizeChanged, min: 8.0)),
        getFieldRow(
            new Row(
              children: <Widget>[
                new Text('FontWeight : Normal '),
                new Switch(value: isBold, onChanged: onWeightChanged),
                new Text(' Bold'),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text('FontStyle: Normal '),
                new Switch(value: isItalic, onChanged: onFontStyleChanged),
                new Text(' Italic'),
              ],
            )),
      ],
    );
  }

  _buildColorsPanel() => new ExpansionPanel(
      isExpanded: colorPanelExpanded,
      headerBuilder: (context, isExpanded) => new ExpanderHeader(
            icon: Icons.color_lens,
            color: theme.primaryColor,
            label: 'Colors',
          ),
      body: new Padding(
          padding: new EdgeInsets.all(kPadding),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getColorBrightnessSelector(
                  label: 'Primary color',
                  currentColor: widget.currentTheme.primaryColor,
                  changeHandler: widget.updatePrimaryColor,
                  isDark: widget.currentTheme.primaryColorBrightness ==
                      Brightness.dark,
                  brightnessChangeHandler: widget.onPrimaryBrightnessChanged),
              getColorBrightnessSelector(
                  label: 'Accent color',
                  currentColor: widget.currentTheme.accentColor,
                  changeHandler: widget.updateAccentColor,
                  isDark: widget.currentTheme.accentColorBrightness ==
                      Brightness.dark,
                  brightnessChangeHandler: widget.onAccentBrightnessChanged),
              getColorBrightnessSelector(
                  label: 'Scaffold background color',
                  currentColor: widget.currentTheme.scaffoldBackgroundColor,
                  changeHandler: widget.updateScaffoldBGColor,
                  isDark: widget.currentTheme.brightness == Brightness.dark,
                  brightnessChangeHandler: widget.onBrightnessChanged),
              getFieldRow(
                getColorSelector('Button color',
                    widget.currentTheme.buttonColor, widget.updateButtonColor),
                getColorSelector(
                    'Divider color',
                    widget.currentTheme.dividerColor,
                    widget.updateDividerColor),
              ),
              getFieldRow(
                getColorSelector('Canvas color',
                    widget.currentTheme.canvasColor, widget.updateCanvasColor),
                getColorSelector('Card color', widget.currentTheme.cardColor,
                    widget.updateCardColor),
              ),
              getFieldRow(
                getColorSelector(
                    'Disabled color',
                    widget.currentTheme.disabledColor,
                    widget.updateDisabledColor),
                getColorSelector(
                    'Background color',
                    widget.currentTheme.backgroundColor,
                    widget.updateBackgroundColor),
              ),
              getFieldRow(
                  getColorSelector(
                      'Highlight color',
                      widget.currentTheme.highlightColor,
                      widget.updateHighlightColor),
                  getColorSelector(
                      'Splash color',
                      widget.currentTheme.splashColor,
                      widget.updateSplashColor)),
              getFieldRow(
                  getColorSelector(
                      'Dialog background color',
                      widget.currentTheme.dialogBackgroundColor,
                      widget.updateDialogBackgroundColor),
                  getColorSelector('Hint color', widget.currentTheme.hintColor,
                      widget.updateHintColor)),
              getFieldRow(
                  getColorSelector('Error color',
                      widget.currentTheme.errorColor, widget.updateErrorColor),
                  getColorSelector(
                      'Indicator color',
                      widget.currentTheme.indicatorColor,
                      widget.updateIndicatorColor)),
              getFieldRow(
                  getColorSelector(
                      'Selected row color',
                      widget.currentTheme.selectedRowColor,
                      widget.updateSelectedRowColor),
                  getColorSelector(
                      'Unselected widget color',
                      widget.currentTheme.unselectedWidgetColor,
                      widget.updateUnselectedWidgetColor)),
              getFieldRow(
                  getColorSelector(
                      'Secondary header widget color',
                      widget.currentTheme.secondaryHeaderColor,
                      widget.updateSecondaryHeaderColor),
                  getColorSelector(
                      'Text selection color',
                      widget.currentTheme.textSelectionColor,
                      widget.updateTextSelectionColor)),
              getColorSelector(
                  'Text selection handler color',
                  widget.currentTheme.textSelectionHandleColor,
                  widget.updateTextSelectionHandleColor),
            ],
          )));

  Widget getColorBrightnessSelector(
          {String label,
          Color currentColor,
          ColorChanged changeHandler,
          /*String label, */ bool isDark,
          ValueChanged<bool> brightnessChangeHandler}) =>
      new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Expanded(
                child: getColorSelector(label, currentColor, changeHandler)),
            new Expanded(
                child: getBrightnessSelector(
                    label: 'Brightness',
                    isDark: isDark,
                    changeHandler: brightnessChangeHandler))
          ]);

  Widget getFieldRow(w1, w2) => new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[new Expanded(child: w1), new Expanded(child: w2)],
      );

  ColorSelector getColorSelector(
          String label, Color value, ColorChanged changeHandler) =>
      new ColorSelector(label: label, value: value, onSelection: changeHandler);

  BrightnessSelector getBrightnessSelector(
          {String label, bool isDark, ValueChanged<bool> changeHandler}) =>
      new BrightnessSelector(
          label: label, isDark: isDark, onChange: changeHandler);

  List<Widget> getTextThemeEditorChildren() => <Widget>[
        _getTextThemeForm('Body 1',
            colorValue: widget.currentTheme.textTheme.body1.color,
            fontSize: widget.currentTheme.textTheme.body1.fontSize,
            isBold: widget.currentTheme.textTheme.body1.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.body1.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body1: widget.currentTheme.textTheme.body1
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body1: widget.currentTheme.textTheme.body1
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body1: widget.currentTheme.textTheme.body1.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body1: widget.currentTheme.textTheme.body1.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Body 2',
            colorValue: widget.currentTheme.textTheme.body2.color,
            fontSize: widget.currentTheme.textTheme.body2.fontSize,
            isBold: widget.currentTheme.textTheme.body2.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.body2.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body2: widget.currentTheme.textTheme.body2
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body2: widget.currentTheme.textTheme.body2
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body2: widget.currentTheme.textTheme.body2.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    body2: widget.currentTheme.textTheme.body2.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Headline',
            colorValue: widget.currentTheme.textTheme.headline.color,
            fontSize: widget.currentTheme.textTheme.headline.fontSize,
            isBold: widget.currentTheme.textTheme.headline.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.headline.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    headline: widget.currentTheme.textTheme.headline
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    headline: widget.currentTheme.textTheme.headline
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    headline: widget.currentTheme.textTheme.headline.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    headline: widget.currentTheme.textTheme.headline.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Subhead',
            colorValue: widget.currentTheme.textTheme.subhead.color,
            fontSize: widget.currentTheme.textTheme.subhead.fontSize,
            isBold: widget.currentTheme.textTheme.subhead.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.subhead.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    subhead: widget.currentTheme.textTheme.subhead
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    subhead: widget.currentTheme.textTheme.subhead
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    subhead: widget.currentTheme.textTheme.subhead.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    subhead: widget.currentTheme.textTheme.subhead.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Title',
            colorValue: widget.currentTheme.textTheme.title.color,
            fontSize: widget.currentTheme.textTheme.title.fontSize,
            isBold: widget.currentTheme.textTheme.title.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.title.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    title: widget.currentTheme.textTheme.title
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    title: widget.currentTheme.textTheme.title
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    title: widget.currentTheme.textTheme.title.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    title: widget.currentTheme.textTheme.title.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Button',
            colorValue: widget.currentTheme.textTheme.button.color,
            fontSize: widget.currentTheme.textTheme.button.fontSize,
            isBold: widget.currentTheme.textTheme.button.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.button.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    button: widget.currentTheme.textTheme.button
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    button: widget.currentTheme.textTheme.button
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    button: widget.currentTheme.textTheme.button.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    button: widget.currentTheme.textTheme.button.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Display 1',
            colorValue: widget.currentTheme.textTheme.display1.color,
            fontSize: widget.currentTheme.textTheme.display1.fontSize,
            isBold: widget.currentTheme.textTheme.display1.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.display1.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display1: widget.currentTheme.textTheme.display1
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display1: widget.currentTheme.textTheme.display1
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display1: widget.currentTheme.textTheme.display1.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display1: widget.currentTheme.textTheme.display1.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Display 2',
            colorValue: widget.currentTheme.textTheme.display2.color,
            fontSize: widget.currentTheme.textTheme.display2.fontSize,
            isBold: widget.currentTheme.textTheme.display2.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.display2.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display2: widget.currentTheme.textTheme.display2
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display2: widget.currentTheme.textTheme.display2
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display2: widget.currentTheme.textTheme.display2.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display2: widget.currentTheme.textTheme.display2.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Display 3',
            colorValue: widget.currentTheme.textTheme.display3.color,
            fontSize: widget.currentTheme.textTheme.display3.fontSize,
            isBold: widget.currentTheme.textTheme.display3.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.display3.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display3: widget.currentTheme.textTheme.display3
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display3: widget.currentTheme.textTheme.display3
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display3: widget.currentTheme.textTheme.display3.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display3: widget.currentTheme.textTheme.display3.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
        _getTextThemeForm('Display 4',
            colorValue: widget.currentTheme.textTheme.display4.color,
            fontSize: widget.currentTheme.textTheme.display4.fontSize,
            isBold: widget.currentTheme.textTheme.display4.fontWeight ==
                FontWeight.bold,
            isItalic: widget.currentTheme.textTheme.display4.fontStyle ==
                FontStyle.italic, onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display4: widget.currentTheme.textTheme.display4
                        .copyWith(color: c)));
            widget.themeChangedHandler(theme);
          });
        }, onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display4: widget.currentTheme.textTheme.display4
                        .copyWith(fontSize: s)));
            widget.themeChangedHandler(theme);
          });
        }, onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display4: widget.currentTheme.textTheme.display4.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
            widget.themeChangedHandler(theme);
          });
        }, onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: widget.currentTheme.textTheme.copyWith(
                    display4: widget.currentTheme.textTheme.display4.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            widget.themeChangedHandler(theme);
          });
        }),
      ];
}

SizeSelector getSizeSelector(value, onValueChanged, {min: 0.0, max: 112.0}) =>
    new SizeSelector(value, onValueChanged, min, max);

class SizeSelector extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onValueChanged;

  SizeSelector(this.value, this.onValueChanged, this.min, this.max);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          new Text("Font size"),
          new ConstrainedBox(
              constraints: new BoxConstraints(maxWidth: 120.0),
              child: new Slider(
                value: value,
                onChanged: onValueChanged,
                min: min,
                max: max,
              )),
          new Text("${value.toStringAsFixed(1)}"),
        ],
      ),
    );
  }
}

class ExpanderHeader extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  ExpanderHeader(
      {@required this.color, @required this.label, @required this.icon});

  @override
  Widget build(BuildContext context) => new Row(children: [
        new Icon(
          icon,
          color: color,
        ),
        new Text(
          label,
          style: Theme.of(context).textTheme.headline,
        ),
      ]);
}
