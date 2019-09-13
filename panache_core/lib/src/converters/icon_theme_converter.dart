import 'package:flutter/material.dart';

import 'converter_utils.dart';

String iconThemeToCode(IconThemeData theme) {
  final iconTheme = IconThemeData.fallback().merge(theme);
  return '''IconThemeData(
      color: ${colorToCode(iconTheme.color)},
      opacity: ${iconTheme.opacity},
      size: ${iconTheme.size},
    )''';
}

Map<String, dynamic> iconThemeToMap(IconThemeData theme) {
  final iconTheme = IconThemeData.fallback().merge(theme);
  return {
    'color': iconTheme.color.value,
    'opacity': iconTheme.opacity,
    'size': iconTheme.size,
  };
}

IconThemeData iconThemeFromMap(Map<String, dynamic> data) {
  if (data == null) return null;
  return IconThemeData(
    color: Color(data['color']),
    opacity: data['opacity'] ?? 1.0,
    size: data['size'] ?? 12.0,
  );
}
