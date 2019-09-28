import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_core/src/data/subtheme.dart';

import '../utils/color_utils.dart';
import 'theme_config.dart';

class PanacheTheme extends ChangeNotifier {
  final String id;
  final String name;
  final ColorSwatch primarySwatch;
  final Brightness brightness;
  final ThemeConfiguration config;
  ThemeData themeData;
  Map<String, dynamic> themeDataMap;

  /// [ThemeData]
  /// initialize a [ThemeData] from primarySwatch
  /// primaryColors are generated from the primarySwath
  /// Needs to be a ColorSwatch
  PanacheTheme({
    @required this.id,
    @required this.name,
    @required this.primarySwatch,
    @required this.brightness,
    @required this.config,
    this.themeData,
  }) {
    final base =
        brightness == Brightness.light ? ThemeData.light() : ThemeData.dark();
    final baseStyle =
    base.textTheme.caption.copyWith(color: base.hintColor);
    themeData ??= ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: primarySwatch,
      brightness: brightness,
      // FIXME default to ios but should detect device type + allow platform switch
      platform: TargetPlatform.android,
      textTheme: base.textTheme.merge(Typography.englishLike2018),
      primaryTextTheme: base.primaryTextTheme.merge(Typography.englishLike2018),
      accentTextTheme: base.accentTextTheme.merge(Typography.englishLike2018),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        labelStyle: baseStyle,
        hintStyle: baseStyle,
        helperStyle: baseStyle,
        counterStyle: baseStyle,
        prefixStyle: baseStyle,
        suffixStyle: baseStyle,
        errorStyle: baseStyle.copyWith(color: base.errorColor),
      )
    );
    print(
        'PanacheTheme.PanacheTheme... ${ThemeData.light().inputDecorationTheme.labelStyle}');
  }

  factory PanacheTheme.fromJson(String data) {
    final rawTheme = json.decode(data);
    return PanacheTheme(
      id: rawTheme['id'],
      name: rawTheme['name'],
      primarySwatch: swatchFor(color: Color(rawTheme['primarySwatch'])),
      brightness: Brightness.values[rawTheme['brightness']],
      config: null,
    );
  }

  void isActivated(Subtheme subtheme) => config.isActivated(subtheme);

  void activate(Subtheme subtheme, bool value) =>
      config.activate(subtheme, value);

  String toJson() {
    final data = {
      'id': id,
      'name': name,
      'primarySwatch': primarySwatch.value,
      'brightness': Brightness.values.indexOf(brightness),
    };
    return json.encode(data);
  }

  @override
  String toString() {
    return 'PanacheTheme{'
        'id: $id, name: $name, '
        'primarySwatch: $primarySwatch, '
        'brightness: $brightness'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanacheTheme &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          primarySwatch == other.primarySwatch;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ primarySwatch.hashCode;

  // Color operator [](T index) => _swatch[index];
  dynamic operator [](String key) => getPropertyValue(themeData, key);

  updateTheme(String propertyName, String panelId, dynamic value) {
    print('PanacheTheme.updateTheme... $propertyName $value');

    if (panelId == 'mainColors') {
      final args = <Symbol, dynamic>{};
      args[Symbol(propertyName)] = value;
      themeData = Function.apply(themeData.copyWith, null, args);
    } else {
      final newSubTheme =
          getUpdatedSubthemeById(themeData, panelId, propertyName, value);

      /*final subThemeArgs = <Symbol, dynamic>{};
      subThemeArgs[Symbol(propertyName)] = value;
      final newSubTheme = Function.apply(
          getSubthemeById(themeData, panelId).copyWith, null, subThemeArgs);*/

      final args = <Symbol, dynamic>{};
      args[Symbol(panelId)] = newSubTheme;
      themeData = Function.apply(themeData.copyWith, null, args);
      /*switch (panelId) {
        case 'buttonTheme':
          final subThemeArgs = <Symbol, dynamic>{};
          subThemeArgs[Symbol(propertyName)] = value;
          final newSubTheme = Function.apply(
              themeData.buttonTheme.copyWith, null, subThemeArgs);
          final args = <Symbol, dynamic>{};
          args[Symbol(panelId)] = newSubTheme;
          themeData = Function.apply(themeData.copyWith, null, args);
          break;
        default:
          print('PanacheTheme.updateTheme... NO CASE');
      }*/
    }

    notifyListeners();
  }
}

dynamic getUpdatedSubthemeById(
  ThemeData theme,
  String subThemeId,
  String propertyName,
  dynamic value,
) {
  final subThemeArgs = <Symbol, dynamic>{};
  subThemeArgs[Symbol(propertyName)] = value;

  switch (subThemeId) {
    case 'buttonTheme':
      return Function.apply(theme.buttonTheme.copyWith, null, subThemeArgs);
    case 'textTheme':
      return Function.apply(theme.textTheme.copyWith, null, subThemeArgs);
    /*case 'toggleButtonsTheme':
      return ToggleButtonsTheme(
          data: Function.apply(
              theme.toggleButtonsTheme.copyWith, null, subThemeArgs));*/
    default:
      return null;
  }
}

