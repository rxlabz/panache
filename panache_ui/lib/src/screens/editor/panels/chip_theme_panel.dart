import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/color_selector.dart';
import '../controls/shape_form_control.dart';
import '../controls/switcher_control.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

const _themeRef = 'chipTheme';

class ChipThemePanel extends StatelessWidget {
  final ThemeModel model;

  ChipThemeData get chipTheme => model.theme.chipTheme;

  ChipThemePanel(this.model);

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final labelStyle = appTextTheme.subtitle;
    final chipLabelStyle = chipTheme.labelStyle;
    final secondaryLabelStyle = chipTheme.secondaryLabelStyle;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          ColorSelector(
            'Background color',
            model.theme.chipTheme.backgroundColor,
            (color) =>
                _updateChipTheme(chipTheme.copyWith(backgroundColor: color)),
            padding: 2,
            maxLabelWidth: 250,
          ),
          getFieldsRow([
            ColorSelector(
              'Secondary selected color',
              model.theme.chipTheme.secondarySelectedColor,
              (color) => _updateChipTheme(
                  chipTheme.copyWith(secondarySelectedColor: color)),
              padding: 2,
            ),
            ColorSelector(
              'Selected color',
              model.theme.chipTheme.selectedColor,
              (color) =>
                  _updateChipTheme(chipTheme.copyWith(selectedColor: color)),
              padding: 2,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Disabled color',
              model.theme.chipTheme.disabledColor,
              (color) =>
                  _updateChipTheme(chipTheme.copyWith(disabledColor: color)),
              padding: 2,
            ),
            ColorSelector(
              'Delete icon color',
              model.theme.chipTheme.deleteIconColor,
              (color) =>
                  _updateChipTheme(chipTheme.copyWith(deleteIconColor: color)),
              padding: 2,
            ),
          ]),
          Divider(),
          _buildTextStyleControl(
            key: 'chip_textstyle',
            textStyle: chipLabelStyle,
            label: 'Label Style',
            styleName: 'labelStyle',
          ),
          Divider(),
          _buildTextStyleControl(
            key: 'chip_alternative_textstyle',
            textStyle: secondaryLabelStyle,
            label: 'Secondary Label Style',
            styleName: 'secondaryLabelStyle',
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ShapeFormControl(
                  onShapeChanged: (shapeBorder) =>
                      _updateChipTheme(chipTheme.copyWith(shape: shapeBorder)),
                  shape: chipTheme.shape,
                  labelStyle: labelStyle),
              SwitcherControl(
                checked: chipTheme.brightness == Brightness.dark,
                checkedLabel: 'Dark',
                direction: Axis.vertical,
                onChange: (value) => _onBrightnessChanged(
                    value ? Brightness.dark : Brightness.light,
                    labelStyle: appTextTheme.body1),
              ),
              /*Expanded(
                child: BrightnessSelector(
                  label: 'Brightness',
                  direction: Axis.horizontal,
                  isDark: chipTheme.brightness == Brightness.dark,
                  onBrightnessChanged: (value) => _onBrightnessChanged(value,
                      labelStyle: appTextTheme.body1),
                ),
              )*/
            ],
          ),
        ],
      ),
    );
  }

  TextStyleControl _buildTextStyleControl({
    @required String key,
    @required String label,
    @required TextStyle textStyle,
    @required String styleName,
  }) {
    return TextStyleControl(
      label,
      key: Key(key),
      style: textStyle,
      maxFontSize: 32,
      onColorChanged: (color) =>
          apply(textStyle.copyWith(color: color), styleName),
      onSizeChanged: (size) =>
          apply(textStyle.copyWith(fontSize: size), styleName),
      onWeightChanged: (isBold) => apply(
          textStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          styleName),
      onFontStyleChanged: (isItalic) => apply(
          textStyle.copyWith(
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          styleName),
      onLetterSpacingChanged: (double value) =>
          apply(textStyle.copyWith(letterSpacing: value), styleName),
      onLineHeightChanged: (double value) =>
          apply(textStyle.copyWith(height: value), styleName),
      onWordSpacingChanged: (double value) =>
          apply(textStyle.copyWith(wordSpacing: value), styleName),
      onDecorationChanged: (TextDecoration value) =>
          apply(textStyle.copyWith(decoration: value), styleName),
      onDecorationStyleChanged: (TextDecorationStyle value) =>
          apply(textStyle.copyWith(decorationStyle: value), styleName),
      onDecorationColorChanged: (Color value) =>
          apply(textStyle.copyWith(decorationColor: value), styleName),
    );
  }

  void apply(TextStyle style, String styleName) {
    final styleArgs = <Symbol, dynamic>{};
    styleArgs[Symbol(styleName)] = style;

    final args = <Symbol, dynamic>{};
    args[Symbol(_themeRef)] =
        Function.apply(chipTheme.copyWith, null, styleArgs);
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }

  void _onBrightnessChanged(Brightness value, {TextStyle labelStyle}) {
    final updatedTheme = model.theme.copyWith(
        chipTheme: ChipThemeData.fromDefaults(
      brightness: value,
      /*primaryColor: model.theme.primaryColor,*/
      secondaryColor: model.theme.primaryColor,
      labelStyle: labelStyle,
    ));
    model.updateTheme(updatedTheme);
  }

  _updateChipTheme(ChipThemeData chipTheme) {
    final updatedTheme = model.theme.copyWith(chipTheme: chipTheme);
    model.updateTheme(updatedTheme);
  }
}
