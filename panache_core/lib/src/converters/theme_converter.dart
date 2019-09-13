import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'button_theme_converters.dart';
import 'converter_utils.dart';
import 'icon_theme_converter.dart';
import 'input_theme_converter.dart';
import 'text_theme_converters.dart';

final defaultLightTheme =
    ThemeData.localize(ThemeData.light(), Typography.englishLike2018);

final defaultDarkTheme =
    ThemeData.localize(ThemeData.dark(), Typography.englishLike2018);

String themeToCode(ThemeData theme) {
  return '''
  import 'package:flutter/material.dart';
  final ThemeData myTheme = ThemeData(
    primarySwatch: ${materialSwatchCodeFor(color: theme.primaryColor)},
    brightness: ${theme.brightness},
    primaryColor: ${colorToCode(theme.primaryColor)},
    primaryColorBrightness: ${theme.primaryColorBrightness},
    primaryColorLight: ${colorToCode(theme.primaryColorLight)},
    primaryColorDark: ${colorToCode(theme.primaryColorDark)},
    accentColor: ${colorToCode(theme.accentColor)},
    accentColorBrightness: ${theme.accentColorBrightness},
    canvasColor: ${colorToCode(theme.canvasColor)},
    scaffoldBackgroundColor: ${colorToCode(theme.scaffoldBackgroundColor)},
    bottomAppBarColor: ${colorToCode(theme.bottomAppBarColor)},
    cardColor: ${colorToCode(theme.cardColor)},
    dividerColor: ${colorToCode(theme.dividerColor)},
    highlightColor: ${colorToCode(theme.highlightColor)},
    splashColor: ${colorToCode(theme.splashColor)},
    selectedRowColor: ${colorToCode(theme.selectedRowColor)},
    unselectedWidgetColor: ${colorToCode(theme.unselectedWidgetColor)},
    disabledColor: ${colorToCode(theme.disabledColor)},
    buttonColor: ${colorToCode(theme.buttonColor)},
    toggleableActiveColor: ${colorToCode(theme.toggleableActiveColor)},
    secondaryHeaderColor: ${colorToCode(theme.secondaryHeaderColor)},
    textSelectionColor: ${colorToCode(theme.textSelectionColor)},
    cursorColor: ${colorToCode(theme.cursorColor)},
    textSelectionHandleColor: ${colorToCode(theme.textSelectionHandleColor)},
    backgroundColor: ${colorToCode(theme.backgroundColor)},
    dialogBackgroundColor: ${colorToCode(theme.dialogBackgroundColor)},
    indicatorColor: ${colorToCode(theme.indicatorColor)},
    hintColor: ${colorToCode(theme.hintColor)},
    errorColor: ${colorToCode(theme.errorColor)},
    buttonTheme: ${buttonThemeToCode(theme.buttonTheme)},
    textTheme: ${textThemeToCode(theme.textTheme)},
    primaryTextTheme: ${textThemeToCode(theme.primaryTextTheme)},
    accentTextTheme: ${textThemeToCode(theme.accentTextTheme)},
    inputDecorationTheme: ${inputDecorationThemeToCode(
    theme.inputDecorationTheme,
    theme.hintColor,
    theme.textTheme.body1,
    theme.brightness,
  )},
    iconTheme: ${iconThemeToCode(theme.iconTheme)},
    primaryIconTheme: ${iconThemeToCode(theme.primaryIconTheme)},
    accentIconTheme: ${iconThemeToCode(theme.accentIconTheme)},
    sliderTheme: ${sliderThemeToCode(
    theme.sliderTheme,
    theme.accentTextTheme.body2,
  )},
    tabBarTheme: ${tabBarThemeToCode(
    theme.tabBarTheme,
    defaultLabelColor: theme.primaryTextTheme.body2.color,
  )},
    chipTheme: ${chipThemeToCode(
    theme.chipTheme,
    defaultLabelStyle: theme.textTheme.body2,
  )},
    dialogTheme: ${dialogThemeToCode(theme.dialogTheme)},
  );
''';
}
/*
    TODO
    colorScheme: ${theme.colorScheme},
    splashFactory: ${theme.splashFactory},
    materialTapTargetSize: ${theme.materialTapTargetSize},
    pageTransitionsTheme: ${theme.pageTransitionsTheme},
    platform: ${theme.platform},
 */

