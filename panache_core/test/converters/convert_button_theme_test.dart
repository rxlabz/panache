import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panache_core/src/converters/button_theme_converters.dart';

import 'mock_button_theme.dart';

void main() {
  ButtonThemeData buttonTheme;

  group('convert buttonTheme', () {
    /*setUp(() {
      final theme = ThemeData.light();
      buttonTheme = theme.buttonTheme;
    });*/

    test('buttonShapeToCode', () {
      expect(
          buttonShapeToCode(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
          roundedRectangleBorderCode);
      expect(buttonShapeToCode(BeveledRectangleBorder()),
          beveledRectangleBorderCode);
      expect(buttonShapeToCode(StadiumBorder()), stadiumBorderCode);
      expect(buttonShapeToCode(CircleBorder()), circleBorderCode);
    });

    test('buttonShapeToCode - with border', () {
      expect(
          buttonShapeToCode(
            RoundedRectangleBorder(
              side: BorderSide(color: Color(0xff000000), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          roundedRectangleBorderSideCode);

      expect(
          buttonShapeToCode(BeveledRectangleBorder(
              side: BorderSide(color: Color(0xff000000), width: 1.0))),
          beveledRectangleBorderSideCode);

      expect(
          buttonShapeToCode(StadiumBorder(
              side: BorderSide(color: Color(0xff000000), width: 1.0))),
          stadiumRectangleBorderSideCode);

      expect(
          buttonShapeToCode(CircleBorder(
              side: BorderSide(color: Color(0xff000000), width: 1.0))),
          circleBorderSideCode);
    });
  });
}
