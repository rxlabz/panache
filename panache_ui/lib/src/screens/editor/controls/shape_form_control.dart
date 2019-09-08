import 'package:flutter/material.dart';

import 'control_container.dart';

enum BorderShapes {
  BeveledRectangleBorder,
  CircleBorder,
  RoundedRectangleBorder,
  StadiumBorder
}

final shapes = [
  BorderShapes.RoundedRectangleBorder,
  BorderShapes.CircleBorder,
  BorderShapes.BeveledRectangleBorder,
  BorderShapes.StadiumBorder
];

class ShapeFormControl extends StatelessWidget {
  final ShapeBorder shape;

  final ValueChanged<ShapeBorder> onShapeChanged;

  final TextStyle labelStyle;

  final Axis direction;

  const ShapeFormControl(
      {Key key,
      @required this.onShapeChanged,
      @required this.shape,
      this.direction: Axis.horizontal,
      this.labelStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _labelStyle = labelStyle ?? textTheme.subtitle;
    return ControlContainerBorder(
      padding: EdgeInsets.only(top: 6, bottom: 0, left: 8, right: 8),
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Shape',
              style: _labelStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: DropdownButton(
                style: textTheme.body2,
                value: _getShapeType(shape),
                items: shapes.map(_getShapeMenuItem).toList(),
                onChanged: (type) => onShapeChanged(_buildShape(type))),
          )
        ],
      ),
    );
  }

  DropdownMenuItem<BorderShapes> _getShapeMenuItem(BorderShapes shape) =>
      DropdownMenuItem(value: shape, child: Text('$shape'.split('.').last));

  ShapeBorder _buildShape(BorderShapes shape) {
    switch (shape) {
      case BorderShapes.StadiumBorder:
        return new StadiumBorder();
      case BorderShapes.CircleBorder:
        return new CircleBorder();
      case BorderShapes.BeveledRectangleBorder:
        return new BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(6.0));
      case BorderShapes.RoundedRectangleBorder:
        return new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0));
      default:
        return new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0));
    }
  }

  BorderShapes _getShapeType(ShapeBorder shape) {
    if (shape is RoundedRectangleBorder) return shapes[0];
    if (shape is CircleBorder) return shapes[1];
    if (shape is BeveledRectangleBorder) return shapes[2];
    if (shape is StadiumBorder) return shapes[3];

    return shapes[0];
  }
}