Map<String, dynamic> themeToMap(ThemeData theme) {
  return <String, dynamic>{
    "primarySwatch": theme.primaryColor.value,
    'brightness': brightnessIndex(theme.brightness),
    'primaryColor': theme.primaryColor.value,
    'primaryColorBrightness': brightnessIndex(theme.primaryColorBrightness),
    'primaryColorLight': theme.primaryColorLight.value,
    'primaryColorDark': theme.primaryColorDark.value,
    'accentColor': theme.accentColor.value,
    'accentColorBrightness': brightnessIndex(theme.accentColorBrightness),
    'canvasColor': theme.canvasColor.value,
    'scaffoldBackgroundColor': theme.scaffoldBackgroundColor.value,
    'bottomAppBarColor': theme.bottomAppBarColor.value,
    'cardColor': theme.cardColor.value,
    'dividerColor': theme.dividerColor.value,
    'highlightColor': theme.highlightColor.value,
    'splashColor': theme.splashColor.value,
    'selectedRowColor': theme.selectedRowColor.value,
    'unselectedWidgetColor': theme.unselectedWidgetColor.value,
    'disabledColor': theme.disabledColor.value,
    'buttonColor': theme.buttonColor.value,
    'toggleableActiveColor': theme.toggleableActiveColor.value,
    'secondaryHeaderColor': theme.secondaryHeaderColor.value,
    'textSelectionColor': theme.textSelectionColor.value,
    'cursorColor': theme.cursorColor.value,
    'textSelectionHandleColor': theme.textSelectionHandleColor.value,
    'backgroundColor': theme.backgroundColor.value,
    'dialogBackgroundColor': theme.dialogBackgroundColor.value,
    'indicatorColor': theme.indicatorColor.value,
    'hintColor': theme.hintColor.value,
    'errorColor': theme.errorColor.value,
    'buttonTheme': buttonThemeToMap(theme.buttonTheme),
    'textTheme': textThemeToMap(theme.textTheme),
    'primaryTextTheme': textThemeToMap(theme.primaryTextTheme),
    'accentTextTheme': textThemeToMap(theme.accentTextTheme),
    'inputDecorationTheme': inputDecorationThemeToMap(
        theme.inputDecorationTheme,
        theme.hintColor,
        theme.textTheme.body1,
        theme.brightness),
    'iconTheme': iconThemeToMap(theme.iconTheme),
    'primaryIconTheme': iconThemeToMap(theme.primaryIconTheme),
    'accentIconTheme': iconThemeToMap(theme.accentIconTheme),
    /* FIXME'sliderTheme':
        sliderThemeToMap(theme.sliderTheme, theme.accentTextTheme.body2),*/
    'tabBarTheme': tabBarThemeToMap(theme.tabBarTheme,
        defaultLabelColor: theme.primaryTextTheme.body2.color),
    'chipTheme': chipThemeToMap(
      theme.chipTheme,
      defaultLabelStyle: theme.textTheme.body2,
    ),
    'dialogTheme': dialogThemeToMap(theme.dialogTheme),
  };
}

