import 'package:flutter/material.dart';

import '../data.dart';

class ThemeController extends ValueNotifier {
  PanacheTheme _theme;
  PanacheTheme get theme => _theme;

  ThemeController(value) : super(value);

  initTheme({PanacheTheme theme}) {
    _theme = theme;
    notifyListeners();
  }

  bool isActivated(Subtheme subtheme) {
    theme.isActivated(subtheme);
  }

  bool activate(Subtheme subtheme, bool value) {
    theme.activate(subtheme, value);
  }
}
