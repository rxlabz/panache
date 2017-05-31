import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const kSwatchSize = 48.0;

void main() {
  runApp(new MaterialApp(
      home: new Scaffold(
    body: new Stack(children: [
      new Positioned(
        left: 100.0,
        top: 100.0,
        child: new Column(children: [new SizedBox(
            width: 600.0,
            height: 400.0,
            child: new GridView.count(
              crossAxisCount: 8,
              children: getColorMenuTileItems(),
            )), new Row(children: <Widget>[],)]),
      ),
    ]),
  )));
}

List<Widget> getColorMenuTileItems() {
  final List<Color> colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([Colors.black, Colors.grey, Colors.white]);
  colors.addAll(Colors.accents.map((a)=>a.shade200));
  return colors.map((c) {
    return new GridTile(
      footer: new Text("Color"),
      child: new InkWell(
        child: /*new FittedBox(
            fit: BoxFit.fitHeight,
            child:*/ new Container(
              width: kSwatchSize,
              height: kSwatchSize,
              color: c,
            )/*)*/,
        onTap: () => print('tap => c ${c}'),
      ),
    );
  }).toList();
}
/*List<PopupMenuItem<Color>> _getColorMenuTileItems() {
  final colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([Colors.black, Colors.grey, Colors.white]);
  return colors.map((c) {
    return new PopupMenuItem<Color>(
      value: c,
      child: new GridTile(
          child: new FittedBox(fit: BoxFit.contain,child: new Container(
         */ /*width: kSwatchSize,
         height: kSwatchSize,*/ /*
         color: c,
       ) )),
    );
  }).toList();
}*/
