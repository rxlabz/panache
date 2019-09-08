import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'controls/brightness_control.dart';
import 'controls/color_selector.dart';

class GlobalThemePropertiesControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ThemeModel.of(context);

    final isDark = model.theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ColorSelector(
              'Primary swatch',
              model.theme.primaryColor,
              (color) => _onSwatchSelection(model, swatchFor(color: color)),
              padding: 0,
            ),
          ),
          SizedBox(width: 10),
          BrightnessSelector(
            isDark: isDark,
            label: 'Brightness',
            onBrightnessChanged: (value) => _onBrightnessChanged(model, value),
          ),
        ],
      ),
    );
  }

  void _onBrightnessChanged(ThemeModel model, Brightness brightness) =>
      model.updateTheme(ThemeData.localize(
        ThemeData(
          primarySwatch:
              model.primarySwatch ?? swatchFor(color: model.theme.primaryColor),
          brightness: brightness,
        ),
        model.theme.textTheme,
      ));

  void _onSwatchSelection(ThemeModel model, MaterialColor swatch) {
    model.updateTheme(ThemeData.localize(
        ThemeData(primarySwatch: swatch, brightness: model.theme.brightness),
        model.theme.textTheme));
  }
}
