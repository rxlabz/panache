import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'logo.dart';
import 'new_theme_panel.dart';

class LaunchLayout extends StatelessWidget {
  final ThemeModel model;
  final bool editMode;
  final ColorSwatch newThemePrimary;
  final Brightness initialBrightness;
  final void Function(ColorSwatch value) onSwatchSelection;
  final void Function(Brightness value) onBrightnessSelection;
  final Function(ThemeModel model) newTheme;
  final VoidCallback toggleEditMode;
  final List<Widget> Function(List<PanacheTheme> themes,
      {String basePath, Size size}) buildThemeThumbs;

  const LaunchLayout(
      {Key key,
      this.model,
      this.editMode,
      this.newThemePrimary,
      this.initialBrightness,
      this.onSwatchSelection,
      this.onBrightnessSelection,
      this.newTheme,
      this.toggleEditMode,
      this.buildThemeThumbs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print('LaunchLayout.build => constraints $constraints');
        return buildDefaultLayout(context, model, constraints);
      },
    );
  }

  Column buildDefaultLayout(
      BuildContext context, ThemeModel model, BoxConstraints constraints) {
    final useLargeLayout = constraints.biggest.height >= 700;

    final orientation = MediaQuery.of(context).orientation;
    final inPortrait = orientation == Orientation.portrait;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        PanacheLogo(
          minimized: !inPortrait && !useLargeLayout,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 520),
          child: NewThemePanel(
            orientation: orientation,
            newThemePrimary: newThemePrimary,
            initialBrightness: initialBrightness,
            onSwatchSelection: onSwatchSelection,
            onBrightnessSelection: onBrightnessSelection,
            onNewTheme: () => newTheme(model),
          ),
        ),
        SizedBox()
        /* FIXME model.themes?.isNotEmpty ?? false
            ? _buildHistoryThumbs(useLargeLayout, model)
            : SizedBox()*/
      ],
    );
  }

  Widget _buildHistoryThumbs(bool useLargeLayout, ThemeModel model) {
    final thumbSize = useLargeLayout ? Size(142, 250) : Size(56, 92);
    final elements = [
      Align(
        alignment: Alignment.topRight,
        child: FlatButton(
            child: Text(
              editMode ? 'Done' : 'Edit',
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.blueGrey),
            ),
            onPressed: toggleEditMode),
      ),
      Container(
        color: Colors.blueGrey.shade200,
        constraints: BoxConstraints.expand(
            height: thumbSize.height + (useLargeLayout ? 40 : 20)),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          shrinkWrap: true,
          itemExtent: thumbSize.width + 40,
          scrollDirection: Axis.horizontal,
          semanticChildCount: model.themes?.length ?? 0,
          children: buildThemeThumbs(
              model.themes.where(fileExists).toList() ?? [],
              basePath: '${model.dir?.path ?? ''}/themes',
              size: thumbSize),
        ),
      )
    ];
    return Column(children: elements);
    /*return useLargeLayout
        ? Column(children: elements)
        : Stack(children: elements.reversed.toList());*/
  }

  bool fileExists(PanacheTheme theme) {
    return File(model.themeDataPath(theme)).existsSync();
  }
}
