import 'package:flutter/material.dart';

import '../../../help/help.dart';
import 'control_container.dart';
import 'help_button.dart';

class SwitcherControl extends StatelessWidget {
  final String label;
  final String checkedLabel;
  final bool checked;
  final HelpData help;
  final ValueChanged<bool> onChange;

  final Axis direction;

  SwitcherControl({
    this.label,
    this.checkedLabel: '',
    this.checked,
    this.help,
    this.direction: Axis.horizontal,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.subtitle;

    return ControlContainerBorder(
      child: Flex(
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flex(
              direction: direction,
              children: <Widget>[
                Switch(value: checked, onChanged: onChange),
                Text(
                  checkedLabel,
                  style: labelStyle,
                ),
                if (label != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text(
                      label,
                      style: labelStyle,
                    ),
                  ),
                if (help != null) HelpButton(help: help),
              ],
            ),
          ]),
    );
  }
}
