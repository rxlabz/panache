import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls.dart';

class ThemeFieldFactory {
  Widget build(
    String propertyName,
    String panelId,
    PropertyDescription propertyDescription,
    dynamic propertyValue,
    Function(String name, String panelId, dynamic value) onChange,
    ) {
    switch (propertyDescription.type) {
      case Color:
        return ColorSelector(
          propertyName,
          propertyValue ?? Color(0x00000000),
            (color) => onChange(propertyName, panelId, color),
          help: propertyDescription.help,
        );

      case Brightness:
        return BrightnessSelector(
          label: propertyName,
          help: propertyDescription.help,
          direction: Axis.horizontal,
          isDark:
          propertyValue != null ? propertyValue == Brightness.dark : false,
        );

      case ButtonTextTheme:
        return EnumDropDownField<ButtonTextTheme>(
          fieldValue: propertyValue,
          fieldOptions: ButtonTextTheme.values,
          onChange: (textTheme) => onChange(propertyName, panelId, textTheme),
        );

      case ButtonBarLayoutBehavior:
        return EnumDropDownField<ButtonBarLayoutBehavior>(
          fieldValue: propertyValue,
          fieldOptions: ButtonBarLayoutBehavior.values,
          onChange: (behavior) => onChange(propertyName, panelId, behavior),
        );

      case double:
      /*case int:*/
        return SliderPropertyControl(
          propertyValue,
            (value) => onChange(propertyName, panelId, value),
          label: propertyName,
        );

      case EdgeInsetsGeometry:
        return SliderPropertyControl(
          (propertyValue as EdgeInsetsGeometry)?.horizontal ?? 4
          /*const EdgeInsets.all(4)*/,
            (value) => onChange(
            propertyName, panelId, EdgeInsets.symmetric(horizontal: value)),
          label: propertyName,
        );

      case bool:
        return SwitcherControl(
          label: propertyName,
          /* FIXME checkedLabel: propertyValue,*/
          checked: propertyValue,
          help: propertyDescription.help,
          onChange: (value) => onChange(propertyName, panelId, value),
        );

      case ShapeBorder:
        return ShapeFormControl(
          shape: propertyValue,
          onShapeChanged: (value) => onChange(propertyName, panelId, value),
        );

      case TextStyle:
        print('ThemeFieldFactory.build... $propertyName $propertyValue');
        return TextStyleControl(
          propertyName,
          style: propertyValue,
          onChange: (TextStyle textStyle) =>
            onChange(propertyName, panelId, textStyle),
        );
      default:
        return Text('...');
    }
  }

  DropdownMenuItem<ButtonTextTheme> _buildButtonTextThemeSelectorItem(
    ButtonTextTheme buttonTextTheme) =>
    DropdownMenuItem<ButtonTextTheme>(
      child: Text('$buttonTextTheme'.split('.').last),
      value: buttonTextTheme,
    );
}
