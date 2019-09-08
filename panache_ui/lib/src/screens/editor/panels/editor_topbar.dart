import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../drive_menu.dart';

class MobilePanacheEditorTopbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isMobileInPortrait;
  final ThemeModel model;
  final bool showCode;
  final ValueChanged<bool> onShowCodeChanged;

  MobilePanacheEditorTopbar(
      {this.isMobileInPortrait,
      this.model,
      this.showCode,
      this.onShowCodeChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final title = Text.rich(TextSpan(text: 'Panache', children: [
      TextSpan(
          text: ' alpha',
          style: textTheme.caption.copyWith(color: Colors.blueGrey.shade900))
    ]));

    if (isMobileInPortrait) {
      return AppBar(
        title: title,
        leading: IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () => Scaffold.of(context).openDrawer()),
        actions: [
          IconButton(
            icon: Icon(showCode ? Icons.mobile_screen_share : Icons.keyboard),
            onPressed: () => onShowCodeChanged(!showCode),
          ),
          DriveMenu(model: model),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          )
        ],
      );
    }

    return AppBar(
      title: title,
      actions: <Widget>[
        FlatButton.icon(
          textColor: Colors.blueGrey.shade50,
          icon: Icon(Icons.mobile_screen_share),
          label: Text('App preview'),
          onPressed: showCode ? () => onShowCodeChanged(false) : null,
        ),
        FlatButton.icon(
          textColor: Colors.blueGrey.shade50,
          icon: Icon(Icons.keyboard),
          label: Text('Code preview'),
          onPressed: showCode ? null : () => onShowCodeChanged(true),
        ),
        DriveMenu(model: model)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