ThemeData themeFromJson(String jsonTheme) {
  final defaultTheme = ThemeData.light();
  final Map<String, dynamic> themeMap = json.decode(jsonTheme);
  final defaultColor = Colors.cyan;
  return ThemeData(
    primarySwatch: swatchFor(
        color: Color(themeMap['primarySwatch'] ?? defaultColor.value)),
    brightness:
        Brightness.values[max(Brightness.light.index, themeMap['brightness'])],
    primaryColor: Color(themeMap['primaryColor'] ?? defaultColor),
    primaryColorBrightness: Brightness.values[max(
        defaultTheme.primaryColorBrightness.index,
        themeMap['primaryColorBrightness'])],
    primaryColorLight: Color(
        themeMap['primaryColorLight'] ?? defaultTheme.primaryColorLight.value),
    primaryColorDark: Color(
        themeMap['primaryColorDark'] ?? defaultTheme.primaryColorDark.value),
    accentColor:
        Color(themeMap['accentColor'] ?? defaultTheme.accentColor.value),
    accentColorBrightness: Brightness.values[max(
        defaultTheme.accentColorBrightness.index,
        themeMap['accentColorBrightness'])],
    canvasColor:
        Color(themeMap['canvasColor'] ?? defaultTheme.canvasColor.value),
    scaffoldBackgroundColor: Color(themeMap['scaffoldBackgroundColor'] ??
        defaultTheme.scaffoldBackgroundColor.value),
    bottomAppBarColor:
        Color(themeMap['bottomAppBarColor'] ?? defaultTheme.bottomAppBarColor),
    cardColor: Color(themeMap['cardColor'] ?? defaultTheme.cardColor),
    dividerColor: Color(themeMap['dividerColor'] ?? defaultTheme.dividerColor),
    highlightColor:
        Color(themeMap['highlightColor'] ?? defaultTheme.highlightColor),
    splashColor: Color(themeMap['splashColor'] ?? defaultTheme.splashColor),
    selectedRowColor:
        Color(themeMap['selectedRowColor'] ?? defaultTheme.selectedRowColor),
    unselectedWidgetColor: Color(themeMap['unselectedWidgetColor'] ??
        defaultTheme.unselectedWidgetColor),
    disabledColor:
        Color(themeMap['disabledColor'] ?? defaultTheme.disabledColor),
    buttonColor: Color(themeMap['buttonColor'] ?? defaultTheme.buttonColor),
    toggleableActiveColor: Color(themeMap['toggleableActiveColor'] ??
        defaultTheme.toggleableActiveColor),
    secondaryHeaderColor: Color(
        themeMap['secondaryHeaderColor'] ?? defaultTheme.secondaryHeaderColor),
    textSelectionColor: Color(
        themeMap['textSelectionColor'] ?? defaultTheme.textSelectionColor),
    cursorColor: Color(themeMap['cursorColor'] ?? defaultTheme.cursorColor),
    textSelectionHandleColor: Color(themeMap['textSelectionHandleColor'] ??
        defaultTheme.textSelectionHandleColor),
    backgroundColor:
        Color(themeMap['backgroundColor'] ?? defaultTheme.backgroundColor),
    dialogBackgroundColor: Color(themeMap['dialogBackgroundColor'] ??
        defaultTheme.dialogBackgroundColor),
    indicatorColor:
        Color(themeMap['indicatorColor'] ?? defaultTheme.indicatorColor),
    hintColor: Color(themeMap['hintColor'] ?? defaultTheme.hintColor),
    errorColor: Color(themeMap['errorColor'] ?? defaultTheme.errorColor),
    buttonTheme: buttonThemeFromMap(themeMap['buttonTheme']) ??
        ThemeData.light().buttonTheme,
    textTheme:
        textThemeFromMap(themeMap['textTheme']) ?? defaultTheme.textTheme,
    primaryTextTheme: textThemeFromMap(themeMap['primaryTextTheme']) ??
        defaultTheme.primaryTextTheme,
    accentTextTheme: textThemeFromMap(themeMap['accentTextTheme']) ??
        defaultTheme.accentTextTheme,
    iconTheme:
        iconThemeFromMap(themeMap['iconTheme']) ?? defaultTheme.iconTheme,
    primaryIconTheme: iconThemeFromMap(themeMap['primaryIconTheme']) ??
        defaultTheme.primaryIconTheme,
    accentIconTheme: iconThemeFromMap(themeMap['accentIconTheme']) ??
        defaultTheme.accentTextTheme,
    sliderTheme:
        sliderThemeFromMap(themeMap['sliderTheme']) ?? defaultTheme.sliderTheme,
    tabBarTheme:
        tabBarThemeFromMap(themeMap['tabBarTheme']) ?? defaultTheme.tabBarTheme,
    chipTheme:
        chipThemeFromMap(themeMap['chipTheme']) ?? defaultTheme.chipTheme,
    inputDecorationTheme:
        inputDecorationThemeFromMap(themeMap['inputDecorationTheme']) ??
            defaultTheme.inputDecorationTheme,
    dialogTheme:
        dialogThemeFromMap(themeMap['dialogTheme']) ?? defaultTheme.textTheme,
    /*FIXME
    *  */
    platform: defaultTheme.platform,
    colorScheme: defaultLightTheme.colorScheme,
    /*
    fontFamily:
    pageTransitionsTheme:
    materialTapTargetSize:
    splashFactory:
    typography:
    */
  );
}

int brightnessIndex(Brightness value) =>
    max(0, Brightness.values.indexOf(value));

String sliderThemeToCode(
    SliderThemeData sliderTheme, TextStyle defaultValueIndicatorStyle) {
  return '''SliderThemeData(
      activeTrackColor: ${colorToCode(sliderTheme.activeTrackColor)},
      inactiveTrackColor: ${colorToCode(sliderTheme.inactiveTrackColor)},
      disabledActiveTrackColor: ${colorToCode(sliderTheme.disabledActiveTrackColor)},
      disabledInactiveTrackColor: ${colorToCode(sliderTheme.disabledInactiveTrackColor)},
      activeTickMarkColor: ${colorToCode(sliderTheme.activeTickMarkColor)},
      inactiveTickMarkColor: ${colorToCode(sliderTheme.inactiveTickMarkColor)},
      disabledActiveTickMarkColor: ${colorToCode(sliderTheme.disabledActiveTickMarkColor)},
      disabledInactiveTickMarkColor: ${colorToCode(sliderTheme.disabledInactiveTickMarkColor)},
      thumbColor: ${colorToCode(sliderTheme.thumbColor)},
      disabledThumbColor: ${colorToCode(sliderTheme.disabledThumbColor)},
      thumbShape: ${instanceToCode(sliderTheme.thumbShape)},
      overlayColor: ${colorToCode(sliderTheme.overlayColor)},
      valueIndicatorColor: ${colorToCode(sliderTheme.valueIndicatorColor)},
      valueIndicatorShape: ${instanceToCode(sliderTheme.valueIndicatorShape)},
      showValueIndicator: ${sliderTheme.showValueIndicator},
      valueIndicatorTextStyle: ${textStyleToCode(defaultValueIndicatorStyle.merge(sliderTheme.valueIndicatorTextStyle))},
    )''';
}

