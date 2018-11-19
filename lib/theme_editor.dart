import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial/color_widgets.dart';
import 'package:flutterial/components/panel_header.dart';
import 'package:flutterial_components/flutterial_components.dart';

const double kPadding = 8.0;

class ThemeEditor extends StatefulWidget {
  final ThemeService service;
  ThemeData get currentTheme => service.theme;
  final ValueChanged<ThemeData> themeChangedHandler;
  final ValueChanged<bool> onTargetChanged;
  final bool androidMode;
  final ValueChanged<bool> onBaseThemeChanged;
  final bool hasDarkBase;
  final ValueChanged<bool> onPrimaryBrightnessChanged;
  final ValueChanged<bool> onAccentBrightnessChanged;

  ThemeEditor({
    @required this.service,
    @required this.themeChangedHandler,
    @required this.onBaseThemeChanged,
    @required this.hasDarkBase,
    @required this.onTargetChanged,
    @required this.androidMode,
    @required this.onPrimaryBrightnessChanged,
    @required this.onAccentBrightnessChanged,
  });

  @override
  State<StatefulWidget> createState() => ThemeEditorState(service);
}

const h3 = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.blueGrey);

class ThemeEditorState extends State<ThemeEditor> {
  final ThemeService service;

  bool colorPanelExpanded = true;
  bool textPanelExpanded = false;
  bool primaryTextPanelExpanded = false;
  bool accentTextPanelExpanded = false;
  ThemeData _theme;

  ThemeData get theme => _theme;

  set theme(ThemeData theme) {
    _theme = theme;
    widget.themeChangedHandler(theme);
  }

  ThemeEditorState(this.service);

  @override
  void initState() {
    super.initState();
    service.themeNotifier.addListener(
      () => setState(
            () {
              _theme = service.themeNotifier.value;
            },
          ),
    );
  }

  @override
  void didUpdateWidget(ThemeEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    _theme = widget.currentTheme;
  }

  @override
  Widget build(BuildContext context) => theme == null
      ? Center(child: Text("loading"))
      : Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
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

