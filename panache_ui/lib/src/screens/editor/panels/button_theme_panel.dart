import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/shape_form_control.dart';
import '../controls/slider_control.dart';
import '../controls/switcher_control.dart';
import '../controls/color_selector.dart';
import '../controls/control_container.dart';
import '../controls/help_button.dart';
import '../editor_utils.dart';
import '../../../help/help.dart';

class ButtonThemePanel extends StatelessWidget {
  final ThemeModel model;

  ButtonThemeData get buttonTheme => model.theme.buttonTheme;

  ButtonThemePanel(this.model);

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final labelStyle = appTextTheme.subtitle;
    final dropdownTextStyle = appTextTheme.body2;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade200,
      child: Column(
        children: <Widget>[
          getFieldsRow([
            ColorSelector(
              'Raised button fill color',
              buttonTheme.getFillColor(enabledRaisedButton),
              /* TODO update theme.buttonColor ? */
              (color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(buttonColor: color)),
              padding: 2,
              help: buttonColorHelp,
            ),
            ColorSelector(
              'Raised button disabled color',
              buttonTheme.getDisabledFillColor(disabledRaisedButton),
              (color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(disabledColor: color)),
              padding: 2,
              help: disabledColorHelp,
            ),
          ]),
          getFieldsRow([
            /* longpress / pressed color */
            ColorSelector(
              'Highlight color',
              buttonTheme.getHighlightColor(enabledRaisedButton),
              (color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(highlightColor: color)),
              padding: 2,
              help: highlightColorHelp,
            ),
            /* tap ink color */
            ColorSelector(
              'Splash color',
              buttonTheme.getSplashColor(enabledRaisedButton),
              (color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(splashColor: color)),
              padding: 2,
              help: splashColorHelp,
            ),
          ]),
          getFieldsRow([
            /* focus color */
            ColorSelector(
              'Focus color',
              buttonTheme.getFocusColor(enabledRaisedButton),
              (color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(focusColor: color)),
              padding: 2,
              help: focusColorHelp,
            ),
            /* pointer on */
            ColorSelector(
              'Hover color',
              buttonTheme.getHoverColor(enabledRaisedButton),
              (color) => _onButtonThemeChanged(
                  buttonTheme.copyWith(hoverColor: color)),
              padding: 2,
              help: hoverColorHelp,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _buildButtonTextThemeSelector(
              buttonTheme.textTheme,
              labelStyle: labelStyle,
              dropdownTextStyle: dropdownTextStyle,
              context: context,
            ),
            ShapeFormControl(
              onShapeChanged: (shape) =>
                  _onButtonThemeChanged(buttonTheme.copyWith(shape: shape)),
              shape: buttonTheme.shape,
              labelStyle: labelStyle,
              direction: Axis.vertical,
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SliderPropertyControl(
                    buttonTheme.padding.horizontal,
                    (padding) => _onButtonThemeChanged(buttonTheme.copyWith(
                        padding: EdgeInsets.symmetric(horizontal: padding))),
                    label: 'Horizontal padding',
                    max: 64,
                    vertical: true,
                  ),
                ),
                SwitcherControl(
                  label: 'Align dropdown',
                  checked: buttonTheme.alignedDropdown,
                  direction: Axis.vertical,
                  onChange: (aligned) => _onButtonThemeChanged(
                      buttonTheme.copyWith(alignedDropdown: aligned)),
                ),
              ],
            ),
          ),
          _buildButtonSizeControl(
              buttonTheme), /*
          ColorSchemeControl(
            scheme: buttonTheme.colorScheme,
            onSchemeChanged: (scheme) => _onButtonThemeChanged(
                buttonTheme.copyWith(colorScheme: scheme)),
          )*/
        ],
      ),
    );
  }

  Widget _buildButtonSizeControl(ButtonThemeData theme) {
    final minWidth = theme.minWidth;
    final height = theme.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      child: getFieldsRow([
        SliderPropertyControl(
          minWidth,
          (width) =>
              _onButtonThemeChanged(buttonTheme.copyWith(minWidth: width)),
          label: 'Min width',
          min: 48,
          max: 256,
          vertical: true,
        ),
        SliderPropertyControl(
            height,
            (height) =>
                _onButtonThemeChanged(buttonTheme.copyWith(height: height)),
            label: 'Height',
            min: 24,
            max: 128,
            maxWidth: 200,
            vertical: true),
      ]),
    );
  }

  Widget _buildButtonTextThemeSelector(
    ButtonTextTheme buttonTextTheme, {
    TextStyle labelStyle,
    TextStyle dropdownTextStyle,
    BuildContext context,
  }) {
    return Expanded(
      child: ControlContainerBorder(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  Text('Text theme', style: labelStyle),
                  HelpButton(help: textThemeHelp)
                ],
              ),
            ),
            DropdownButton(
                style: dropdownTextStyle,
                value: buttonTextTheme,
                items: ButtonTextTheme.values
                    .map(_buildButtonTextThemeSelectorItem)
                    .toList(growable: false),
                onChanged: (newButtonTextTheme) => _onButtonThemeChanged(
                    buttonTheme.copyWith(textTheme: newButtonTextTheme))),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<ButtonTextTheme> _buildButtonTextThemeSelectorItem(
          ButtonTextTheme buttonTextTheme) =>
      DropdownMenuItem<ButtonTextTheme>(
        child: Text('$buttonTextTheme'.split('.').last),
        value: buttonTextTheme,
      );

  void _onButtonThemeChanged(ButtonThemeData value) {
    model.updateTheme(
      model.theme.copyWith(buttonTheme: value),
    );
  }
}
