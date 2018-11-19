import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const kSwatchSize = 48.0;

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 100.0,
              top: 100.0,
              child: Column(children: [
                SizedBox(
                  width: 600.0,
                  height: 400.0,
                  child: GridView.count(
                    crossAxisCount: 8,
                    children: getColorMenuTileItems(),
                  ),
                ),
                Row(
                  children: [],
                )
              ]),
            ),
          ],
        ),
      ),
    ),
  );
}

List<Widget> getColorMenuTileItems() {
  final List<Color> colors = Colors.primaries.map((c) => c).toList();
  colors.addAll([Colors.black, Colors.grey, Colors.white]);
  colors.addAll(Colors.accents.map((a) => a.shade200));
  return colors
      .map(
        (c) => GridTile(
              footer: Text("Color"),
              child: InkWell(
                child: Container(
                  width: kSwatchSize,
                  height: kSwatchSize,
                  color: c,
                ),
                onTap: () => print('tap => c $c'),
              ),
            ),
      )
      .toList();
}
