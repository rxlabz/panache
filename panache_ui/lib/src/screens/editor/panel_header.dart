import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpanderHeader extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final bool dense;

  ExpanderHeader(
      {@required this.color,
      @required this.label,
      @required this.icon,
      this.dense}) {
    print('Label... $label $dense');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 8.0),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          Text(
            label,
            style: dense ? textTheme.subhead : textTheme.title,
          ),
        ],
      ),
    );
  }
}
