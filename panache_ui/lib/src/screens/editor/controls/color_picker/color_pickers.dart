import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import './color_slider.dart';

typedef void ColorCallback(Color color);

typedef Widget ColorSliderBuilder({
  @required Color startColor,
  @required Color endColor,
  @required Color thumbColor,
  @required Key sliderKey,
  @required ValueChanged<double> onChange,
  List<Color> colors,
  double value,
  double minValue,
  maxValue,
});

Widget buildSlider<RGB>(
        {@required Color startColor,
        @required Color endColor,
        @required Color thumbColor,
        @required RGB channel,
        Key sliderKey,
        List<Color> colors,
        double value,
        minValue: 0.0,
        maxValue: 1.0,
        ValueChanged<double> onChange}) =>
    GradientSlider(
      key: sliderKey,
      label: value < 1 && value > 0
          ? value.toStringAsFixed(2)
          : value.toInt().toString(),
      value: min(max(minValue, value), maxValue),
      startColor: startColor ?? colors.first,
      endColor: endColor ?? colors.last,
      colors: colors,
      thumbColor: thumbColor,
      min: minValue,
      max: maxValue,
      onChanged: (newValue) => onChange(newValue),
    );

class RGBPicker extends StatefulWidget {
  RGBPicker(
      {@required this.color,
      this.onColor,
      this.dynamicBackground: false,
      this.orientation});

  final ColorCallback onColor;
  final Color color;
  final bool dynamicBackground;
  final Orientation orientation;

  @override
  RGBPickerState createState() => new RGBPickerState(color);
}

class RGBPickerState extends State<RGBPicker> {
  Color _color;

  set color(Color color) {
    _color = color;
    widget.onColor(_color);
  }

  double _r = 0.0;

  set r(double r) {
    _r = r;
    updateColor();
  }

  double _g = 0.0;

  set g(double g) {
    _g = g;
    updateColor();
  }

  double _b = 0.0;

  set b(double b) {
    _b = b;
    updateColor();
  }

  RGBPickerState(this._color) {
    _updateColorComponents();
  }

  void _updateColorComponents() {
    _r = _color.red.toDouble();
    _g = _color.green.toDouble();
    _b = _color.blue.toDouble();
  }

  void updateColor() => setState(
      () => color = Color.fromRGBO(_r.toInt(), _g.toInt(), _b.toInt(), 1.0));

  @override
  void didUpdateWidget(RGBPicker oldWidget) {
    if (widget.color != oldWidget.color) {
      _color = widget.color;
      _updateColorComponents();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('RGBPickerState.build... $_color');
    final hsl = HSLColor.fromColor(_color);
    final shade50 = hsl.withLightness(.95).toColor();
    final bgColor =
        widget.dynamicBackground ? shade50.withOpacity(1) : Colors.white;

    return Container(
      color: bgColor,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RGBSliderRow(
              sliderKey: Key('sldR'),
              sliderBuilder: buildSlider,
              startColor: Colors.black,
              endColor: Color.fromRGBO(255, 0, 0, 1.0),
              thumbColor: Color.fromRGBO(_color.red, 0, 0, 1),
              value: _r,
              label: 'Red',
              labelStyle: TextStyle(color: Colors.red.shade600, fontSize: 12),
              orientation: widget.orientation,
              maxValue: 255.0,
              onChange: (value) => setState(() => r = value)),
          RGBSliderRow(
              sliderKey: Key('sldG'),
              sliderBuilder: buildSlider,
              startColor: Colors.black,
              endColor: Color.fromRGBO(0, 255, 0, 1.0),
              thumbColor: Color.fromRGBO(0, _color.green, 0, 1),
              value: _g,
              label: 'Green',
              labelStyle: TextStyle(color: Colors.green.shade600, fontSize: 12),
              orientation: widget.orientation,
              maxValue: 255.0,
              onChange: (value) => setState(() => g = value)),
          RGBSliderRow(
              sliderKey: Key('sldB'),
              sliderBuilder: buildSlider,
              value: _b,
              label: 'Blue',
              startColor: Colors.black,
              endColor: Color.fromRGBO(0, 0, 255, 1.0),
              thumbColor: Color.fromRGBO(0, 0, _color.blue, 1),
              labelStyle: TextStyle(color: Colors.blue.shade600, fontSize: 12),
              orientation: widget.orientation,
              maxValue: 255.0,
              onChange: (value) => setState(() => b = value)),
        ],
      ),
    );
  }
}

