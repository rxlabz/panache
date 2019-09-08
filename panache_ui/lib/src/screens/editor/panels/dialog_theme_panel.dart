import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/shape_form_control.dart';

final showIndicatorOptions = [
  ShowValueIndicator.always,
  ShowValueIndicator.never,
  ShowValueIndicator.onlyForContinuous,
  ShowValueIndicator.onlyForDiscrete,
];

class DialogThemePanel extends StatelessWidget {
  final ThemeModel model;

  DialogTheme get dialogTheme => model.theme.dialogTheme;

  DialogThemePanel(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding,
      constraints: BoxConstraints.expand(height: 100),
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ShapeFormControl(
              shape: dialogTheme.shape,
              onShapeChanged: (shape) =>
                  _updateDialogTheme(DialogTheme(shape: shape)),
            ),
          ),
        ],
      ),
    );
  }

  void _updateDialogTheme(DialogTheme dialogTheme) =>
      model.updateTheme(model.theme.copyWith(dialogTheme: dialogTheme));
}
