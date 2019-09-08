import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:scoped_model/scoped_model.dart';

import '../preview/app_preview.dart';
import 'panels/editor_topbar.dart';
import 'panels/editor_topbar_web.dart';
import 'theme_editor.dart';

class PanacheEditorScreen extends StatefulWidget {
  @override
  PanacheEditorScreenState createState() {
    return new PanacheEditorScreenState();
  }
}

class PanacheEditorScreenState extends State<PanacheEditorScreen> {
  bool showCode = false;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final inPortrait = orientation == Orientation.portrait;
    final isLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;
    final isMobileInPortrait = inPortrait && !isLargeLayout;

    return ScopedModelDescendant<ThemeModel>(
        builder: (BuildContext context, Widget child, ThemeModel model) {
      final topbar = kIsWeb
          ? WebPanacheEditorTopbar(
              isMobileInPortrait: isMobileInPortrait,
              model: model,
              showCode: showCode,
              onShowCodeChanged: (value) => setState(() => showCode = value),
            )
          : MobilePanacheEditorTopbar(
              isMobileInPortrait: isMobileInPortrait,
              model: model,
              showCode: showCode,
              onShowCodeChanged: (value) => setState(() => showCode = value),
            );
      return isMobileInPortrait
          ? _buildMobilePortraitLayout(isMobileInPortrait, model, topbar)
          : _buildLargeLayout(isMobileInPortrait, model, topbar);
    });
  }

  Scaffold _buildLargeLayout(
      bool isMobileInPortrait, ThemeModel model, Widget topbar) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: topbar,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ThemeEditor(model: model)),
          Expanded(child: AppPreviewContainer(kIPhone6, showCode: showCode)),
        ],
      ),
    );
  }

  Scaffold _buildMobilePortraitLayout(
      bool isMobileInPortrait, ThemeModel model, Widget topbar) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: topbar,
      drawer: Drawer(child: ThemeEditor(model: model)),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: AppPreviewContainer(kIPhone6, showCode: showCode)),
        ],
      ),
    );
  }
}