class HSLPicker extends StatefulWidget {
  HSLPicker(
      {@required this.color,
      this.onColor,
      this.dynamicBackground: false,
      this.orientation});

  final ColorCallback onColor;
  final Color color;
  final bool dynamicBackground;
  final Orientation orientation;

  @override
  HSLPickerState createState() => new HSLPickerState(color);
}

class HSLPickerState extends State<HSLPicker> {
  HSLColor _color;

  set color(HSLColor color) {
    _color = color;
    widget.onColor(_color.toColor());
  }

  double _h = 0.0;

  set h(double r) {
    _h = r;
    updateColor();
  }

  double _s = 0.0;

  set s(double g) {
    _s = g;
    updateColor();
  }

  double _l = 0.0;

  set l(double b) {
    _l = b;
    updateColor();
  }

  HSLPickerState(Color c) {
    this._color = HSLColor.fromColor(c);
  }

  void updateColor() => color = HSLColor.fromAHSL(1, _h, _s, _l);

  @override
  void didUpdateWidget(HSLPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color)
      _color = HSLColor.fromColor(widget.color);
  }

  @override
  Widget build(BuildContext context) {
    _h = _color.hue;
    _s = _color.saturation;
    _l = _color.lightness;

    final rgb = HSLColor.fromAHSL(1, _h, _s, 0.95).toColor();

    final bgColor =
        widget.dynamicBackground ? rgb.withOpacity(1) : Colors.white;
    return Container(
      color: bgColor,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          HSLSliderRow(
            sliderKey: Key('sldH2'),
            sliderBuilder: buildSlider,
            value: _h,
            label: 'Hue',
            orientation: widget.orientation,
            maxValue: 359,
            onChange: (value) => setState(() => h = value),
            colors: getHueGradientColors(),
            thumbColor: _color.toColor(),
          ),
          HSLSliderRow(
            sliderKey: Key('sldS'),
            sliderBuilder: buildSlider,
            value: _s,
            label: 'Saturation : ${_s.toStringAsFixed(2)}',
            orientation: widget.orientation,
            maxValue: 1.0,
            onChange: (value) => setState(() => s = value),
            startColor: getMinSaturation(widget.color),
            endColor: getMaxSaturation(widget.color),
            thumbColor: _color.toColor(),
          ),
          HSLSliderRow(
            sliderKey: Key('sldL'),
            sliderBuilder: buildSlider,
            value: _l,
            label: 'Lightness : ${_l.toStringAsFixed(2)}',
            orientation: widget.orientation,
            maxValue: 1.0,
            onChange: (value) => setState(() => l = value),
            colors: [Colors.black, _color.toColor(), Colors.white],
            thumbColor: _color.toColor(),
          ),
        ],
      ),
    );
  }
}

class HueGradientPainter extends CustomPainter {
  final ValueChanged<double> onHueSelection;

  final double value;

  HueGradientPainter({this.value, this.onHueSelection});

  Size size;

  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    final Gradient gradient = new LinearGradient(
      colors: getHueGradientColors(),
    );
    Rect gradientRect =
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    final gradientPaint = Paint()..shader = gradient.createShader(gradientRect);

    final valueX = value / 360 * size.width;
    Rect cursorRect =
        Rect.fromPoints(Offset(valueX, 0.0), Offset(valueX + 2, size.height));

