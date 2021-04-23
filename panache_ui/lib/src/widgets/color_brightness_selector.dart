import 'package:flutter/material.dart';

import '../../panache_ui.dart';
import '../help/help.dart';

class ColorBrightnessSelector extends StatelessWidget {
  final String label;
  final Color currentColor;
  final ValueChanged<Color> changeHandler;
  final bool isDark;
  final ValueChanged<bool> brightnessChangeHandler;
  final HelpData help;

  const ColorBrightnessSelector({Key key, this.label, this.currentColor, this.changeHandler, this.isDark, this.brightnessChangeHandler, this.help}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ColorSelector(
          label,
          currentColor,
          changeHandler,
          help: help,
        )),
        BrightnessSelector(label: 'Brightness', isDark: isDark, onChange: brightnessChangeHandler)
      ],
    );
  }
}
