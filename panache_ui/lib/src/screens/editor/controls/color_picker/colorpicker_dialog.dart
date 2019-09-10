import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import './color_pickers.dart';

enum ColorMode { rgb, hsl }

void showColorPicker(
    {BuildContext context,
    Color currentColor,
    ValueChanged<Color> onColor}) async {
  final selectedColor = await showDialog<Color>(
    context: context,
    builder: (context) => ColorPickerDialog(currentColor),
  );
  if (selectedColor == null) return;

  onColor(selectedColor);
}

///
/// usage
///
class ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  ColorPickerDialog(this.currentColor);

  @override
  _ColorPickerDialogState createState() => new _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog>
    with TickerProviderStateMixin {
  Color currentColor/*= Colors.red*/;

  TabController tabController;

  int currentTabIndex = 0;

  @override
  void initState() {
    currentColor = widget.currentColor ?? Colors.blue;
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(
        () => setState(() => currentTabIndex = tabController.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    final buttonStyle = Theme.of(context).textTheme.button;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
      content: mQ.orientation == Orientation.portrait
          ? _buildPortraitPicker()
          : _buildLandscapePicker(),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: buttonStyle.copyWith(color: Colors.grey),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton.icon(
          label: Text('SELECT'),
          icon: Icon(Icons.check_circle, color: currentColor),
          onPressed: () => Navigator.of(context).pop(currentColor),
        ),
      ],
    );
  }

  _buildRGBPicker(Orientation orientation) => RGBPicker(
        onColor: (Color color) => setState(() => currentColor = color),
        color: currentColor,
        orientation: orientation,
      );

  _buildHSLPicker(Orientation orientation) => HSLPicker(
        onColor: (Color color) => setState(() => currentColor = color),
        color: currentColor,
        orientation: orientation,
      );

  _buildMaterialPicker() => MaterialPicker(
        onColor: (Color color) => setState(() => currentColor = color),
        color: currentColor,
      );

  _getPicker(int index, Orientation orientation) {
    switch (index) {
      case 0:
        return _buildRGBPicker(orientation);
      case 1:
        return _buildHSLPicker(orientation);
      case 2:
        return _buildMaterialPicker();
      default:
        return _buildRGBPicker(orientation);
    }
  }

  Widget _buildPortraitPicker() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(
          tabs: <Widget>[
            Tab(text: 'RGB'),
            Tab(text: 'HSL'),
            Tab(text: 'Material'),
          ],
          controller: tabController,
          labelColor: Colors.blueGrey,
          isScrollable: true,
        ),
        ColorThumbPreview(
          color: currentColor,
          constraints: BoxConstraints.expand(height: 60),
        ),
        SizedBox(
          width: 100,
          child: ColorTextField(
              color: currentColor, onColorChanged: _updateColorValue),
        ),
        _getPicker(currentTabIndex, Orientation.portrait),
      ],
    );
  }

  Widget _buildLandscapePicker() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(
          indicatorPadding: EdgeInsets.all(2),
          tabs: <Widget>[
            Tab(text: 'RGB'),
            Tab(text: 'HSL'),
            Tab(text: 'Material'),
          ],
          controller: tabController,
          labelColor: Colors.blueGrey,
          isScrollable: true,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ColorThumbPreview(
                    color: currentColor,
                    constraints: BoxConstraints.expand(width: 100, height: 60),
                  ),
/*
                  SizedBox(
                    width: 100,
                    child: ColorTextField(
                      color: currentColor,
                      onColorChanged: (color) =>
                          setState(() => currentColor = color),
                    ),
                  )
*/
                ],
              ),
            ),
            _getPicker(currentTabIndex, Orientation.landscape),
          ],
        )
      ],
    );
  }

  void _updateColorValue(Color color) {
    setState(() => currentColor = color);
  }
}

class MaterialPicker extends StatelessWidget {
  final ValueChanged<Color> onColor;
  final Color color;

  const MaterialPicker({Key key, this.onColor, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = List.from(Colors.primaries);
    colors.addAll([white, black, grey]);
    final swatches = colors
        .map<Widget>((c) => InkWell(
              child: Container(width: 42.0, height: 42.0, color: c),
              onTap: () => onColor(c),
            ))
        .toList();

    return Flexible(
      child: SizedBox(
        child: SingleChildScrollView(
          primary: true,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            runSpacing: 4.0,
            spacing: 4.0,
            children: swatches,
          ),
        ),
      ),
    );
  }
}

class ColorThumbPreview extends StatelessWidget {
  final Color color;
  final BoxConstraints constraints;

  const ColorThumbPreview({Key key, this.color, this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: constraints,
        /*
        height: 60,
        width: 100,*/
        color: color,
        child: Center(
          child: Text(
            colorToHex32(color),
            style: TextStyle(color: getContrastColor(color)),
          ),
        ),
      ),
    );
  }
}

class ColorTextField extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const ColorTextField({Key key, this.color, this.onColorChanged})
      : super(key: key);

  @override
  _ColorTextFieldState createState() => _ColorTextFieldState();
}

class _ColorTextFieldState extends State<ColorTextField> {
  TextEditingController fieldController;

  bool get valid =>
      RegExp(r'[0-9A-Fa-f]{8}').hasMatch('${fieldController.text}');

  @override
  void initState() {
    fieldController = TextEditingController(
      text: colorToHex32(widget.color).replaceFirst('#', ''),
    );
    fieldController.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    fieldController.removeListener(_onChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(ColorTextField oldWidget) {
    if (oldWidget.color != widget.color)
      fieldController.text = colorToHex32(widget.color).replaceFirst('#', '');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: 8,
        maxLines: 1,
        textAlign: TextAlign.center,
        controller: fieldController,
        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12),
        decoration: InputDecoration(
            prefixText: '#',
            counterText: '',
            filled: true,
            contentPadding: const EdgeInsets.all(4),
            border: OutlineInputBorder()),
      ),
    );
  }

  void _onChanged() {
    print('fieldListen... ${fieldController.text} $valid');
    if (valid) {
      final color = Color(int.parse('${fieldController.text}', radix: 16));
      print('_ColorPreviewState.initState... $color');
      widget.onColorChanged(color);
    }
  }
}
