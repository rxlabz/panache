import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/color_selector.dart';
import '../controls/inputs_border_control.dart';
import '../controls/slider_control.dart';
import '../controls/switcher_control.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

const _themeRef = 'inputDecorationTheme';

class InputDecorationThemePanel extends StatelessWidget {
  final ThemeModel model;

  InputDecorationTheme get inputTheme => model.theme.inputDecorationTheme;

  InputDecorationThemePanel(this.model);

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        model.theme.textTheme.caption.copyWith(color: model.theme.hintColor);
    final helperStyle = inputTheme.helperStyle ?? baseStyle;
    final labelStyle = inputTheme.labelStyle ?? baseStyle;
    final hintStyle = inputTheme.hintStyle ?? baseStyle;
    final errorStyle = inputTheme.errorStyle ??
        baseStyle.copyWith(color: model.theme.errorColor);
    final counterStyle = inputTheme.counterStyle ?? baseStyle;
    final prefixStyle = inputTheme.prefixStyle ?? baseStyle;
    final suffixStyle = inputTheme.suffixStyle ?? baseStyle;

    final orientation = MediaQuery.of(context).orientation;
    final inPortrait = orientation == Orientation.portrait;
    final isLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;
    final useMobileLayout = !inPortrait && !isLargeLayout;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getFieldsRow([
            SwitcherControl(
              label: 'Filled',
              checked: inputTheme.filled,
              onChange: (filled) => _updateInputDecorationTheme(
                  _copyInputDecorationThemeWith(inputTheme, filled: filled)),
            ),
            ColorSelector(
              'Fill color',
              inputTheme.fillColor ?? Colors.white.withAlpha(0),
              (color) => _updateInputDecorationTheme(
                  _copyInputDecorationThemeWith(inputTheme,
                      fillColor: color, filled: true)),
              padding: 0,
            ),
          ]),
          getFieldsRow([
            InputBorderControl(
              label: 'Border',
              padding: 2,
              axis: Axis.vertical,
              border: inputTheme.border,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(
                    _copyInputDecorationThemeWith(inputTheme, border: value));
              },
            ),
            InputBorderControl(
              label: 'Error border',
              padding: 2,
              axis: Axis.vertical,
              border: inputTheme.errorBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    errorBorder: value));
              },
            )
          ]),
          getFieldsRow([
            InputBorderControl(
              label: 'Enabled border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.enabledBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    enabledBorder: value));
              },
            ),
            InputBorderControl(
              label: 'Disabled border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.disabledBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    disabledBorder: value));
              },
            ),
          ]),
          getFieldsRow([
            InputBorderControl(
              label: 'Focused border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.focusedBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    focusedBorder: value));
              },
            ),
            InputBorderControl(
              label: 'Focused error border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.focusedErrorBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    focusedErrorBorder: value));
              },
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: getFieldsRow([
              SwitcherControl(
                label: 'Is dense',
                checked: inputTheme.isDense,
                onChange: (value) => _updateInputDecorationTheme(
                    _copyInputDecorationThemeWith(inputTheme, isDense: value)),
              ),
              SwitcherControl(
                  label: 'Is collapsed',
                  checked: inputTheme.isCollapsed,
                  onChange: (value) =>
                      _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                        inputTheme,
                        isCollapsed: value,
                      ))),
            ]),
          ),
          SwitcherControl(
              label: 'Has floating label',
              checked: inputTheme.hasFloatingPlaceholder,
              onChange: (value) =>
                  _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    hasFloatingPlaceholder: value,
                  ))),
          Divider(),
          _buildTextStyleControl(
            key: 'ctrl-label_style',
            textStyle: labelStyle,
            label: 'Label style',
            styleName: 'labelStyle',
            useMobileLayout: useMobileLayout,
          ),
          _buildTextStyleControl(
            key: 'ctrl-hint_style',
            textStyle: hintStyle,
            label: 'Hint style',
            styleName: 'hintStyle',
            useMobileLayout: useMobileLayout,
          ),
          _buildTextStyleControl(
            key: 'ctrl-helper_style',
            textStyle: helperStyle,
            label: 'Helper style',
            styleName: 'helperStyle',
            useMobileLayout: useMobileLayout,
          ),
          _buildTextStyleControl(
            key: 'ctrl-error_style',
            textStyle: errorStyle,
            label: 'Error style',
            styleName: 'errorStyle',
            useMobileLayout: useMobileLayout,
          ),
          _buildTextStyleControl(
            key: 'ctrl-prefix_style',
            textStyle: prefixStyle,
            label: 'Prefix style',
            styleName: 'prefixStyle',
            useMobileLayout: useMobileLayout,
          ),
          _buildTextStyleControl(
            key: 'ctrl-suffix_style',
            textStyle: suffixStyle,
            label: 'Suffix style',
            styleName: 'suffixStyle',
            useMobileLayout: useMobileLayout,
          ),
          _buildTextStyleControl(
            key: 'ctrl-counter_style',
            textStyle: counterStyle,
            label: 'Counter style',
            styleName: 'counterStyle',
            useMobileLayout: useMobileLayout,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              color: Colors.white70,
              padding: const EdgeInsets.all(6.0),
              child: SliderPropertyControl(
                inputTheme.contentPadding?.vertical ?? 0,
                (double newValue) => _updateInputDecorationTheme(
                    _copyInputDecorationThemeWith(inputTheme,
                        contentPadding: EdgeInsets.all(newValue))),
                label: 'Content Padding',
                max: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateInputDecorationTheme(InputDecorationTheme inputTheme) =>
      model.updateTheme(model.theme.copyWith(inputDecorationTheme: inputTheme));

  TextStyleControl _buildTextStyleControl({
    @required String key,
    @required String label,
    @required TextStyle textStyle,
    @required String styleName,
    @required bool useMobileLayout,
  }) {
    return TextStyleControl(
      label,
      key: Key(key),
      useMobileLayout: useMobileLayout,
      style: textStyle,
      maxFontSize: 24,
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
        Function.apply(_copyInputDecorationThemeWith, [inputTheme], styleArgs);
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }
}

InputDecorationTheme _copyInputDecorationThemeWith(
  InputDecorationTheme theme, {
  InputBorder border,
  EdgeInsetsGeometry contentPadding,
  TextStyle counterStyle,
  InputBorder disabledBorder,
  InputBorder enabledBorder,
  InputBorder errorBorder,
  int errorMaxLines,
  TextStyle errorStyle,
  Color fillColor,
  bool filled,
  InputBorder focusedBorder,
  InputBorder focusedErrorBorder,
  bool hasFloatingPlaceholder,
  TextStyle helperStyle,
  TextStyle hintStyle,
  bool isCollapsed,
  bool isDense,
  TextStyle labelStyle,
  TextStyle prefixStyle,
  TextStyle suffixStyle,
}) {
  return InputDecorationTheme(
    border: border ?? theme.border,
    contentPadding: contentPadding ?? theme.contentPadding,
    counterStyle: counterStyle ?? theme.counterStyle,
    disabledBorder: disabledBorder ?? theme.disabledBorder,
    enabledBorder: enabledBorder ?? theme.enabledBorder,
    errorBorder: errorBorder ?? theme.errorBorder,
    errorMaxLines: errorMaxLines ?? theme.errorMaxLines,
    errorStyle: errorStyle ?? theme.errorStyle,
    fillColor: fillColor ?? theme.fillColor,
    filled: filled ?? theme.filled,
    focusedBorder: focusedBorder ?? theme.focusedBorder,
    focusedErrorBorder: focusedErrorBorder ?? theme.focusedErrorBorder,
    hasFloatingPlaceholder:
        hasFloatingPlaceholder ?? theme.hasFloatingPlaceholder,
    helperStyle: helperStyle ?? theme.helperStyle,
    hintStyle: hintStyle ?? theme.hintStyle,
    isCollapsed: isCollapsed ?? theme.isCollapsed,
    isDense: isDense ?? theme.isDense,
    labelStyle: labelStyle ?? theme.labelStyle,
    prefixStyle: prefixStyle ?? theme.prefixStyle,
    suffixStyle: suffixStyle ?? theme.suffixStyle,
  );
}
