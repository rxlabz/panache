import 'dart:convert';

import 'package:flutter/material.dart';

import 'utils/color_utils.dart';

class User {
  final String name;
  final String avatarPath;

  const User(this.name, this.avatarPath);
}

class PanacheTheme {
  final String id;
  final String name;
  final ColorSwatch primarySwatch;
  final Brightness brightness;

  const PanacheTheme({
    @required this.id,
    @required this.name,
    @required this.primarySwatch,
    @required this.brightness,
  });

  factory PanacheTheme.fromJson(String data) {
    final rawTheme = json.decode(data);
    return PanacheTheme(
      id: rawTheme['id'],
      name: rawTheme['name'],
      primarySwatch: swatchFor(color: Color(rawTheme['primarySwatch'])),
      brightness: Brightness.values[rawTheme['brightness']],
    );
  }

  String toJson() {
    final data = {
      'id': id,
      'name': name,
      'primarySwatch': primarySwatch.value,
      'brightness': Brightness.values.indexOf(brightness),
    };
    return json.encode(data);
  }

  @override
  String toString() {
    return 'PanacheTheme{'
        'id: $id, name: $name, '
        'primarySwatch: $primarySwatch, '
        'brightness: $brightness'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanacheTheme &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          primarySwatch == other.primarySwatch;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ primarySwatch.hashCode;
}
