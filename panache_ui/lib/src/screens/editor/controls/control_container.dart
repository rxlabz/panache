import 'package:flutter/material.dart';

class ControlContainerBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const ControlContainerBorder({
    Key key,
    this.child,
    this.margin: const EdgeInsets.all(4.0),
    this.padding: const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: child),
    );
  }
}
