import 'package:flutter/material.dart';
import 'package:flutterial/show_custom_menu.dart';

typedef void ColorChanged(Color c);

const kSwatchSize = 48.0;

const kDarkTextStyle = const TextStyle(color: Colors.black, fontSize: 11.0);
const kLightTextStyle = const TextStyle(color: Colors.white, fontSize: 11.0);

const materialColorsNames = const <String>[
  "Red",
  "Pink",
  "purple",
  "deepPurple",
  "indigo",
  "blue",
  "lightBlue",
  "cyan",
  "teal",
  "green",
  "lightGreen",
  "lime",
  "yellow",
  "amber",
  "orange",
  "deepOrange",
  "brown",
  "blueGrey",
  "White",
  "Black",
  "Grey"
];

getMaterialSwatches(ColorChanged onSelection) {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([
    Colors.white,
    Colors.black,
    Colors.grey,
  ]);
  return colors
    ..map((c) {
      return new InkWell(
        child: new Padding(
            padding: new EdgeInsets.all(4.0),
            child: new Container(
              width: kSwatchSize,
              height: kSwatchSize,
              color: c,
            )),
        onTap: () => onSelection(c),
      );
    }).toList();
}

List<PopupMenuItem<Color>> getColorMenuItems() {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([Colors.white, Colors.black, Colors.grey, ]);
  return colors.map((c) {
    return new PopupMenuItem<Color>(
      value: c,
      child: new Container(
        width: kSwatchSize,
        height: kSwatchSize,
        color: c,
      ),
    );
  }).toList();
}

List<PopupGridMenuItem<Color>> getColorMenuTileItems() {
  return colors_names().map((c) {
    return new PopupGridMenuItem<Color>(
      value: c.color,
      child: new GridTile(
          footer: new Padding(
              padding: new EdgeInsets.all(4.0),
              child: new Text(c.name,
                  style: isDark(c.color) ? kDarkTextStyle : kLightTextStyle)),
          child: new Container(
            width: kSwatchSize,
            height: kSwatchSize,
            color: c.color,
          )),
    );
  }).toList();
}

class NamedColor {
  final Color color;
  final String name;

  NamedColor(this.color, this.name);
}

List<NamedColor> colors_names() {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([Colors.white, Colors.black, Colors.grey, ]);

  return colors.fold([], (cumul, current) {
    cumul.add(new NamedColor(current, materialColorsNames[cumul.length]));
    return cumul;
  });
}

bool isDark(Color c) => (c.red + c.green + c.blue) / 3 >= 146;

void openColorMenu(BuildContext context, {ColorChanged onSelection}) {
  final RenderBox renderBox = context.findRenderObject();
  final Offset topLeft = renderBox?.localToGlobal(Offset.zero);

  //display full color display
  showCustomMenu<Color>(
      context: context,
      elevation: 2.0,
      items: getColorMenuTileItems(),
      position: new RelativeRect.fromLTRB(
        topLeft.dx,
        topLeft.dy,
        0.0,
        0.0,
      )).then<Null>((Color newValue) {
    if (newValue == null) return null;
    if (onSelection != null) onSelection(newValue);
  });
  ;
}

class ColorSelector extends StatelessWidget {
  final String label;
  final Color value;
  final ColorChanged onSelection;

  ColorSelector({this.label, this.value, this.onSelection});

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject();
    final Offset topLeft = renderBox?.localToGlobal(Offset.zero);
    return new Padding( padding: new EdgeInsets.all(8.0), child: new Container(
       color: Colors.grey.shade100,
       child: new Padding(
           padding: new EdgeInsets.all(8.0),
           child: new Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 new ConstrainedBox(
                     child: new Text(
                       label,
                       maxLines: 2,
                       style: Theme.of(context).textTheme.subhead,
                     ),
                     constraints: new BoxConstraints.tightFor(width: 160.0)),
                 new InkWell(
                   onTap: () => openColorMenu(context, onSelection: onSelection),
                   child: new ColorSwatch(value),
                 ),
               ])),
     ) );
  }
}

class ColorSwatch extends StatelessWidget {
  final Color color;
  String label;

  ColorSwatch(this.color) {
    final namedPeer = colors_names().where((c) => c.color.value == color.value);
    label = namedPeer.length > 0
        ? namedPeer.first.name
        : "#${color.value.toRadixString(16)}";
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: [
      new Padding(
          padding: new EdgeInsets.only(right: 8.0),
          child: new Text(
            label,
            style: kDarkTextStyle,
          )),
      new Container(
        width: kSwatchSize,
        height: kSwatchSize,
        decoration: new BoxDecoration(color: color, boxShadow: [
          new BoxShadow(blurRadius: 2.5, color: Colors.grey.shade400)
        ]),
      ),
    ]);
  }
}

class BrightnessSelector extends StatelessWidget {
  final String label;
  final bool isDark;
  final ValueChanged<bool> onChange;

  BrightnessSelector({this.label, this.isDark, this.onChange});

  @override
  Widget build(BuildContext context) => new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text("$label : Light"),
          new Switch(value: isDark, onChanged: onChange),
          new Text('Dark')
        ],
      ));
}
