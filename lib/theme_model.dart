import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterial_components/flutterial_components.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeModel extends Model {
  ThemeService _service;

  ThemeData get theme => _service.theme;

  ThemeModel({ThemeService service}) : _service = service;

  static ThemeModel of(BuildContext context) =>
      ScopedModel.of<ThemeModel>(context);

  void updateTheme(ThemeData updatedTheme) {
    _service.updateTheme(updatedTheme);
    notifyListeners();
  }
}
