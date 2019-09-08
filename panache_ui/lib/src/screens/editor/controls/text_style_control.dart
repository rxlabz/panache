import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../editor_utils.dart';
import 'color_selector.dart';
import 'control_container.dart';
import 'font_size_slider.dart';
import 'slider_control.dart';
import 'switcher_control.dart';

class TextStyleControl extends StatefulWidget {
  final String label;

  final ValueChanged<Color> onColorChanged;

  final ValueChanged<double> onSizeChanged;

  final ValueChanged<double> onLetterSpacingChanged;

  final ValueChanged<double> onWordSpacingChanged;

  final ValueChanged<double> onLineHeightChanged;

  // TODO select from all FontWeight values
  final ValueChanged<bool> onWeightChanged;

  final ValueChanged<bool> onFontStyleChanged;

  final ValueChanged<TextDecoration> onDecorationChanged;

  final ValueChanged<TextDecorationStyle> onDecorationStyleChanged;

  final ValueChanged<Color> onDecorationColorChanged;

  final Color color;

  final Color backgroundColor;

  final double fontSize;

  final double maxFontSize;

  final double lineHeight;

  final bool isBold;

  final bool isItalic;

  final double letterSpacing;

  final double wordSpacing;

  final TextDecoration decoration;

  final TextDecorationStyle decorationStyle;

  final Color decorationColor;

  final TextStyle style;

  final bool expanded;

  final bool useMobileLayout;

  TextStyleControl(
    this.label, {
    Key key,
    @required this.style,
    @required this.onColorChanged,
    @required this.onSizeChanged,
    @required this.onWeightChanged,
    @required this.onFontStyleChanged,
    @required this.onLetterSpacingChanged,
    @required this.onWordSpacingChanged,
    @required this.onLineHeightChanged,
    @required this.onDecorationChanged,
    @required this.onDecorationStyleChanged,
    @required this.onDecorationColorChanged,
    this.useMobileLayout: false,
    this.expanded: false,
    this.maxFontSize: 112.0,
  })  : this.color = style?.color ?? Colors.black,
        this.backgroundColor = style?.color ?? Colors.transparent,
        this.letterSpacing = style?.letterSpacing ?? 1.0,
        this.lineHeight = style?.height ?? 1.0,
        this.wordSpacing = style?.wordSpacing ?? 1.0,
        this.fontSize = style?.fontSize ?? 12.0,
        this.decoration = style?.decoration ?? TextDecoration.none,
        this.decorationStyle =
            style?.decorationStyle ?? TextDecorationStyle.solid,
        this.decorationColor = style?.decorationColor ?? style?.color,
        this.isBold = style?.fontWeight == FontWeight.bold,
        this.isItalic = style?.fontStyle == FontStyle.italic,
        super(key: key);

  @override
  TextStyleControlState createState() {
    return new TextStyleControlState();
  }
}

