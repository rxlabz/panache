import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../../../help/help.dart';
import '../color_swatch.dart';
import 'control_container.dart';
import 'help_button.dart';

class ColorSelector extends StatelessWidget {
  final String label;
  final Color value;
  final ValueChanged<Color> onSelection;
  final double padding;

  final double maxLabelWidth;

  final HelpData help;

  ColorSelector(this.label, this.value, this.onSelection,
      {this.padding: 8.0, this.maxLabelWidth: 100, this.help});

  String get colorLabel {
    final namedPeer =
        namedColors().where((c) => c.color?.value == value?.value);
    return namedPeer.length > 0
        ? namedPeer.first.name
        : "#${value.value.toRadixString(16)}";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ControlContainerBorder(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                      text: '$label\n',
                      style: Theme.of(context).textTheme.subtitle,
                      children: [
                        TextSpan(
                            text: colorLabel,
                            style: textTheme.overline.copyWith(height: 1.5)
                            /*kDarkTextStyle.copyWith(height: 2)*/)
                      ]),
                ),
                if (help != null) HelpButton(help: help)
              ],
            ),
          ),
          ColorSwatchControl(color: value, onSelection: onSelection),
        ],
      ),
    );
  }
}
