import 'package:flutter/material.dart';
import 'package:panache_ui/src/help/help.dart';

import 'control_container.dart';
import 'help_button.dart';

class ButtonBarLayoutBehaviorControl extends StatelessWidget {
  final ButtonBarLayoutBehavior behavior ;
  final TextStyle labelStyle;
  final TextStyle dropdownTextStyle;
  final ValueChanged<ButtonBarLayoutBehavior> onChange;

  const ButtonBarLayoutBehaviorControl({
    Key key,
    this.behavior,
    this.labelStyle,
    this.dropdownTextStyle,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ControlContainerBorder(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: <Widget>[
                Text('Layout Behavior' , style: labelStyle),
                HelpButton(help: textThemeHelp)
              ],
            ),
          ),
          DropdownButton<ButtonBarLayoutBehavior>(
            style: dropdownTextStyle,
            value: behavior,
            items: ButtonBarLayoutBehavior.values
                .map(_buildItem)
                .toList(growable: false),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<ButtonBarLayoutBehavior> _buildItem(
    ButtonBarLayoutBehavior behavior) =>
      DropdownMenuItem<ButtonBarLayoutBehavior>(
        child: Text('$behavior'.split('.').last),
        value: behavior,
      );
}


