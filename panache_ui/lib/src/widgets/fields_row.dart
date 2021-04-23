import 'package:flutter/material.dart';

class FieldsRow extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;

  const FieldsRow(this.children, {Key key, this.direction = Axis.horizontal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHorizontal = direction == Axis.horizontal;

    return Flex(
      direction: direction,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: isHorizontal ? MainAxisSize.max : MainAxisSize.min,
      children: children.map((widget) => isHorizontal ? Expanded(child: widget) : widget).toList(growable: false),
    );
  }
}
