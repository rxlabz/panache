import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class WebPanacheEditorTopbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isMobileInPortrait;
  final ThemeModel model;
  final bool showCode;
  final ValueChanged<bool> onShowCodeChanged;

  WebPanacheEditorTopbar(
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
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          IconButton(icon: Icon(Icons.file_download), onPressed: saveTheme)
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
        IconButton(icon: Icon(Icons.file_download), onPressed: saveTheme)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void saveTheme() {
    model.exportTheme(name: 'theme.dart');
  }
}
