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

    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
      content: mQ.orientation == Orientation.portrait
          ? _buildPortraitPicker()
          : _buildLandscapePicker(),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(
          width: 50,
        ),
        FlatButton.icon(
          label: Text('Select'),
          icon: Icon(
            Icons.check_circle,
            color: currentColor /*Colors.green*/,
          ),
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
        Container(
          height: 100.0,
          color: currentColor,
          child: Center(
            child: Text(
              "${colorToHex32(currentColor)}",
              style: TextStyle(color: getContrastColor(currentColor)),
            ),
          ),
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
              child: Container(
                height: 100.0,
                width: 100.0,
                color: currentColor,
                child: Center(
                    child: Text(
                  "${colorToHex32(currentColor)}",
                  style: TextStyle(color: getContrastColor(currentColor)),
                )),
              ),
            ),
            _getPicker(currentTabIndex, Orientation.landscape),
          ],
        )
      ],
    );
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
      child: SingleChildScrollView(
        primary: true,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          runSpacing: 4.0,
          spacing: 4.0,
          children: swatches,
        ),
      ),
    );
  }
}
