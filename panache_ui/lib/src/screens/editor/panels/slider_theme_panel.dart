import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/color_selector.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

final showIndicatorOptions = [
  ShowValueIndicator.always,
  ShowValueIndicator.never,
  ShowValueIndicator.onlyForContinuous,
  ShowValueIndicator.onlyForDiscrete,
];

///
/// [ ] trackHeight
/// [ ] overlappingShapeStrokeColor
/// [ ] tickMarkShape: [SliderTickMarkShape]
/// [ ] trackShape: [SliderTrackShape]
///
/// [ ] rangeTickMarkShape: [RangerSliderTickMarkShape]
/// [ ] rangeThumbShape : [RangeSliderThumbShape]
/// [ ] rangeTrackShape : [RangeSliderTrackShape]
/// [ ] rangeValueIndicatorShape : [RangeSliderValueIndicatorShape]
///
/// [x] activeTrackColor
/// [x] inactiveTrackColor
/// [x] disabledActiveTrackColor
/// [x] disabledInactiveTrackColor
///
/// [x] activeTickMarkColor
/// [x] inactiveTickMarkColor
/// [x] disabledActiveTickMarkColor
/// [x] disabledInactiveTickMarkColor
///
/// [x] thumbColor
/// [x] disabledThumbColor
/// [ ] thumbShape
/// [ ] disableThumbColor
///
/// [x] overlayColor
/// [ ] overlayShape: [SliderComponentShape]
///
/// [x] valueIndicatorColor
/// [x] valueIndicatorShape: [SliderComponentShape]
///
/// [x] showValueIndicator => [ShowValueIndicator]
/// [x] valueIndicatorTextStyle
///
/// [ ] minThumbSeparation: double
/// ---------
///
/// [-] thumbShape => [SliderComponentShape] => needs custom panache lib
///
/// [-] valueIndicatorShape => [SliderComponentShape] => needs custom panache lib
///
class SliderThemePanel extends StatelessWidget {
  final ThemeModel model;

  SliderThemeData get sliderTheme => model.theme.sliderTheme;

  SliderThemePanel(this.model);

  Color get thumbColor =>
      model.theme.sliderTheme.thumbColor ?? model.theme.primaryColor;

  TextStyle get indicatorStyle =>
      model.theme.sliderTheme.valueIndicatorTextStyle;

  @override
  Widget build(BuildContext context) {
    print('SliderThemePanel.build... ${model.theme.sliderTheme.toString()}');

    print(
        'SliderThemePanel.build... model.theme.sliderTheme.valueIndicatorColor ${model.theme.sliderTheme.valueIndicatorColor}');
    print(
        'SliderThemePanel.build... model.theme.sliderTheme.overlayColor ${model.theme.sliderTheme.overlayColor}');

    final textTheme = Theme.of(context).textTheme;
    final overlayColor = sliderTheme.overlayColor ?? thumbColor.withAlpha(0xB2);
    final valueIndicatorColor = sliderTheme.valueIndicatorColor ?? thumbColor;
    print('SliderThemePanel.build... overlayColor $overlayColor');

    print(
        'SliderThemePanel.build... overlayColor ${Theme.of(context).sliderTheme.overlayColor}');
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Show value indicator',
                style: textTheme.subtitle,
              ),
              DropdownButton(
                  style: textTheme.body2,
                  value: sliderTheme.showValueIndicator,
                  items: showIndicatorOptions
                      .map(_buildIndicatorOptions)
                      .toList(growable: false),
                  onChanged: (value) => _updateSliderTheme(
                      sliderTheme.copyWith(showValueIndicator: value))),
            ],
          ),
          getFieldsRow([
            ColorSelector(
              'Thumb color',
              thumbColor,
              (color) =>
                  _updateSliderTheme(sliderTheme.copyWith(thumbColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Disabled thumb color',
              sliderTheme.disabledThumbColor ?? thumbColor.withAlpha(0xB2),
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledThumbColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Value indicator color',
              valueIndicatorColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(valueIndicatorColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Overlay color',
              overlayColor,
              (color) =>
                  _updateSliderTheme(sliderTheme.copyWith(overlayColor: color)),
              padding: 0,
            ),
          ]),
          /*
          getFieldsRow([
            ColorSelector(
              'Active track color',
              sliderTheme.activeTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(activeTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Active tick mark color',
              sliderTheme.activeTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(activeTickMarkColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Inactive track color',
              sliderTheme.inactiveTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(inactiveTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Inactive tick mark color',
              sliderTheme.inactiveTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(inactiveTickMarkColor: color)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            ColorSelector(
              'Disabled Active track color',
              sliderTheme.disabledActiveTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledActiveTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Disabled Active tick mark color',
              sliderTheme.disabledActiveTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledActiveTickMarkColor: color)),
              padding: 0,
            ),
          ]),*/
          /*getFieldsRow([
            ColorSelector(
              'Disabled Inactive track color',
              sliderTheme.disabledInactiveTrackColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledInactiveTrackColor: color)),
              padding: 0,
            ),
            ColorSelector(
              'Disabled Inactive tick mark color',
              sliderTheme.disabledInactiveTickMarkColor,
              (color) => _updateSliderTheme(
                  sliderTheme.copyWith(disabledInactiveTickMarkColor: color)),
              padding: 0,
            ),
          ]),*/
          /*_buildValueIndicatorTextStyleControl()*/
        ],
      ),
    );
  }

  DropdownMenuItem<ShowValueIndicator> _buildIndicatorOptions(
          ShowValueIndicator value) =>
      DropdownMenuItem(
        child: Text('$value'.split('.').last),
        value: value,
      );

  void _updateSliderTheme(SliderThemeData sliderTheme) =>
      model.updateTheme(model.theme.copyWith(sliderTheme: sliderTheme));

  Widget _buildValueIndicatorTextStyleControl() {
    print(
        'SliderThemePanel._buildValueIndicatorTextStyleControl $indicatorStyle');
    return TextStyleControl(
      'Value indicator text style',
      style: indicatorStyle,
      maxFontSize: 20,
      onColorChanged: (c) => _updateSliderTheme(sliderTheme.copyWith(
          valueIndicatorTextStyle: indicatorStyle.copyWith(color: c))),
      onFontStyleChanged: (bool isItalic) =>
          _updateSliderTheme(sliderTheme.copyWith(
              valueIndicatorTextStyle: indicatorStyle.copyWith(
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      ))),
      onSizeChanged: (size) => _updateSliderTheme(sliderTheme.copyWith(
          valueIndicatorTextStyle: indicatorStyle.copyWith(fontSize: size))),
      onWeightChanged: (bool isBold) => _updateSliderTheme(sliderTheme.copyWith(
          valueIndicatorTextStyle: indicatorStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal))),
      onLetterSpacingChanged: (double value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(letterSpacing: value))),
      onLineHeightChanged: (double value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle:
                  sliderTheme.valueIndicatorTextStyle.copyWith(height: value))),
      onWordSpacingChanged: (double value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(wordSpacing: value))),
      onDecorationChanged: (TextDecoration value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(decoration: value))),
      onDecorationStyleChanged: (TextDecorationStyle value) =>
          _updateSliderTheme(sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(decorationStyle: value))),
      onDecorationColorChanged: (Color value) => _updateSliderTheme(
          sliderTheme.copyWith(
              valueIndicatorTextStyle: sliderTheme.valueIndicatorTextStyle
                  .copyWith(decorationColor: value))),
    );
  }
}
