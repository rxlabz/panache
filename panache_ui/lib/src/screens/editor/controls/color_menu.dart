import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../color_stream.dart';
import '../show_custom_menu.dart';

void openColorMenu(BuildContext context,
    {ValueChanged<Color> onSelection, Color color}) {
  final RenderBox renderBox = context.findRenderObject();
  final Offset topLeft = renderBox?.localToGlobal(Offset.zero);

  final colorStream = ColorStream(color ?? Colors.blue);

  showGridMenu<Color>(
    context: context,
    elevation: 2.0,
    items: getColorMenuTileItems(colorStream, color),
    colorStream: colorStream,
    position: RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy,
      0.0,
      0.0,
    ),
  ).then<Null>(
    (Color newValue) {
      colorStream.dispose();
      if (newValue == null) return;
      if (onSelection != null) onSelection(newValue);
    },
  );
}

List<PopupMenuItem<Color>> getColorMenuItems() {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([
    Colors.white,
    Colors.black,
    Colors.grey,
  ]);

  return colors
      .map(
        (c) => PopupMenuItem<Color>(
          value: c,
          child: Container(
            width: kSwatchSize,
            height: kSwatchSize,
            color: c,
          ),
        ),
      )
      .toList();
}

List<PopupGridMenuItem<Color>> getColorMenuTileItems(
        ColorStream colorStream, Color currentColor) =>
    namedColors()
        .map(
          (c) => PopupGridMenuItem<Color>(
            value: c.color,
            onSelection: colorStream.selectColor,
            selected: c.color == currentColor,
            child: GridTile(
              footer: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(c.name,
                    style: isDark(c.color) ? kDarkTextStyle : kLightTextStyle),
              ),
              child: Container(
                width: kSwatchSize,
                height: kSwatchSize,
                decoration: BoxDecoration(
                    color: c.color,
                    border: Border.all(
                        style: c.color == currentColor
                            ? BorderStyle.solid
                            : BorderStyle.none,
                        width: 3,
                        color: Colors.white)),
              ),
            ),
          ),
        )
        .toList();