    canvas.drawRect(gradientRect, gradientPaint);
    final cursorPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(cursorRect, cursorPaint);
  }

  @override
  bool shouldRepaint(HueGradientPainter oldDelegate) =>
      oldDelegate.value != value;

  @override
  bool hitTest(Offset position) {
    final hueValue = position.dx / size.width * 360;
    onHueSelection(hueValue);
    return true;
  }
}

class HSLSliderRow extends GradientSliderRow {
  HSLSliderRow(
      {Key sliderKey,
      @required double value,
      @required ValueChanged<double> onChange,
      @required ColorSliderBuilder sliderBuilder,
      @required Color thumbColor,
      @required Orientation orientation,
      Color startColor,
      Color endColor,
      List<Color> colors,
      String label,
      TextStyle labelStyle,
      double minValue: 0.0,
      double maxValue: 1.0,
      double width: 160.0,
      Key key})
      : super(
            key: key,
            value: value,
            sliderKey: sliderKey,
            onChange: onChange,
            sliderBuilder: sliderBuilder,
            startColor: startColor,
            endColor: endColor,
            colors: colors,
            thumbColor: thumbColor,
            label: label,
            labelStyle: labelStyle,
            minValue: minValue,
            maxValue: maxValue,
            width: width,
            orientation: orientation);

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          Text(
            '$label',
            style: labelStyle ?? Theme.of(context).textTheme.body1,
            overflow: TextOverflow.ellipsis,
          ),
          sliderBuilder(
              startColor: startColor ?? colors[0],
              endColor: endColor ?? colors[1],
              colors: colors,
              thumbColor: thumbColor,
              sliderKey: sliderKey,
              maxValue: maxValue,
              onChange: onChange,
              value: min(max(minValue, value), maxValue)),
        ]);
  }
}

class RGBSliderRow extends GradientSliderRow<RGB> {
  RGBSliderRow(
      {Key sliderKey,
      @required double value,
      @required ValueChanged<double> onChange,
      @required ColorSliderBuilder sliderBuilder,
      @required Color startColor,
      @required Color endColor,
      @required Color thumbColor,
      @required Orientation orientation,
      String label,
      TextStyle labelStyle,
      double minValue: 0.0,
      double maxValue: 1.0,
      double width: 160.0,
      Key key})
      : super(
          key: key,
          value: value,
          sliderKey: sliderKey,
          onChange: onChange,
          sliderBuilder: sliderBuilder,
          startColor: startColor,
          endColor: endColor,
          thumbColor: thumbColor,
          label: label,
          labelStyle: labelStyle,
          minValue: minValue,
          maxValue: maxValue,
          width: width,
          orientation: orientation,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = [
      Text(
        '$label : ${value.round()}',
        style: labelStyle ?? Theme.of(context).textTheme.body1,
        overflow: TextOverflow.ellipsis,
      ),
      sliderBuilder(
          startColor: startColor,
          endColor: endColor,
          thumbColor: thumbColor,
          sliderKey: sliderKey,
          maxValue: maxValue,
          onChange: onChange,
          value: min(max(minValue, value), maxValue)),
    ];
    if (orientation == Orientation.landscape)
      elements = elements.reversed.toList();
    return Flex(
      direction:
          orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
      children: elements,
    );
  }
}

abstract class GradientSliderRow<T> extends StatelessWidget {
  GradientSliderRow(
      {this.sliderKey,
      @required this.value,
      @required this.onChange,
      @required this.sliderBuilder,
      @required this.startColor,
      @required this.endColor,
      @required this.thumbColor,
      this.colors,
      this.label,
      this.labelStyle,
      this.minValue: 0.0,
      this.maxValue: 1.0,
      this.width: 160.0,
      this.orientation: Orientation.portrait,
      Key key})
      : super(key: key);

  final double value;

  final ValueChanged<double> onChange;
  final String label;

  final TextStyle labelStyle;

  final Orientation orientation;

  final double width;
  final double minValue;

  final double maxValue;
  final Color startColor;
  final Color endColor;
  final List<Color> colors;

  final Color thumbColor;

  final Key sliderKey;

  final ColorSliderBuilder sliderBuilder;
}
