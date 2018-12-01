import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpanderHeader extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  ExpanderHeader(
      {@required this.color, @required this.label, @required this.icon});

  @override
  Widget build(BuildContext context) => Row(
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
            style: Theme.of(context).textTheme.headline,
          ),
        ],
      );
}
