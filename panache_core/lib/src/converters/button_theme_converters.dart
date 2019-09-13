import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'converter_utils.dart';

String buttonThemeToCode(ButtonThemeData buttonTheme) {
  final buttonColor =
      colorToCode(buttonTheme.getFillColor(enabledRaisedButton));

  final disabledColor =
      colorToCode(buttonTheme.getDisabledFillColor(disabledRaisedButton));

  final highlightColor =
      colorToCode(buttonTheme.getHighlightColor(enabledRaisedButton));

  final splashColor =
      colorToCode(buttonTheme.getSplashColor(enabledRaisedButton));

  final focusColor =
      colorToCode(buttonTheme.getFocusColor(enabledRaisedButton));

  final hoverColor =
      colorToCode(buttonTheme.getHoverColor(enabledRaisedButton));

  return '''ButtonThemeData(
      textTheme: ${buttonTheme.textTheme},
      minWidth: ${buttonTheme.minWidth},
      height: ${buttonTheme.height},
      padding: ${paddingToCode(buttonTheme.padding)},
      shape: ${buttonShapeToCode(buttonTheme.shape)} ,
      alignedDropdown: ${buttonTheme.alignedDropdown} ,
      buttonColor: $buttonColor,
      disabledColor: $disabledColor,
      highlightColor: $highlightColor,
      splashColor: $splashColor,
      focusColor: $focusColor,
      hoverColor: $hoverColor,
      colorScheme: ${colorSchemeToCode(buttonTheme.colorScheme)},
    )''';
}

Map<String, dynamic> buttonThemeToMap(ButtonThemeData buttonTheme) {
  //ButtonThemeData
  return {
    'type': 'ButtonThemeData',
    'textTheme': max(0, ButtonTextTheme.values.indexOf(buttonTheme.textTheme)),
    'minWidth': buttonTheme.minWidth.toInt(),
    'height': buttonTheme.height.toInt(),
    'padding': paddingToMap(buttonTheme.padding),
    'shape': buttonShapeToMap(buttonTheme.shape),
    'alignedDropdown': buttonTheme.alignedDropdown ? 0 : 1,
    'buttonColor': buttonTheme.getFillColor(enabledRaisedButton).value,
    'disabledColor':
        buttonTheme.getDisabledFillColor(disabledRaisedButton).value,
    'highlightColor': buttonTheme.getHighlightColor(enabledRaisedButton).value,
    'splashColor': buttonTheme.getSplashColor(enabledRaisedButton).value,
    'focusColor': buttonTheme.getFocusColor(enabledRaisedButton).value,
    'hoverColor': buttonTheme.getHoverColor(enabledRaisedButton).value,
    'colorScheme': colorSchemeToMap(buttonTheme.colorScheme),
  };
}

ButtonThemeData buttonThemeFromMap(Map<String, dynamic> data) {
  if (data == null) return null;

  return ButtonThemeData(
      textTheme: ButtonTextTheme.values[max(0, data['textTheme'])],
      minWidth: (data['minWidth'] as int).toDouble(),
      height: (data['height'] as int).toDouble(),
      padding: paddingFromMap(data['padding']),
      shape: buttonShapeFromMap(data['shape']),
      buttonColor: Color(data['buttonColor']),
      disabledColor: Color(data['disabledColor']),
      highlightColor: Color(data['highlightColor']),
      splashColor: Color(data['splashColor']),
      focusColor: Color(data['focusColor']),
      hoverColor: Color(data['hoverColor']),
      colorScheme: colorSchemeFromMap(data['colorScheme']));
}

String buttonShapeToCode(ShapeBorder border) {
  if (border is RoundedRectangleBorder) {
    return '''
    RoundedRectangleBorder(
      side: ${borderSideToCode(border.side)},
      borderRadius: BorderRadius.all(${(border.borderRadius as BorderRadius).topLeft}),
    )
''';
  }

  if (border is BeveledRectangleBorder) {
    return '''
    BeveledRectangleBorder(
      side: ${borderSideToCode(border.side)},
      borderRadius: BorderRadius.all(${(border.borderRadius as BorderRadius).topLeft}),
    )
''';
  }

  if (border is StadiumBorder)
    return '''StadiumBorder( side: ${borderSideToCode(border.side)} )''';

  if (border is CircleBorder)
    return '''CircleBorder( side: ${borderSideToCode(border.side)} )''';

  return 'null';
}

Map<String, dynamic> buttonShapeToMap(ShapeBorder border) {
  final type = getButtonShapeBorderType(border);

  if (border is RoundedRectangleBorder) {
    return {
      'type': type,
      'radius': borderRadiusToMap(border.borderRadius),
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  if (border is BeveledRectangleBorder) {
    return {
      'type': type,
      'radius': borderRadiusToMap(border.borderRadius),
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  if (border is StadiumBorder) {
    return {
      'type': type,
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  if (border is CircleBorder) {
    return {
      'type': type,
      'side':
          border.side == BorderSide.none ? 'none' : borderSideToMap(border.side)
    };
  }
  return {
    'type': type,
  };
}

ShapeBorder buttonShapeFromMap(Map<String, dynamic> data) {
  if (data['type'] == 'RoundedRectangleBorder')
    return RoundedRectangleBorder(
        borderRadius: borderRadiusFromMap(data['radius']),
        side: borderSideFromMap(data['side']));

  if (data['type'] == 'BeveledRectangleBorder')
    return BeveledRectangleBorder(
        borderRadius: borderRadiusFromMap(data['radius']),
        side: borderSideFromMap(data['side']));

  if (data['type'] == 'StadiumBorder')
    return StadiumBorder(side: borderSideFromMap(data['side']));

  if (data['type'] == 'CircleBorder')
    return CircleBorder(side: borderSideFromMap(data['side']));

  return RoundedRectangleBorder();
}

String getButtonShapeBorderType(ShapeBorder border) {
  if (border is RoundedRectangleBorder) return 'RoundedRectangleBorder';
  if (border is StadiumBorder) return 'StadiumBorder';
  if (border is CircleBorder) return 'CircleBorder';
  if (border is BeveledRectangleBorder) return 'BeveledRectangleBorder';

  return 'RoundedRectangleBorder';
}
