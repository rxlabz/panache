import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import '../controls/color_selector.dart';
import '../controls/slider_control.dart';
import '../editor_utils.dart';

final showIndicatorOptions = [
  ShowValueIndicator.always,
  ShowValueIndicator.never,
  ShowValueIndicator.onlyForContinuous,
  ShowValueIndicator.onlyForDiscrete,
];

class IconThemePanel extends StatelessWidget {
  final ThemeModel model;

  IconThemeData get iconTheme => model.theme.iconTheme;

  IconThemeData get primaryIconTheme => model.theme.primaryIconTheme;

  IconThemeData get accentIconTheme => model.theme.accentIconTheme;

  IconThemePanel(this.model);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Icon theme', style: textTheme.subhead),
          ColorSelector(
            'Color',
            iconTheme.color,
            (color) => _updateIconTheme(iconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow([
            SliderPropertyControl(
              iconTheme.size ?? 12,
              (size) => _updateIconTheme(iconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              maxWidth: 140.0,
              vertical: true,
            ),
            SliderPropertyControl(
              iconTheme.opacity ?? 1.0,
              (opacity) =>
                  _updateIconTheme(iconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0.0,
              max: 1.0,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          Divider(
            height: 32,
          ),
          Text('Primary icon theme', style: textTheme.subhead),
          ColorSelector(
            'Color',
            primaryIconTheme.color,
            (color) => _updatePrimaryIconTheme(
                primaryIconTheme.copyWith(color: color)),
            padding: 0,
          ),
          getFieldsRow([
            SliderPropertyControl(
              primaryIconTheme.size ?? 12,
              (size) => _updatePrimaryIconTheme(
                  primaryIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              vertical: true,
            ),
            SliderPropertyControl(
              primaryIconTheme.opacity ?? 1.0,
              (opacity) => _updatePrimaryIconTheme(
                  primaryIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0.0,
              max: 1.0,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          Divider(
            height: 32,
          ),
          Text('Accent icon theme', style: textTheme.subhead),
          ColorSelector(
            'Color',
            accentIconTheme.color,
            (color) =>
                _updateAccentIconTheme(accentIconTheme.copyWith(color: color)),
            padding: 0,
          ),
          getFieldsRow([
            SliderPropertyControl(
              accentIconTheme.size ?? 12,
              (size) =>
                  _updateAccentIconTheme(accentIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              vertical: true,
            ),
            SliderPropertyControl(
              accentIconTheme.opacity ?? 1.0,
              (opacity) => _updateAccentIconTheme(
                  accentIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0.0,
              max: 1.0,
              vertical: true,
              showDivisions: false,
            ),
          ]),
        ],
      ),
    );
  }

  void _updateIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(iconTheme: iconTheme));

  void _updatePrimaryIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(primaryIconTheme: iconTheme));

  void _updateAccentIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(accentIconTheme: iconTheme));
}
