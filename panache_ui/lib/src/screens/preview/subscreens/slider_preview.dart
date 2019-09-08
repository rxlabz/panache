import 'package:flutter/material.dart';

class SliderPreview extends StatelessWidget {
  final ThemeData theme;

  const SliderPreview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FakeSlider(divisions: 10),
          _FakeSlider(
            divisions: null,
            labelPrefix: '',
          ),
          _FakeSlider(disabled: true),
        ],
      ),
    );
  }
}

class _FakeSlider extends StatefulWidget {
  final bool disabled;
  final int divisions;
  final int id;
  final String labelPrefix;

  _FakeSlider(
      {this.id,
      this.disabled: false,
      this.divisions: 10,
      this.labelPrefix: 'Value'});

  @override
  _FakeSliderState createState() => _FakeSliderState();
}

class _FakeSliderState extends State<_FakeSlider> {
  double value = 0.5;

  _FakeSliderState();

  @override
  Widget build(BuildContext context) {
    print('_FakeSliderState.build... ');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slider(
          key: Key(widget.id.toString()),
          divisions: widget.divisions,
          value: value,
          /*label: '${widget.labelPrefix}' */ /* ${value.toStringAsFixed(2)} */ /*,*/
          onChanged: widget.disabled
              ? null
              : (newValue) => setState(() => value = newValue)),
    );
  }
}
