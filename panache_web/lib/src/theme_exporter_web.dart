@JS()
library bridge;

import 'package:js/js.dart';

@JS('saveTheme')
external void jsSaveTheme(
  String content,
  String filename,
  void Function(bool result) onFileSaved,
);
