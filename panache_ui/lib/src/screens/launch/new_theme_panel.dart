import 'package:flutter/material.dart';

import 'package:panache_core/panache_core.dart';

import '../../screens/editor/controls/color_selector.dart';
import '../../screens/editor/controls/brightness_control.dart';

class NewThemePanel extends StatelessWidget {
  final ColorSwatch newThemePrimary;

  final Brightness initialBrightness;

  final ValueChanged<ColorSwatch> onSwatchSelection;

  final ValueChanged<Brightness> onBrightnessSelection;
  final VoidCallback onNewTheme;

  final Orientation orientation;

  bool get isDark => initialBrightness == Brightness.dark;

  const NewThemePanel({
    Key key,
    @required this.newThemePrimary,
    @required this.initialBrightness,
    @required this.onSwatchSelection,
    @required this.onBrightnessSelection,
    @required this.onNewTheme,
    @required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inPortrait = orientation == Orientation.portrait;
    final isLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;
    final isMobileInLandscape = !inPortrait && !isLargeLayout;

    final newThemeLabel = Padding(
      padding: EdgeInsets.only(
          bottom: isMobileInLandscape ? 0 : 16,
          right: isMobileInLandscape ? 16 : 0),
      child: Text('New theme', style: textTheme.title),
    );
    final btCreate = Padding(
      padding: EdgeInsets.only(top: isMobileInLandscape ? 2 : 16.0),
      child: RaisedButton.icon(
        shape: StadiumBorder(),
        color: newThemePrimary,
        icon: Icon(Icons.color_lens, color: newThemePrimary[100]),
        label: Text('Create', style: TextStyle(color: Colors.white)),
        onPressed: onNewTheme,
      ),
    );
    return Container(
      padding: EdgeInsets.all(isMobileInLandscape ? 6 : 16.0),
      color: Colors.white54,
      child: Column(
        children: <Widget>[
          isLargeLayout || inPortrait ? newThemeLabel : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                  child: ColorSelector('Primary swatch', newThemePrimary,
                      (color) => onSwatchSelection(swatchFor(color: color)))),
              SizedBox(width: 10),
              BrightnessSelector(
                isDark: isDark,
                label: 'Brightness',
                onBrightnessChanged: onBrightnessSelection,
              ),
            ]
              ..insert(
                  0, !inPortrait && !isLargeLayout ? newThemeLabel : SizedBox())
              ..add(!inPortrait && !isLargeLayout ? btCreate : SizedBox()),
          ),
          isLargeLayout || inPortrait ? btCreate : SizedBox()
        ],
      ),
    );
  }
}
