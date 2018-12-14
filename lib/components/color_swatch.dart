import 'package:flutter/material.dart';
import 'package:flutterial/constants.dart';
import 'package:flutterial_components/flutterial_components.dart';

class ColorSwatch extends StatelessWidget {
  final Color color;

  String get label {
    final namedPeer = namedColors().where((c) => c.color.value == color.value);
    return namedPeer.length > 0
        ? namedPeer.first.name
        : "#${color.value.toRadixString(16)}";
  }

  ColorSwatch(this.color);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              label,
              style: kDarkTextStyle,
            ),
          ),
          Container(
            width: kSwatchSize,
            height: kSwatchSize,
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(blurRadius: 2.5, color: Colors.grey.shade400)
              ],
            ),
          ),
        ],
      );
}
