import 'package:flutter/material.dart';
import 'package:flutterial/components/color_swatch.dart' as rx;
import 'package:flutterial/constants.dart';
import 'package:flutterial/show_custom_menu.dart';
import 'package:flutterial_components/flutterial_components.dart';

typedef void ColorChanged(Color c);

getMaterialSwatches(ColorChanged onSelection) {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([
    Colors.white,
    Colors.black,
    Colors.grey,
  ]);

  return colors
    ..map(
      (c) => InkWell(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                width: kSwatchSize,
                height: kSwatchSize,
                color: c,
              ),
            ),
            onTap: () => onSelection(c),
          ),
    ).toList();
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

List<PopupGridMenuItem<Color>> getColorMenuTileItems() => namedColors()
    .map(
      (c) => PopupGridMenuItem<Color>(
            value: c.color,
            child: GridTile(
              footer: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(c.name,
                    style: isDark(c.color) ? kDarkTextStyle : kLightTextStyle),
              ),
              child: Container(
                width: kSwatchSize,
                height: kSwatchSize,
                color: c.color,
              ),
            ),
          ),
    )
    .toList();

void openColorMenu(BuildContext context, {ColorChanged onSelection}) {
  final RenderBox renderBox = context.findRenderObject();
  final Offset topLeft = renderBox?.localToGlobal(Offset.zero);

  showGridMenu<Color>(
    context: context,
    elevation: 2.0,
    items: getColorMenuTileItems(),
    position: RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy,
      0.0,
      0.0,
    ),
  ).then<Null>(
    (Color newValue) {
      if (newValue == null) return null;
      if (onSelection != null) onSelection(newValue);
    },
  );
}

class ColorSelector extends StatelessWidget {
  final String label;
  final Color value;
  final ColorChanged onSelection;

  ColorSelector(this.label, this.value, this.onSelection);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey.shade100,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                    child: Text(
                      label,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    constraints: BoxConstraints.tightFor(width: 90.0)),
                InkWell(
                  onTap: () => openColorMenu(context, onSelection: onSelection),
                  child: rx.ColorSwatch(value),
                ),
              ],
            ),
          ),
        ),
      );
}
