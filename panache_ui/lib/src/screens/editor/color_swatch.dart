import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'controls/color_picker/colorpicker_dialog.dart';
//import 'controls/color_menu.dart';

class ColorSwatchControl extends StatelessWidget {
  final Color color;

  final ValueChanged<Color> onSelection;

  String get label {
    final namedPeer = namedColors().where((c) => c.color.value == color.value);
    return namedPeer.length > 0
        ? namedPeer.first.name
        : "#${color.value.toRadixString(16)}";
  }

  ColorSwatchControl({this.color, this.onSelection});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onSelection != null
          ? () => showColorPicker(
              context: context, onColor: onSelection, currentColor: color)
          : null
      /*openColorMenu(context, onSelection: onSelection, color: color)*/,
      child: Container(
        width: kSwatchSize,
        height: kSwatchSize,
        decoration: BoxDecoration(color: color),
      ));
}
