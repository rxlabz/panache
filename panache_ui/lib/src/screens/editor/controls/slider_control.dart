import 'package:flutter/material.dart';

import 'control_container.dart';

class SliderPropertyControl extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final double maxWidth;
  final bool showDivisions;
  final bool vertical;
  final ValueChanged<double> onValueChanged;

  SliderPropertyControl(this.value, this.onValueChanged,
      {this.label,
      this.min: 0.0,
      this.max: 112.0,
      this.maxWidth,
      this.showDivisions: true,
      this.vertical: false})
      : assert(value != null),
        assert(min != null),
        assert(max != null),
        assert(min <= max);

  @override
  SliderPropertyControlState createState() {
    return SliderPropertyControlState();
  }
}

class SliderPropertyControlState extends State<SliderPropertyControl> {
  double updatedValue;

  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    updatedValue = widget.value;
    textController = TextEditingController(text: '$updatedValue');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    textController.text = '$updatedValue';
    final constraints = widget.maxWidth != null
        ? BoxConstraints(maxWidth: widget.maxWidth)
        : BoxConstraints();
    return ControlContainerBorder(
        child: Flex(
      direction: widget.vertical ? Axis.vertical : Axis.horizontal,
      children: [
        Slider(
          value: updatedValue,
          min: widget.min,
          max: widget.max,
          divisions:
              widget.showDivisions ? (widget.max - widget.min) ~/ 4 : null,
          onChangeEnd: widget.onValueChanged,
          onChanged: (value) {
            setState(() {
              updatedValue = value;
            });
          },
        ),
        RichText(
          text: TextSpan(
              text: '${widget.label} : ',
              style: textTheme.subtitle,
              children: [
                TextSpan(
                  text: updatedValue.toStringAsFixed(2),
                  style: textTheme.body1,
                )
              ]),
        )
      ],
    ));
  }
}
