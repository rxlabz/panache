import 'package:flutter/material.dart';

import 'control_container.dart';

class SwitcherControl extends StatelessWidget {
  final String label;
  final String checkedLabel;
  final bool checked;
  final ValueChanged<bool> onChange;

  final Axis direction;

  SwitcherControl({
    this.label,
    this.checkedLabel: '',
    this.checked,
    this.direction: Axis.horizontal,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.subtitle;

    final children = <Widget>[
      Flex(
        direction: direction,
        children: <Widget>[
          Switch(value: checked, onChanged: onChange),
          Text(
            checkedLabel,
            style: labelStyle,
          ),
        ],
      ),
    ];
    if (label != null)
      children.add(Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: Text(
          label,
          style: labelStyle,
        ),
      ));

    return ControlContainerBorder(
      child: Flex(
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children),
    );
  }
}
