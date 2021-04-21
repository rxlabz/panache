import 'dart:math';

import 'package:flutter/material.dart';

import 'converter_utils.dart';

String textThemeToCode(TextTheme textTheme) {
  return '''TextTheme(
      display4: ${textStyleToCode(textTheme.headline1)},
      display3: ${textStyleToCode(textTheme.headline2)},
      display2: ${textStyleToCode(textTheme.headline3)},
      display1: ${textStyleToCode(textTheme.headline4)},
      headline: ${textStyleToCode(textTheme.headline5)},
      title: ${textStyleToCode(textTheme.headline6)},
      subhead: ${textStyleToCode(textTheme.subtitle1)},
      body2: ${textStyleToCode(textTheme.bodyText2)},
      body1: ${textStyleToCode(textTheme.bodyText1)},
      caption: ${textStyleToCode(textTheme.caption)},
      button: ${textStyleToCode(textTheme.button)},
      subtitle: ${textStyleToCode(textTheme.subtitle2)},
      overline: ${textStyleToCode(textTheme.overline)},
    )''';
}

String textStyleToCode(TextStyle style) {
  assert(style != null);
  return '''TextStyle(
      color: ${colorToCode(style.color)},
      fontSize: ${style.fontSize},
      fontWeight: ${style.fontWeight ?? FontWeight.normal},
      fontStyle: ${style.fontStyle ?? FontStyle.normal},
    )''';

  /* TODO
        letterSpacing: ${style.letterSpacing},
        wordSpacing: ${style.wordSpacing},
        foreground: ${style.foreground},
        background: ${style.background},
        shadows: ${style.shadows},
        decoration: ${style.decoration},
        decorationColor: ${colorToCode(style.decorationColor)},
        decorationStyle: ${style.decorationStyle},
        height: ${style.height},
        locale: ${style.locale},
        textBaseline: ${style.textBaseline},
      */
}

Map<String, dynamic> textThemeToMap(TextTheme textTheme) {
  assert(textTheme != null);

  return <String, dynamic>{
    'display4': textStyleToMap(textTheme.headline1),
    'display3': textStyleToMap(textTheme.headline2),
    'display2': textStyleToMap(textTheme.headline3),
    'display1': textStyleToMap(textTheme.headline4),
    'headline': textStyleToMap(textTheme.headline5),
    'title': textStyleToMap(textTheme.headline6),
    'subhead': textStyleToMap(textTheme.subtitle1),
    'body2': textStyleToMap(textTheme.bodyText2),
    'body1': textStyleToMap(textTheme.bodyText1),
    'caption': textStyleToMap(textTheme.caption),
    'button': textStyleToMap(textTheme.button),
    'subtitle': textStyleToMap(textTheme.subtitle2),
    'overline': textStyleToMap(textTheme.overline),
  };
}

Map<String, dynamic> textStyleToMap(TextStyle style) {
  assert(style != null);
  return <String, dynamic>{
    'color': style.color.value,
    'fontSize': style.fontSize,
    'fontWeight': max(0, FontWeight.values.indexOf(style.fontWeight)),
    'fontStyle': max(0, FontStyle.values.indexOf(style.fontStyle)),
    /* TODO
    'letterSpacing': style.letterSpacing,
    'wordSpacing': style.wordSpacing,
    'height': style.height,
    'textBaseline': TextBaseline.values.indexOf( style.textBaseline),
    'locale': style.locale,
    'foreground': style.foreground,
    'background': style.background,
    'shadows': style.shadows,
    'decoration': style.decoration,
    'decorationColor': colorToCode(style.decorationColor),
    'decorationStyle': style.decorationStyle,*/
  };
}

TextTheme textThemeFromMap(Map<String, dynamic> data) {
  if (data == null) return null;

  return TextTheme(
    headline1: textStyleFromMap(data['display4']),
    headline2: textStyleFromMap(data['display3']),
    headline3: textStyleFromMap(data['display2']),
    headline4: textStyleFromMap(data['display1']),
    headline5: textStyleFromMap(data['headline']),
    headline6: textStyleFromMap(data['title']),
    subtitle1: textStyleFromMap(data['subhead']),
    bodyText2: textStyleFromMap(data['body2']),
    bodyText1: textStyleFromMap(data['body1']),
    caption: textStyleFromMap(data['caption']),
    button: textStyleFromMap(data['button']),
    subtitle2: textStyleFromMap(data['subtitle']),
    overline: textStyleFromMap(data['overline']),
  );
}

TextStyle textStyleFromMap(Map<String, dynamic> data) {
  assert(data != null);
  return TextStyle(
    color: Color(data['color']),
    fontSize: data['fontSize'],
    fontWeight: FontWeight.values[max(0, data['fontWeight'])],
    fontStyle: FontStyle.values[max(data['fontStyle'], 0)],
  );
}
