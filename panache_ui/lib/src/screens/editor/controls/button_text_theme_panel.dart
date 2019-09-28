import 'package:flutter/material.dart';
import 'package:panache_ui/src/help/help.dart';

import 'control_container.dart';
import 'help_button.dart';

class ButtonTextThemeControl extends StatelessWidget {
  /*final ButtonThemeData buttonTheme;*/
  final ButtonTextTheme textTheme;
  final TextStyle labelStyle;
  final TextStyle dropdownTextStyle;
  /* final ButtonTextTheme buttonTextTheme; */
  final ValueChanged<ButtonTextTheme> onChange;

  const ButtonTextThemeControl({
    Key key,
    this.textTheme,
    this.labelStyle,
    this.dropdownTextStyle,
    /* this.buttonTextTheme, */
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ControlContainerBorder(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: <Widget>[
                Text('Text theme' , style: labelStyle),
                HelpButton(help: textThemeHelp)
              ],
            ),
          ),
          DropdownButton(
            style: dropdownTextStyle,
            value: textTheme,
            items: ButtonTextTheme.values
                .map(_buildButtonTextThemeSelectorItem)
                .toList(growable: false),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<ButtonTextTheme> _buildButtonTextThemeSelectorItem(
          ButtonTextTheme buttonTextTheme) =>
      DropdownMenuItem<ButtonTextTheme>(
        child: Text('$buttonTextTheme'.split('.').last),
        value: buttonTextTheme,
      );
}
