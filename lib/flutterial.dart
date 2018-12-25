import 'package:flutter/material.dart';
import 'package:flutterial_components/flutterial_components.dart';

class PanacheEditorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Row(
          children: [
            Expanded(child: ThemeEditor()),
            AppPreviewContainer(kIPhone6),
          ],
        ),
      ),
    );
  }
}