dynamic getPropertyValue(ThemeData theme, String key) {
  switch (key) {
    case 'mainColors.primaryColor':
      return theme.primaryColor;
    case 'mainColors.primaryColorLight':
      return theme.primaryColorLight;
    case 'mainColors.primaryColorDark':
      return theme.primaryColorDark;
    case 'mainColors.primaryColorBrightness':
      return theme.primaryColorBrightness;
    case 'mainColors.accentColor':
      return theme.accentColor;
    case 'mainColors.canvasColor':
      return theme.canvasColor;
    case 'mainColors.scaffoldBackgroundColor':
      return theme.scaffoldBackgroundColor;
    case 'mainColors.bottomAppBarColor':
      return theme.bottomAppBarColor;
    case 'mainColors.cardColor':
      return theme.cardColor;
    case 'mainColors.dividerColor':
      return theme.dividerColor;
    case 'mainColors.focusColor':
      return theme.focusColor;
    case 'mainColors.hoverColor':
      return theme.hoverColor;
    case 'mainColors.highlightColor':
      return theme.highlightColor;
    case 'mainColors.splashColor':
      return theme.splashColor;
    case 'mainColors.splashFactory':
      return theme.splashFactory;
    case 'mainColors.selectedRowColor':
      return theme.selectedRowColor;
    case 'mainColors.unselectedWidgetColor':
      return theme.unselectedWidgetColor;
    case 'mainColors.disabledColor':
      return theme.disabledColor;
    case 'mainColors.buttonColor':
      return theme.buttonColor;
    case 'mainColors.secondaryHeaderColor':
      return theme.secondaryHeaderColor;
    case 'mainColors.textSelectionColor':
      return theme.textSelectionColor;
    case 'mainColors.cursorColor':
      return theme.cursorColor;
    case 'mainColors.textSelectionHandleColor':
      return theme.textSelectionHandleColor;
    case 'mainColors.backgroundColor':
      return theme.backgroundColor;
    case 'mainColors.dialogBackgroundColor':
      return theme.dialogBackgroundColor;
    case 'mainColors.indicatorColor':
      return theme.indicatorColor;
    case 'mainColors.hintColor':
      return theme.hintColor;
    case 'mainColors.errorColor':
      return theme.errorColor;
    case 'mainColors.toggleableActiveColor':
      return theme.toggleableActiveColor;

    case 'buttonTheme.textTheme':
      return theme.buttonTheme.textTheme;
    case 'buttonTheme.layoutBehavior':
      return theme.buttonTheme.layoutBehavior;
    case 'buttonTheme.minWidth':
      return theme.buttonTheme.minWidth;
    case 'buttonTheme.height':
      return theme.buttonTheme.height;
    case 'buttonTheme.padding':
      return theme.buttonTheme.padding;
    case 'buttonTheme.alignedDropdown':
      return theme.buttonTheme.alignedDropdown;
    case 'buttonTheme.shape':
      return theme.buttonTheme.shape;
    case 'buttonTheme.buttonColor':
      return theme.buttonTheme.getFillColor(enabledRaisedButton);
    case 'buttonTheme.disabledColor':
      return theme.buttonTheme.getDisabledFillColor(disabledRaisedButton);
    case 'buttonTheme.focusColor':
      return theme.buttonTheme.getFocusColor(enabledRaisedButton);
    case 'buttonTheme.hoverColor':
      return theme.buttonTheme.getHoverColor(enabledRaisedButton);
    case 'buttonTheme.highlightColor':
      return theme.buttonTheme.getHighlightColor(enabledRaisedButton);
    case 'buttonTheme.splashColor':
      return theme.buttonTheme.getSplashColor(enabledRaisedButton);
    case 'buttonTheme.colorScheme': // FIXME
      return theme.buttonTheme.colorScheme;
    case 'buttonTheme.materialTapTargetSize': // FIXME
      return theme.buttonTheme.getMaterialTapTargetSize(enabledRaisedButton);

    case 'textTheme.display4':
      return theme.textTheme.display4;
    case 'textTheme.display3':
      return theme.textTheme.display3;
    case 'textTheme.display2':
      return theme.textTheme.display2;
    case 'textTheme.display1':
      return theme.textTheme.display1;
    case 'textTheme.headline':
      return theme.textTheme.headline;
    case 'textTheme.title':
      return theme.textTheme.title;
    case 'textTheme.subhead':
      return theme.textTheme.subhead;
    case 'textTheme.body2':
      return theme.textTheme.body2;
    case 'textTheme.body1':
      return theme.textTheme.body1;
    case 'textTheme.caption':
      return theme.textTheme.caption;
    case 'textTheme.button':
      return theme.textTheme.button;
    case 'textTheme.subtitle':
      return theme.textTheme.subtitle;
    case 'textTheme.overline':
      return theme.textTheme.overline;

    case 'primaryTextTheme.display4':
      return theme.primaryTextTheme.display4;
    case 'primaryTextTheme.display3':
      return theme.primaryTextTheme.display3;
    case 'primaryTextTheme.display2':
      return theme.primaryTextTheme.display2;
    case 'primaryTextTheme.display1':
      return theme.primaryTextTheme.display1;
    case 'primaryTextTheme.headline':
      return theme.primaryTextTheme.headline;
    case 'primaryTextTheme.title':
      return theme.primaryTextTheme.title;
    case 'primaryTextTheme.subhead':
      return theme.primaryTextTheme.subhead;
    case 'primaryTextTheme.body2':
      return theme.primaryTextTheme.body2;
    case 'primaryTextTheme.body1':
      return theme.primaryTextTheme.body1;
    case 'primaryTextTheme.caption':
      return theme.primaryTextTheme.caption;
    case 'primaryTextTheme.button':
      return theme.primaryTextTheme.button;
    case 'primaryTextTheme.subtitle':
      return theme.primaryTextTheme.subtitle;
    case 'primaryTextTheme.overline':
      return theme.primaryTextTheme.overline;

    case 'accentTextTheme.display4':
      return theme.accentTextTheme.display4;
    case 'accentTextTheme.display3':
      return theme.accentTextTheme.display3;
    case 'accentTextTheme.display2':
      return theme.accentTextTheme.display2;
    case 'accentTextTheme.display1':
      return theme.accentTextTheme.display1;
    case 'accentTextTheme.headline':
      return theme.accentTextTheme.headline;
    case 'accentTextTheme.title':
      return theme.accentTextTheme.title;
    case 'accentTextTheme.subhead':
      return theme.accentTextTheme.subhead;
    case 'accentTextTheme.body2':
      return theme.accentTextTheme.body2;
    case 'accentTextTheme.body1':
      return theme.accentTextTheme.body1;
    case 'accentTextTheme.caption':
      return theme.accentTextTheme.caption;
    case 'accentTextTheme.button':
      return theme.accentTextTheme.button;
    case 'accentTextTheme.subtitle':
      return theme.accentTextTheme.subtitle;
    case 'accentTextTheme.overline':
      return theme.accentTextTheme.overline;

    case 'inputDecorationTheme.labelStyle':
      return theme.inputDecorationTheme.labelStyle;
    case 'inputDecorationTheme.helperStyle':
      return theme.inputDecorationTheme.helperStyle;
    case 'inputDecorationTheme.hintStyle':
      return theme.inputDecorationTheme.hintStyle;
    case 'inputDecorationTheme.errorStyle':
      return theme.inputDecorationTheme.errorStyle;
    case 'inputDecorationTheme.errorMaxLines':
      return theme.inputDecorationTheme.errorMaxLines;
    case 'inputDecorationTheme.hasFloatingPlaceholder':
      return theme.inputDecorationTheme.hasFloatingPlaceholder;
    case 'inputDecorationTheme.isDense':
      return theme.inputDecorationTheme.isDense;
    case 'inputDecorationTheme.contentPadding':
      return theme.inputDecorationTheme.contentPadding;
    case 'inputDecorationTheme.isCollapsed':
      return theme.inputDecorationTheme.isCollapsed;
    case 'inputDecorationTheme.prefixStyle':
      return theme.inputDecorationTheme.prefixStyle;
    case 'inputDecorationTheme.suffixStyle':
      return theme.inputDecorationTheme.suffixStyle;
    case 'inputDecorationTheme.counterStyle':
      return theme.inputDecorationTheme.counterStyle;
    case 'inputDecorationTheme.filled':
      return theme.inputDecorationTheme.filled;
    case 'inputDecorationTheme.fillColor':
      return theme.inputDecorationTheme.fillColor;
    case 'inputDecorationTheme.focusColor':
      return theme.inputDecorationTheme.focusColor;
    case 'inputDecorationTheme.hoverColor':
      return theme.inputDecorationTheme.hoverColor;
    case 'inputDecorationTheme.border':
      return theme.inputDecorationTheme.border;
    case 'inputDecorationTheme.errorBorder':
      return theme.inputDecorationTheme.errorBorder;
    case 'inputDecorationTheme.focusedBorder':
      return theme.inputDecorationTheme.focusedBorder;
    case 'inputDecorationTheme.focusedErrorBorder':
      return theme.inputDecorationTheme.focusedErrorBorder;
    case 'inputDecorationTheme.disabledBorder':
      return theme.inputDecorationTheme.disabledBorder;
    case 'inputDecorationTheme.enabledBorder':
      return theme.inputDecorationTheme.enabledBorder;
    case 'inputDecorationTheme.alignLabelWithHint':
      return theme.inputDecorationTheme.alignLabelWithHint;

    default:
      return null;
  }
}
