import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/converter_utils.dart';

import 'constants.dart';

enum RGB { R, G, B }

enum HSL { H, S, L }

const materialColorsNames = [
  "red",
  "pink",
  "purple",
  "deepPurple",
  "indigo",
  "blue",
  "lightBlue",
  "cyan",
  "teal",
  "green",
  "lightGreen",
  "lime",
  "yellow",
  "amber",
  "orange",
  "deepOrange",
  "brown",
  "blueGrey",
  "White",
  "Black",
  "Grey"
];

Color getMaterialColor(String name) => namedColors()
    .firstWhere((c) => c.name == name,
        orElse: () =>
            NamedColor(name: name, color: Color(int.parse(name, radix: 16))))
    .color;

String getMaterialName(Color color) => namedColors()
    .firstWhere((c) => c.color.value == color.value,
        orElse: () =>
            NamedColor(name: color.value.toRadixString(16), color: color))
    .name;

bool isMaterialPrimary(Color color) =>
    namedColors().where((c) => c.color.value == color.value).isNotEmpty;

/// look for the corresponding mmaterialColor or return a generated ColorSwatch
/// based on the selected color
///
MaterialColor swatchFor({Color color}) =>
    Colors.primaries.firstWhere((c) => c.value == color.value,
        orElse: () => newColorSwatch(color));

String materialSwatchCodeFor({Color color}) {
  return namedColors()
          .firstWhere((c) => c.color.value == color.value, orElse: () => null)
          ?.toString() ??
      customSwatchCode(color);
}

String customSwatchCode(Color color) {
  final shadesCode = getMaterialColorValues(color)
      .map((int k, Color v) => MapEntry(k, "${colorToCode(v)}\n\t\t"));
  return "MaterialColor(${color.value},$shadesCode)";
}

List<NamedColor> namedColors() {
  var colors = List<Color>.from(Colors.primaries, growable: true);
  colors.addAll([white, black, grey]);

  return colors.fold(
      [],
      (cumul, current) => cumul
        ..add(NamedColor(
            name: materialColorsNames[cumul.length], color: current)));
}

class NamedColor {
  final String name;
  final Color color;

  NamedColor({@required this.name, @required this.color});

  @override
  String toString() {
    return 'Colors.$name';
  }
}

bool isDark(Color c) => (c.red + c.green + c.blue) / 3 >= 146;

Color getContrastColor(Color c, {int limit: 450}) =>
    c.red + c.green + c.blue < limit ? Colors.white : Colors.black;

List<Widget> getMaterialSwatches(ValueChanged<Color> onSelection) {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([white, black, grey]);

  return colors
      .map((c) => InkWell(
            child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(
                    width: kSwatchSize, height: kSwatchSize, color: c)),
            onTap: () => onSelection(c),
          ))
      .toList();
}

///
/// MaterialColor/ColorSwatch from simple color
///
MaterialColor newColorSwatch(Color color, {bool opaque: true}) {
  final c = opaque ? color.withOpacity(1.0) : color;
  final swatch = getMaterialColorValues(c);
  return new MaterialColor(c.value, swatch);
}

///
/// get list of material color shades from simple [Color]
///
Map<int, Color> getMaterialColorValues(Color primary) => <int, Color>{
      50: getSwatchShade(primary, 50),
      100: getSwatchShade(primary, 100),
      200: getSwatchShade(primary, 200),
      300: getSwatchShade(primary, 300),
      400: getSwatchShade(primary, 400),
      500: getSwatchShade(primary, 500),
      600: getSwatchShade(primary, 600),
      700: getSwatchShade(primary, 700),
      800: getSwatchShade(primary, 800),
      900: getSwatchShade(primary, 900),
    };

///
/// color a color shade for material swatch value
Color getSwatchShade(Color c, int swatchValue) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness(1 - (swatchValue / 1000)).toColor();
}

/// return a list of all color of a materialColor
List<Color> getMaterialColorShades(MaterialColor color) => [
      color[50],
      color[100],
      color[200],
      color[300],
      color[400],
      color[500],
      color[600],
      color[700],
      color[800],
      color[900]
    ];

String colorToHex32(Color color) =>
    '#${color.value.toRadixString(16).padLeft(8, '0')}';

String colorToInt(Color color) =>
    '0x${color.value.toRadixString(16).padLeft(8, '0')}';

List<Color> getHueGradientColors({int steps: 36}) =>
    List.generate(steps, (value) => value).map<Color>((v) {
      final hsl = HSLColor.fromAHSL(1, v * (360 / steps), 0.67, 0.50);
      final rgb = hsl.toColor();
      return rgb.withOpacity(1);
    }).toList();

Color getMinSaturation(Color c) {
  final hsl = HSLColor.fromColor(c);
  final minS = hsl.withSaturation(0);
  return minS.toColor().withOpacity(1);
}

Color getMaxSaturation(Color c) =>
    HSLColor.fromColor(c).withSaturation(1).toColor();

const MaterialColor grey = const MaterialColor(
  _greyPrimaryValue,
  const <int, Color>{
    50: const Color(0xFFFAFAFA),
    100: const Color(0xFFF0F0F0),
    200: const Color(0xFFEEEEEE),
    300: const Color(0xFFCCCCCC),
    400: const Color(0xFFAAAAAA),
    500: const Color(_greyPrimaryValue),
    600: const Color(0xFF666666),
    700: const Color(0xFF404040),
    800: const Color(0xFF303030),
    900: const Color(0xFF202020),
  },
);
const int _greyPrimaryValue = 0xFF999999;

const MaterialColor white = const MaterialColor(
  _whitePrimaryValue,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(_whitePrimaryValue),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);
const int _whitePrimaryValue = 0xFFFFFFFF;

const MaterialColor black = const MaterialColor(
  _blackPrimaryValue,
  const <int, Color>{
    50: const Color(0xFF000000),
    100: const Color(0xFF000000),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: const Color(_blackPrimaryValue),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
