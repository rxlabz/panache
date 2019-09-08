import 'package:flutter/material.dart';

import 'control_container.dart';

class BrightnessSelector extends StatelessWidget {
  final String label;
  final bool isDark;
  final ValueChanged<bool> onChange;
  final ValueChanged<Brightness> onBrightnessChanged;

  final Axis direction;

  BrightnessSelector(
      {this.label,
      this.isDark,
      this.onChange,
      this.onBrightnessChanged,
      this.direction: Axis.vertical});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.subtitle;
    return ControlContainerBorder(
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              label,
              style: labelStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Switch(value: isDark, onChanged: _onChange),
                Text('Dark'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onChange(bool value) {
    if (onChange != null) onChange(value);

    if (onBrightnessChanged != null)
      onBrightnessChanged(value ? Brightness.dark : Brightness.light);
  }
}
