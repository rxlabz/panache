import 'package:flutter/material.dart';

class FontSizeSelector extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onValueChanged;

  FontSizeSelector(this.value, this.onValueChanged,
      {this.min: 0.0, this.max: 112.0})
      : assert(value != null),
        assert(min != null),
        assert(max != null),
        assert(min <= max);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text("Font size"),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 120.0),
            child: Slider(
              value: value,
              onChanged: onValueChanged,
              min: min,
              max: max,
            ),
          ),
          Text("${value.toStringAsFixed(1)}"),
        ],
      ),
    );
  }
}
