import 'package:flutter/material.dart';
import 'package:flutterial/components/app_preview.dart';
import 'package:flutterial/theme_editor.dart';
import 'package:flutterial/theme_model.dart';
import 'package:scoped_model/scoped_model.dart';

class FlutterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildConfigurator(),
        AppPreviewContainer(kIPhone6),
      ],
    );
  }

  Widget _buildConfigurator() =>
      ScopedModelDescendant<ThemeModel>(builder: (context, child, model) {
        return Expanded(child: ThemeEditor(model.theme));
      });
}
