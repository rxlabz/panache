// ignore: uri_does_not_exists
import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class ScreenshotRenderer extends StatelessWidget {
  final PanacheTheme theme;
  final String basePath;
  final bool removable;
  final Size size;
  final ValueChanged<PanacheTheme> onThemeSelection;
  final ValueChanged<PanacheTheme> onDeleteTheme;

  const ScreenshotRenderer({
    Key key,
    @required this.theme,
    @required this.basePath,
    @required this.size,
    this.onThemeSelection,
    this.onDeleteTheme,
    this.removable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenshotPath = '$basePath/${theme.id}.png';
    final imageFile = File(screenshotPath);

    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        InkWell(
          onTap: () => removable ? null : onThemeSelection(theme),
          child: Container(
            child: Material(
                elevation: 2.0,
                child: imageFile.existsSync() && !kIsWeb
                    ? Image.file(
                        imageFile,
                        width: size.width,
                        height: size.height,
                        fit: BoxFit.fitHeight,
                      )
                    : SizedBox(width: size.width, height: size.height, child: Icon(Icons.color_lens))),
          ),
        ),
        removable
            ? Positioned(
                right: 0,
                top: 0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: CircleBorder(), primary: Colors.red),
                  onPressed: () => onDeleteTheme(theme),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