Map<String, dynamic> sliderThemeToMap(
    SliderThemeData sliderTheme, TextStyle defaultValueIndicatorStyle) {
  return <String, dynamic>{
    'activeTrackColor': sliderTheme.activeTrackColor.value,
    'inactiveTrackColor': sliderTheme.inactiveTrackColor.value,
    'disabledActiveTrackColor': sliderTheme.disabledActiveTrackColor.value,
    'disabledInactiveTrackColor': sliderTheme.disabledInactiveTrackColor.value,
    'activeTickMarkColor': sliderTheme.activeTickMarkColor.value,
    'inactiveTickMarkColor': sliderTheme.inactiveTickMarkColor.value,
    'disabledActiveTickMarkColor':
        sliderTheme.disabledActiveTickMarkColor.value,
    'disabledInactiveTickMarkColor':
        sliderTheme.disabledInactiveTickMarkColor.value,
    'thumbColor': sliderTheme.thumbColor.value,
    'disabledThumbColor': sliderTheme.disabledThumbColor.value,
    'thumbShape': {'type': 'RoundSliderThumbShape'},
    'overlayColor': sliderTheme.overlayColor.value,
    'valueIndicatorColor': sliderTheme.valueIndicatorColor.value,
    'valueIndicatorShape': {'type': 'PaddleSliderValueIndicatorShape'},
    'showValueIndicator': max(
        0, ShowValueIndicator.values.indexOf(sliderTheme.showValueIndicator)),
    'valueIndicatorTextStyle': textStyleToMap(
        defaultValueIndicatorStyle.merge(sliderTheme.valueIndicatorTextStyle)),
  };
}

SliderThemeData sliderThemeFromMap(Map<String, dynamic> data) {
  if (data == null) return null;

  return SliderThemeData(
    activeTrackColor: Color(data['activeTrackColor']),
    inactiveTrackColor: Color(data['inactiveTrackColor']),
    disabledActiveTrackColor: Color(data['disabledActiveTrackColor']),
    disabledInactiveTrackColor: Color(data['disabledInactiveTrackColor']),
    activeTickMarkColor: Color(data['activeTickMarkColor']),
    inactiveTickMarkColor: Color(data['inactiveTickMarkColor']),
    disabledActiveTickMarkColor: Color(data['disabledActiveTickMarkColor']),
    disabledInactiveTickMarkColor: Color(data['disabledInactiveTickMarkColor']),
    thumbColor: Color(data['thumbColor']),
    disabledThumbColor: Color(data['disabledThumbColor']),
    thumbShape: RoundSliderThumbShape(),
    overlayColor: Color(data['overlayColor']),
    valueIndicatorColor: Color(data['valueIndicatorColor']),
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    showValueIndicator:
        ShowValueIndicator.values[max(0, data['showValueIndicator'])],
    valueIndicatorTextStyle: textStyleFromMap(data['valueIndicatorTextStyle']),
  );
}

String instanceToCode(dynamic instance) =>
    '$instance()'.replaceAll('Instance of \'', '').replaceAll('\'', '');

String dialogThemeToCode(DialogTheme iconTheme) {
  return '''DialogTheme(
      shape: ${buttonShapeToCode(iconTheme.shape ?? RoundedRectangleBorder())}
    )''';
}

Map<String, dynamic> dialogThemeToMap(DialogTheme iconTheme) =>
    {'shape': buttonShapeToMap(iconTheme.shape ?? RoundedRectangleBorder())};

DialogTheme dialogThemeFromMap(Map<String, dynamic> data) =>
    data == null ? null : DialogTheme(shape: buttonShapeFromMap(data));