  Widget _buildGlobalOptionsBar() => Row(
        children: [
          Text('Platform Android'),
          Switch(onChanged: widget.onTargetChanged, value: widget.androidMode),
          Text('iOS'),
          Expanded(child: Container()),
          Text('Base Theme : Light'),
          Switch(
              onChanged: widget.onBaseThemeChanged, value: widget.hasDarkBase),
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
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: getTextThemeEditorChildren(),
          )));

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
            getColorSelector('Color', colorValue, onColorChanged),
            getSizeSelector(fontSize, onSizeChanged, min: 8.0),
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
    final currentTheme = widget.currentTheme;
    return ExpansionPanel(
      isExpanded: colorPanelExpanded,
      headerBuilder: (context, isExpanded) => ExpanderHeader(
            icon: Icons.color_lens,
            color: currentTheme.primaryColor,
            label: 'Colors',
          ),
      body: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getColorBrightnessSelector(
                label: 'Primary color',
                currentColor: currentTheme.primaryColor,
                changeHandler: (c) =>
                    updateColor(property: "primaryColor", color: c),
                isDark: currentTheme.primaryColorBrightness == Brightness.dark,
                brightnessChangeHandler: widget.onPrimaryBrightnessChanged),
            getColorBrightnessSelector(
                label: 'Accent color',
                currentColor: currentTheme.accentColor,
                changeHandler: (c) =>
                    updateColor(property: "accentColor", color: c),
                isDark: currentTheme.accentColorBrightness == Brightness.dark,
                brightnessChangeHandler: widget.onAccentBrightnessChanged),
            getColorBrightnessSelector(
              label: 'Scaffold background color',
              currentColor: currentTheme.scaffoldBackgroundColor,
              changeHandler: (c) =>
                  updateColor(property: "scaffoldBackgroundColor", color: c),
              isDark: currentTheme.brightness == Brightness.dark,
              brightnessChangeHandler: (isDark) => setState(
                    () => theme = currentTheme.copyWith(
                        brightness:
                            isDark ? Brightness.dark : Brightness.light),
                  ),
            ),
            getFieldRow(
              getColorSelector(
                'Button color',
                currentTheme.buttonColor,
                (c) => updateColor(property: "buttonColor", color: c),
              ),
              getColorSelector(
                'Divider color',
                currentTheme.dividerColor,
                (c) => updateColor(property: "dividerColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Canvas color',
                currentTheme.canvasColor,
                (c) => updateColor(property: "canvasColor", color: c),
              ),
              getColorSelector(
                'Card color',
                currentTheme.cardColor,
                (c) => updateColor(property: "cardColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Disabled color',
                currentTheme.disabledColor,
                (c) => updateColor(property: "disabledColor", color: c),
              ),
              getColorSelector(
                'Background color',
                currentTheme.backgroundColor,
                (c) => updateColor(property: "backgroundColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Highlight color',
                currentTheme.highlightColor,
                (c) => updateColor(property: "highlightColor", color: c),
              ),
              getColorSelector(
                'Splash color',
                currentTheme.splashColor,
                (c) => updateColor(property: "splashColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Dialog background color',
                currentTheme.dialogBackgroundColor,
                (c) => updateColor(property: "dialogBackgroundColor", color: c),
              ),
              getColorSelector(
                'Hint color',
                currentTheme.hintColor,
                (c) => updateColor(property: "hintColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Error color',
                currentTheme.errorColor,
                (c) => updateColor(property: "errorColor", color: c),
              ),
              getColorSelector(
                'Indicator color',
                currentTheme.indicatorColor,
                (c) => updateColor(property: "indicatorColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Selected row color',
                currentTheme.selectedRowColor,
                (c) => updateColor(property: "selectedRowColor", color: c),
              ),
              getColorSelector(
                'Unselected widget color',
                currentTheme.unselectedWidgetColor,
                (c) => updateColor(property: "unselectedWidgetColor", color: c),
              ),
            ),
            getFieldRow(
              getColorSelector(
                'Secondary header widget color',
                currentTheme.secondaryHeaderColor,
                (c) => updateColor(property: "secondaryHeaderColor", color: c),
              ),
              getColorSelector(
                'Text selection color',
                currentTheme.textSelectionColor,
                (c) => updateColor(property: "textSelectionColor", color: c),
              ),
            ),
            getColorSelector(
              'Text selection handler color',
              currentTheme.textSelectionHandleColor,
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
    setState(() {
      theme = Function.apply(theme.copyWith, null, args);
      /*widget.themeChangedHandler(theme);*/
    });
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
          Expanded(child: getColorSelector(label, currentColor, changeHandler)),
          Expanded(
              child: getBrightnessSelector(
                  label: 'Brightness',
                  isDark: isDark,
                  changeHandler: brightnessChangeHandler))
        ],
      );

  Widget getFieldRow(w1, w2) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [Expanded(child: w1), Expanded(child: w2)],
      );

  ColorSelector getColorSelector(
          String label, Color value, ColorChanged changeHandler) =>
      ColorSelector(label: label, value: value, onSelection: changeHandler);

  BrightnessSelector getBrightnessSelector(
          {String label, bool isDark, ValueChanged<bool> changeHandler}) =>
      BrightnessSelector(label: label, isDark: isDark, onChange: changeHandler);

  List<Widget> getTextThemeEditorChildren() {
    final txtTheme = widget.currentTheme.textTheme;
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
      _getTextThemeForm('Body 1',
          colorValue: body1.color,
          fontSize: body1.fontSize,
          isBold: body1.fontWeight == FontWeight.bold,
          isItalic: body1.fontStyle == FontStyle.italic, onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(body1: body1.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(body1: body1.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body1: body1.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body1: body1.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Body 2',
          colorValue: body2.color,
          fontSize: body2.fontSize,
          isBold: body2.fontWeight == FontWeight.bold,
          isItalic: body2.fontStyle == FontStyle.italic, onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(body2: body2.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(body2: body2.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body2: body2.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  body2: body2.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Headline',
          colorValue: headline.color,
          fontSize: headline.fontSize,
          isBold: headline.fontWeight == FontWeight.bold,
          isItalic: headline.fontStyle == FontStyle.italic,
          onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(headline: headline.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(headline: headline.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  headline: headline.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  headline: headline.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Subhead',
          colorValue: subhead.color,
          fontSize: subhead.fontSize,
          isBold: subhead.fontWeight == FontWeight.bold,
          isItalic: subhead.fontStyle == FontStyle.italic, onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(subhead: subhead.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(subhead: subhead.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  subhead: subhead.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  subhead: subhead.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Title',
          colorValue: title.color,
          fontSize: title.fontSize,
          isBold: title.fontWeight == FontWeight.bold,
          isItalic: title.fontStyle == FontStyle.italic, onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(title: title.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(title: title.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  title: title.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  title: title.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Button',
          colorValue: button.color,
          fontSize: button.fontSize,
          isBold: button.fontWeight == FontWeight.bold,
          isItalic: button.fontStyle == FontStyle.italic, onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(button: button.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(button: button.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  button: button.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  button: button.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Display 1',
          colorValue: display1.color,
          fontSize: display1.fontSize,
          isBold: display1.fontWeight == FontWeight.bold,
          isItalic: display1.fontStyle == FontStyle.italic,
          onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display1: display1.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display1: display1.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display1: display1.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display1: display1.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm('Display 2',
          colorValue: display2.color,
          fontSize: display2.fontSize,
          isBold: display2.fontWeight == FontWeight.bold,
          isItalic: display2.fontStyle == FontStyle.italic,
          onColorChanged: (c) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display2: display2.copyWith(color: c)));
        });
      }, onSizeChanged: (s) {
        setState(() {
          theme = theme.copyWith(
              textTheme:
                  txtTheme.copyWith(display2: display2.copyWith(fontSize: s)));
        });
      }, onWeightChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display2: display2.copyWith(
                      fontWeight: v ? FontWeight.bold : FontWeight.normal)));
        });
      }, onFontStyleChanged: (v) {
        setState(() {
          theme = theme.copyWith(
              textTheme: txtTheme.copyWith(
                  display2: display2.copyWith(
                      fontStyle: v ? FontStyle.italic : FontStyle.normal)));
        });
      }),
      _getTextThemeForm(
        'Display 3',
        colorValue: display3.color,
        fontSize: display3.fontSize,
        isBold: display3.fontWeight == FontWeight.bold,
        isItalic: display3.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme:
                    txtTheme.copyWith(display3: display3.copyWith(color: c)));
          });
        },
        onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: txtTheme.copyWith(
                    display3: display3.copyWith(fontSize: s)));
          });
        },
        onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: txtTheme.copyWith(
                    display3: display3.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          });
        },
        onFontStyleChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: txtTheme.copyWith(
                    display3: display3.copyWith(
                        fontStyle: v ? FontStyle.italic : FontStyle.normal)));
          });
        },
      ),
      _getTextThemeForm(
        'Display 4',
        colorValue: display4.color,
        fontSize: display4.fontSize,
        isBold: display4.fontWeight == FontWeight.bold,
        isItalic: display4.fontStyle == FontStyle.italic,
        onColorChanged: (c) {
          setState(() {
            theme = theme.copyWith(
                textTheme:
                    txtTheme.copyWith(display4: display4.copyWith(color: c)));
          });
        },
        onSizeChanged: (s) {
          setState(() {
            theme = theme.copyWith(
                textTheme: txtTheme.copyWith(
                    display4: display4.copyWith(fontSize: s)));
          });
        },
        onWeightChanged: (v) {
          setState(() {
            theme = theme.copyWith(
                textTheme: txtTheme.copyWith(
                    display4: display4.copyWith(
                        fontWeight: v ? FontWeight.bold : FontWeight.normal)));
          });
        },
        onFontStyleChanged: (v) {
          setState(
            () {
              theme = theme.copyWith(
                  textTheme: txtTheme.copyWith(
                      display4: display4.copyWith(
                          fontStyle: v ? FontStyle.italic : FontStyle.normal)));
            },
          );
        },
      ),
    ];
  }
}

SizeSelector getSizeSelector(value, onValueChanged, {min: 0.0, max: 112.0}) =>
    SizeSelector(value, onValueChanged, min, max);

class SizeSelector extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onValueChanged;

  SizeSelector(this.value, this.onValueChanged, this.min, this.max);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text("Font size"),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 120.0),
            child: Slider(
              value: value,
              onChanged: onValueChanged,
              min: min,
              max: max,
            ),
          ),
          Text("${value.toStringAsFixed(1)}"),
        ],
      ),
    );
  }
}
