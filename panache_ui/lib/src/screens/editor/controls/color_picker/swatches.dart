import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

const _kGridSpacing = 6.0;

class ColorSwatchesWidget extends StatelessWidget {
  final Color color;

  ColorSwatchesWidget(this.color);

  @override
  Widget build(BuildContext context) {
    final c = newColorSwatch(color);

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - _kGridSpacing) / 2;
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Swatches',
                style: Theme.of(context).textTheme.subhead.copyWith(
                    color: getContrastColor(getSwatchShade(color, 700))),
              ),
            ),
            Wrap(
              spacing: _kGridSpacing,
              runSpacing: _kGridSpacing,
              children: getMaterialColorShades(c).map<Widget>((c) {
                return Container(
                  alignment: Alignment.center,
                  color: c,
                  width: itemWidth,
                  height: 60.0,
                  child: Text(colorToHex32(c),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: getContrastColor(c),
                      )),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
