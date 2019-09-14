import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpanderHeader extends StatelessWidget {
  /// icon color
  final Color color;

  /// header label
  final String label;

  /// header icon
  final IconData icon;

  /// label aspect / size mode
  final bool dense;

  /// subtheme activation state
  final bool disabled;

  /// on activation state change
  final ValueChanged<bool> onChanged;

  ExpanderHeader({
    @required this.color,
    @required this.label,
    @required this.icon,
    @required this.disabled,
    @required this.onChanged,
    this.dense,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Checkbox(value: disabled, onChanged: onChanged),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 8.0),
            child: Icon(icon, color: color),
          ),
          Text(label, style: dense ? textTheme.subhead : textTheme.title),
        ],
      ),
    );
  }
}
