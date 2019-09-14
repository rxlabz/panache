import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class DesktopExportService extends ExportService {
  DartFormatter _formatter;

  DesktopExportService() {
    _formatter = DartFormatter();
  }

  @override
  String toCode(ThemeData theme) {
    //print('DesktopExportService.toCode... ${super.toCode(theme)}');
    return _formatter.format(super.toCode(theme));
  }
}