class TextStyleControlState extends State<TextStyleControl> {
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    //expanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final controls = [
      getFieldsRow([
        ColorSelector(
          'Color',
          widget.color,
          widget.onColorChanged,
          padding: 0,
        ),
        if (!kIsWeb)
          FontSizeSelector(
            widget.fontSize,
            widget.onSizeChanged,
            min: 8.0,
            max: widget.maxFontSize,
            vertical: true,
          )
      ]),
      getFieldsRow([
        SwitcherControl(
            direction: widget.useMobileLayout ? Axis.vertical : Axis.horizontal,
            checked: widget.isBold,
            checkedLabel: 'Bold',
            onChange: widget.onWeightChanged),
        SwitcherControl(
            direction: widget.useMobileLayout ? Axis.vertical : Axis.horizontal,
            checked: widget.isItalic,
            checkedLabel: 'Italic',
            onChange: widget.onFontStyleChanged),
      ] /*, direction: Axis.vertical*/),
      SliderPropertyControl(
        widget.lineHeight,
        widget.onLineHeightChanged,
        label: 'Line height',
        min: 1,
        max: 3,
        showDivisions: false,
        vertical: true,
      ),
      getFieldsRow([
        SliderPropertyControl(
          widget.letterSpacing,
          widget.onLetterSpacingChanged,
          label: 'Letter spacing',
          min: -5,
          max: 5,
          showDivisions: false,
          vertical: true,
        ),
        SliderPropertyControl(
          widget.wordSpacing,
          widget.onWordSpacingChanged,
          label: 'Word spacing',
          min: -5,
          max: 5,
          showDivisions: false,
          vertical: true,
        ),
      ]),
      getFieldsRow([
        PanacheDropdown<SelectionItem<TextDecoration>>(
          label: 'Decoration',
          selection: widget.style.decoration != null
              ? _textDecorations
                  .firstWhere((item) => item.value == widget.style.decoration)
              : _textDecorations.first,
          collection: _textDecorations,
          onValueChanged: (decoration) =>
              widget.onDecorationChanged(decoration.value),
        ),
        PanacheDropdown<SelectionItem<TextDecorationStyle>>(
          label: 'Decoration style',
          selection: widget.style.decorationStyle != null
              ? _textDecorationStyles.firstWhere(
                  (item) => item.value == widget.style.decorationStyle)
              : _textDecorationStyles.first,
          collection: _textDecorationStyles,
          onValueChanged: (decorationStyle) =>
              widget.onDecorationStyleChanged(decorationStyle.value),
        ),
      ]),
      ColorSelector(
          'Decoration color',
          widget.style.decorationColor ?? Colors.black,
          widget.onDecorationColorChanged)
    ];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.label,
                style: textTheme.title,
                textAlign: TextAlign.left,
              ),
              IconButton(
                icon: Icon(
                    expanded ? Icons.indeterminate_check_box : Icons.add_box),
                onPressed: toggle,
                color: Colors.blueGrey.shade600,
              )
            ],
          ),
        ]
          ..addAll(expanded ? controls : [])
          ..add(Divider()),
      ),
    );
  }

  void toggle() {
    setState(() {
      expanded = !expanded;
    });
  }
}

const _textDecorationStyles = [
  SelectionItem<TextDecorationStyle>('Solid', TextDecorationStyle.solid),
  SelectionItem<TextDecorationStyle>('Dashed', TextDecorationStyle.dashed),
  SelectionItem<TextDecorationStyle>('Dotted', TextDecorationStyle.dotted),
  SelectionItem<TextDecorationStyle>('Wavy', TextDecorationStyle.wavy),
  SelectionItem<TextDecorationStyle>('Double', TextDecorationStyle.double),
];

const _textDecorations = [
  SelectionItem<TextDecoration>('None', TextDecoration.none),
  SelectionItem<TextDecoration>('underline', TextDecoration.underline),
  SelectionItem<TextDecoration>('Linethrough', TextDecoration.lineThrough),
  SelectionItem<TextDecoration>('Overline', TextDecoration.overline),
];

class SelectionItem<T> {
  final String label;
  final T value;

  const SelectionItem(this.label, this.value);
}

class PanacheDropdown<D extends SelectionItem> extends StatelessWidget {
  final List<D> collection;

  final D selection;

  final String label;
  final ValueChanged<D> onValueChanged;

  const PanacheDropdown(
      {Key key,
      @required this.collection,
      @required this.onValueChanged,
      @required this.selection,
      this.label: ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ControlContainerBorder(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
          child: Text(
            label,
            style: textTheme.subtitle,
          ),
        ),
        DropdownButton(
            items: buildItems(
              style: textTheme.body2,
            ),
            isDense: true,
            value: selection,
            hint: Text(
              label,
              style: textTheme.body2,
            ),
            onChanged: onValueChanged),
      ],
    ));
  }

  List<DropdownMenuItem<D>> buildItems({TextStyle style}) => collection
      .map<DropdownMenuItem<D>>((item) => toDropdownMenuItem(item, style))
      .toList(growable: false);

  DropdownMenuItem<D> toDropdownMenuItem(D item, TextStyle style) =>
      DropdownMenuItem(
        child: Text(item.label, style: style),
        value: item,
      );
}
