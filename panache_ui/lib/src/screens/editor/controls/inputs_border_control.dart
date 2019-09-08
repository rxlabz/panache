import 'package:flutter/material.dart';

enum InputBorders { UnderlineInputBorder, OutlineInputBorder, None }

final borders = [
  InputBorders.UnderlineInputBorder,
  InputBorders.OutlineInputBorder,
  InputBorders.None,
];

class InputBorderControl extends StatelessWidget {
  final InputBorder border;

  final ValueChanged<InputBorder> onShapeChanged;

  final String label;
  final TextStyle labelStyle;
  final double padding;
  final Axis axis;

  get vertical => axis == Axis.vertical;

  const InputBorderControl({
    Key key,
    @required this.onShapeChanged,
    @required this.border,
    @required this.label,
    this.axis: Axis.horizontal,
    this.labelStyle,
    this.padding: 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _labelStyle = labelStyle ?? textTheme.subtitle;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: padding, horizontal: vertical ? 2 : 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
            vertical: padding, horizontal: vertical ? 0 : 8),
        child: Flex(
          direction: axis,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: vertical ? 0 : 4.0,
                /*bottom: vertical ? 6 : 0,*/
              ),
              child: Text(
                label,
                style: _labelStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: DropdownButton(
                  style: textTheme.body2,
                  value: _getShapeType(border),
                  items: borders.map(_getShapeMenuItem).toList(),
                  onChanged: (type) => onShapeChanged(_buildBorder(type))),
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<InputBorders> _getShapeMenuItem(InputBorders shape) =>
      DropdownMenuItem(value: shape, child: Text(_shapeLabel(shape)));

  InputBorder _buildBorder(InputBorders shape) {
    switch (shape) {
      case InputBorders.OutlineInputBorder:
        return OutlineInputBorder();
      case InputBorders.None:
        return InputBorder.none;
      default:
        return UnderlineInputBorder();
    }
  }

  String _shapeLabel(InputBorders shape) {
    switch (shape) {
      case InputBorders.OutlineInputBorder:
        return 'Outline';
      case InputBorders.None:
        return 'None';
      default:
        return 'Underline';
    }
  }

  InputBorders _getShapeType(InputBorder border) {
    if (border == null) return borders[0];
    if (border is UnderlineInputBorder) return borders[0];
    if (border is OutlineInputBorder) return borders[1];
    return borders[2];
  }
}