/// TODO indicator Decoration
String tabBarThemeToCode(TabBarTheme tabBarTheme,
    {@required Color defaultLabelColor}) {
  final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  final unselectedColor =
      tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return '''TabBarTheme(
      indicatorSize: ${tabBarTheme.indicatorSize ?? TabBarIndicatorSize.tab},
      labelColor: ${colorToCode(selectedColor)},
      unselectedLabelColor: ${colorToCode(unselectedColor)},
    )''';
}

/// TODO indicator Decoration
Map<String, dynamic> tabBarThemeToMap(TabBarTheme tabBarTheme,
    {@required Color defaultLabelColor}) {
  final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  final unselectedColor =
      tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return {
    'indicatorSize':
        max(0, TabBarIndicatorSize.values.indexOf(tabBarTheme.indicatorSize)),
    'labelColor': selectedColor.value,
    'unselectedLabelColor': unselectedColor.value,
  };
}

TabBarTheme tabBarThemeFromMap(Map<String, dynamic> data) {
  if (data == null) return null;

  return TabBarTheme(
    indicatorSize:
        TabBarIndicatorSize.values[max(0, data['indicatorSize'] ?? 0)],
    labelColor: Color(data['labelColor']),
    unselectedLabelColor: Color(data['unselectedLabelColor']),
  );
}

String chipThemeToCode(ChipThemeData chipTheme,
    {@required TextStyle defaultLabelStyle}) {
  return '''ChipThemeData(
      backgroundColor: ${colorToCode(chipTheme.backgroundColor)},
      brightness: ${chipTheme.brightness},
      deleteIconColor: ${colorToCode(chipTheme.deleteIconColor)},
      disabledColor: ${colorToCode(chipTheme.disabledColor)},
      labelPadding: ${paddingToCode(chipTheme.labelPadding)},
      labelStyle: ${textStyleToCode(
    defaultLabelStyle.merge(chipTheme.labelStyle),
  )},
      padding: ${paddingToCode(chipTheme.padding)},
      secondaryLabelStyle: ${textStyleToCode(
    defaultLabelStyle.merge(
      chipTheme.labelStyle.copyWith(color: chipTheme.selectedColor),
    ),
  )},
      secondarySelectedColor: ${colorToCode(chipTheme.secondarySelectedColor)},
      selectedColor: ${colorToCode(chipTheme.selectedColor)},
      shape: ${buttonShapeToCode(chipTheme.shape)},
    )''';
}

Map<String, dynamic> chipThemeToMap(ChipThemeData chipTheme,
    {@required TextStyle defaultLabelStyle}) {
  return {
    'backgroundColor': chipTheme.backgroundColor.value,
    'brightness': max(0, Brightness.values.indexOf(chipTheme.brightness)),
    'deleteIconColor': chipTheme.deleteIconColor.value,
    'disabledColor': chipTheme.disabledColor.value,
    'labelPadding': paddingToMap(chipTheme.labelPadding),
    'labelStyle': textStyleToMap(
      defaultLabelStyle.merge(chipTheme.labelStyle),
    ),
    'padding': paddingToMap(chipTheme.padding),
    'secondaryLabelStyle': textStyleToMap(defaultLabelStyle
        .merge(chipTheme.labelStyle.copyWith(color: chipTheme.selectedColor))),
    'secondarySelectedColor': chipTheme.secondarySelectedColor.value,
    'selectedColor': chipTheme.selectedColor.value,
    'shape': buttonShapeToMap(chipTheme.shape),
  };
}

ChipThemeData chipThemeFromMap(Map<String, dynamic> data) {
  if (data == null) return null;
  return ChipThemeData(
    backgroundColor: Color(data['backgroundColor']),
    brightness: Brightness.values[max(0, data['brightness'])],
    deleteIconColor: Color(data['deleteIconColor']),
    disabledColor: Color(data['disabledColor']),
    labelPadding: paddingFromMap(data['labelPadding']),
    labelStyle: textStyleFromMap(data['labelStyle']),
    padding: paddingFromMap(data['padding']),
    secondaryLabelStyle: textStyleFromMap(data['secondaryLabelStyle']),
    secondarySelectedColor: Color(data['secondarySelectedColor']),
    selectedColor: Color(data['selectedColor']),
    shape: buttonShapeFromMap(data['shape']),
  );
}

String getChipShapeBorderType(ShapeBorder border) {
  if (border is RoundedRectangleBorder) return 'RoundedRectangleBorder';
  if (border is StadiumBorder) return 'StadiumBorder';
  if (border is CircleBorder) return 'CircleBorder';
  if (border is BeveledRectangleBorder) return 'BeveledRectangleBorder';

  return 'RoundedRectangleBorder';
}
