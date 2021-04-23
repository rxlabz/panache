import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/text_style_control.dart';

class TypographyThemePanel extends StatelessWidget {
  final TextTheme txtTheme;
  final String themeRef;
  final ThemeModel model;

  const TypographyThemePanel({
    Key key,
    @required this.txtTheme,
    @required this.themeRef,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.shade200,
        padding: kPadding,
        child: Column(
          children: _buildTextThemeEditorFields(model),
        ),
      );

  List<Widget> _buildTextThemeEditorFields(ThemeModel model) {
    final headline = txtTheme.headline5;
    final title = txtTheme.headline6;
    final subhead = txtTheme.subtitle1;
    final subtitle = txtTheme.subtitle2;
    final bodyText2 = txtTheme.bodyText1;
    final bodyText1 = txtTheme.bodyText2;
    final caption = txtTheme.caption;
    final overline = txtTheme.overline;
    final button = txtTheme.button;
    final headline4 = txtTheme.headline4;
    final headline3 = txtTheme.headline3;
    final headline2 = txtTheme.headline2;
    final headline1 = txtTheme.headline1;

    final styleNames = [
      TextStyleControlData(styleName: 'headline', style: headline),
      TextStyleControlData(styleName: 'title', style: title),
      TextStyleControlData(styleName: 'subhead', style: subhead),
      TextStyleControlData(styleName: 'subtitle', style: subtitle),
      TextStyleControlData(styleName: 'bodyText2', style: bodyText2),
      TextStyleControlData(styleName: 'bodyText1', style: bodyText1),
      TextStyleControlData(styleName: 'caption', style: caption),
      TextStyleControlData(styleName: 'overline', style: overline),
      TextStyleControlData(styleName: 'button', style: button),
      TextStyleControlData(styleName: 'headline4', style: headline4),
      TextStyleControlData(styleName: 'headline3', style: headline3),
      TextStyleControlData(styleName: 'headline2', style: headline2),
      TextStyleControlData(styleName: 'headline1', style: headline1),
    ];

    return styleNames.map((data) {
      return TextStyleControl(
        data.styleName,
        style: data.style,
        onColorChanged: (color) => apply(data.style.copyWith(color: color), data.styleName),
        onSizeChanged: (size) {
          print('TypographyThemePanel._buildTextThemeEditorFields... $size ${data.style}');
          apply(data.style.copyWith(fontSize: size), data.styleName);
        },
        onWeightChanged: (isBold) => apply(
          data.style.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          data.styleName,
        ),
        onFontStyleChanged: (isItalic) => apply(
          data.style.copyWith(fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          data.styleName,
        ),
        onLetterSpacingChanged: (spacing) => apply(data.style.copyWith(letterSpacing: spacing), data.styleName),
        onWordSpacingChanged: (spacing) => apply(data.style.copyWith(wordSpacing: spacing), data.styleName),
        onLineHeightChanged: (lineHeight) => apply(data.style.copyWith(height: lineHeight), data.styleName),
        onDecorationChanged: (decoration) => apply(data.style.copyWith(decoration: decoration), data.styleName),
        onDecorationStyleChanged: (decorationStyle) => apply(data.style.copyWith(decorationStyle: decorationStyle), data.styleName),
        onDecorationColorChanged: (color) => apply(data.style.copyWith(decorationColor: color), data.styleName),
      );
    }).toList();
  }

  void apply(TextStyle style, String styleName) {
    final styleArgs = <Symbol, dynamic>{};
    styleArgs[Symbol(styleName)] = style;

    final args = <Symbol, dynamic>{};
    args[Symbol(themeRef)] = Function.apply(txtTheme.copyWith, null, styleArgs);
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }
}

class TextStyleControlData {
  final TextStyle style;
  final String styleName;

  TextStyleControlData({this.style, this.styleName});
}
