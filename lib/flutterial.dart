import 'package:flutter/material.dart';
import 'package:flutterial_components/flutterial_components.dart';
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
