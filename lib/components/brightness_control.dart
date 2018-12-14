import 'package:flutter/material.dart';

class BrightnessSelector extends StatelessWidget {
  final String label;
  final bool isDark;
  final ValueChanged<bool> onChange;

  BrightnessSelector({this.label, this.isDark, this.onChange});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("$label : Light"),
            Switch(value: isDark, onChanged: onChange),
            Text('Dark')
          ],
        ),
      );
}
