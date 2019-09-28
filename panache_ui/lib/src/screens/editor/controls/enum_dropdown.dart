import 'package:flutter/material.dart';

import '../../../help/help.dart';
import 'control_container.dart';
import 'help_button.dart';

class EnumDropDownField<T> extends StatelessWidget{
  final T fieldValue ;
  final Iterable<T> fieldOptions ;
  final TextStyle labelStyle;
  final TextStyle dropdownTextStyle;
  final ValueChanged<T> onChange;

  const EnumDropDownField({
    Key key,
    this.fieldValue,
    this.fieldOptions,
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
          DropdownButton<T>(
            style: dropdownTextStyle,
            value: fieldValue,
            items: fieldOptions
              .map(_buildItem)
              .toList(growable: false),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<T> _buildItem(
    T behavior) =>
    DropdownMenuItem<T>(
      child: Text('$behavior'.split('.').last),
      value: behavior,
    );
}