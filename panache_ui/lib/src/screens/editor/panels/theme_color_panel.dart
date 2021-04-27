import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../../../help/help.dart';
import '../../../widgets/color_brightness_selector.dart';
import '../../../widgets/fields_row.dart';
import '../controls/color_selector.dart';

class ThemeColorPanel extends StatelessWidget {
  final ThemeModel themeModel;

  ThemeData get theme => themeModel.theme;

  ThemeColorPanel(this.themeModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: kPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorBrightnessSelector(
            label: 'Primary color',
            currentColor: theme.primaryColor,
            help: primaryColorHelp,
            changeHandler: (c) => themeModel.updateColor(property: "primaryColor", color: c),
            isDark: theme.primaryColorBrightness == Brightness.dark,
            brightnessChangeHandler: (isDark) => _onPrimaryBrightnessChanged(
              themeModel,
              isDark ? Brightness.dark : Brightness.light,
            ),
          ),
          FieldsRow([
            /* FIXME disabled => visible */
            ColorSelector(
              'Primary color light ( generated )',
              theme.primaryColorLight,
              null,
              /*(c) => themeModel.updateColor(
                  property: "primaryColorLight", color: c),*/
              padding: 2,
            ),
            ColorSelector(
              'Primary color dark',
              theme.primaryColorDark,
              (c) => themeModel.updateColor(property: "primaryColorDark", color: c),
              padding: 2,
            ),
          ]),
          ColorBrightnessSelector(
            label: 'Accent color',
            currentColor: theme.accentColor,
            help: accentColorHelp,
            changeHandler: (c) => themeModel.updateColor(property: "accentColor", color: c),
            isDark: theme.accentColorBrightness == Brightness.dark,
            brightnessChangeHandler: (isDark) => _onAccentBrightnessChanged(
              themeModel,
              isDark ? Brightness.dark : Brightness.light,
            ),
          ),
          ColorBrightnessSelector(
            label: 'Scaffold background color',
            currentColor: theme.scaffoldBackgroundColor,
            changeHandler: (c) => themeModel.updateColor(property: "scaffoldBackgroundColor", color: c),
            isDark: theme.brightness == Brightness.dark,
            brightnessChangeHandler: (isDark) {
              final updatedTheme = theme.copyWith(brightness: isDark ? Brightness.dark : Brightness.light);
              themeModel.updateTheme(updatedTheme);
            },
          ),
          FieldsRow([
            ColorSelector(
              'Button color',
              theme.buttonColor,
              (color) => themeModel.updateTheme(theme.copyWith(buttonColor: color, buttonTheme: theme.buttonTheme.copyWith(buttonColor: color))),
              padding: 2,
            ),
            ColorSelector(
              'Disabled color',
              theme.disabledColor,
              (color) => themeModel.updateTheme(theme.copyWith(disabledColor: color, buttonTheme: theme.buttonTheme.copyWith(disabledColor: color))),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Canvas color',
              theme.canvasColor,
              (c) => themeModel.updateColor(property: "canvasColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Card color',
              theme.cardColor,
              (c) => themeModel.updateColor(property: "cardColor", color: c),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Unselected widget color',
              theme.unselectedWidgetColor,
              (c) => themeModel.updateColor(property: "unselectedWidgetColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Toggleable Active Color',
              theme.toggleableActiveColor,
              (c) => themeModel.updateColor(property: "toggleableActiveColor", color: c),
              padding: 2,
            )
          ]),
          FieldsRow([
            ColorSelector(
              'BottomAppBar color',
              theme.bottomAppBarColor,
              (c) => themeModel.updateColor(property: "bottomAppBarColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Text cursor color',
              theme.textSelectionTheme.cursorColor,
              (color) => themeModel.updateTheme(theme.copyWith(textSelectionTheme: theme.textSelectionTheme.copyWith(cursorColor: color))),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Error color',
              theme.errorColor,
              (c) => themeModel.updateColor(property: "errorColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Hint color',
              theme.hintColor,
              (c) => themeModel.updateColor(property: "hintColor", color: c),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Highlight color',
              theme.highlightColor,
              (c) => themeModel.updateColor(property: "highlightColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Splash color',
              theme.splashColor,
              (c) => themeModel.updateColor(property: "splashColor", color: c),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Indicator color',
              theme.indicatorColor,
              (c) => themeModel.updateColor(property: "indicatorColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Dialog background color',
              theme.dialogBackgroundColor,
              (c) => themeModel.updateColor(property: "dialogBackgroundColor", color: c),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Divider color',
              theme.dividerColor,
              (c) => themeModel.updateColor(property: "dividerColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Secondary header widget color',
              theme.secondaryHeaderColor,
              (c) => themeModel.updateColor(property: "secondaryHeaderColor", color: c),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Selected row color',
              theme.selectedRowColor,
              (c) => themeModel.updateColor(property: "selectedRowColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Background color',
              theme.backgroundColor,
              (c) => themeModel.updateColor(property: "backgroundColor", color: c),
              padding: 2,
            ),
          ]),
          FieldsRow([
            ColorSelector(
              'Text selection color',
              theme.textSelectionTheme.selectionColor,
              (color) => themeModel.updateTheme(theme.copyWith(textSelectionTheme: theme.textSelectionTheme.copyWith(selectionColor: color))),

              //  (c) => themeModel.updateColor(property: "textSelectionColor", color: c),
              padding: 2,
            ),
            ColorSelector(
              'Text selection handler color',
              theme.textSelectionTheme.selectionHandleColor,
              (color) => themeModel.updateTheme(theme.copyWith(textSelectionTheme: theme.textSelectionTheme.copyWith(selectionHandleColor: color))),
              // (c) => themeModel.updateColor(property: "textSelectionHandleColor", color: c),
              padding: 2,
            ),
          ]),
          /*ColorSchemeControl(
            scheme: theme.colorScheme,
            onSchemeChanged: (scheme) =>
                themeModel.updateTheme(theme.copyWith(colorScheme: scheme)),
          )*/
        ],
      ),
    );
  }

  void _onPrimaryBrightnessChanged(ThemeModel themeModel, Brightness brightness) {
    themeModel.updateTheme(theme.copyWith(primaryColorBrightness: brightness));
  }

  void _onAccentBrightnessChanged(ThemeModel themeModel, Brightness brightness) => themeModel.updateTheme(theme.copyWith(accentColorBrightness: brightness));
}
