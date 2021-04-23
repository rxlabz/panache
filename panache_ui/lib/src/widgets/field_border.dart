import 'package:flutter/material.dart';

class FieldBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const FieldBorder({
    Key key,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: child);
  }
}
