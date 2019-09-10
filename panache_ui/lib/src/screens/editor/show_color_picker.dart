import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'color_stream.dart';

const Duration _kMenuDuration = const Duration(milliseconds: 100);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuItemHeight = 48.0;
const double _kMenuScreenPadding = 0.0;

/// push a route to Navigator
/// the position is expected
Future<T> showColorPicker<T>(
    {@required BuildContext context,
    RelativeRect position,
    @required List<PopupMenuEntry<T>> items,
    T initialValue,
    double elevation: 8.0,
    ColorStream colorStream}) {
  assert(context != null);
  assert(items != null && items.isNotEmpty);
  return Navigator.push(
    context,
    _ColorPickerPopup<T>(
      position: position,
      items: items,
      colorStream: colorStream,
      initialValue: initialValue,
      elevation: elevation,
      theme: Theme.of(context, shadowThemeOnly: true),
    ),
  );
}

/// popup display route
/// position
/// items
/// initialValue
/// elevation + theme
class _ColorPickerPopup<T> extends PopupRoute<T> {
  _ColorPickerPopup(
      {this.position,
      this.items,
      this.initialValue,
      this.elevation,
      this.theme,
      this.colorStream});

  final RelativeRect position;
  final List<PopupMenuEntry<T>> items;
  final dynamic initialValue;
  final double elevation;
  final ThemeData theme;
  final ColorStream colorStream;

  @override
  Animation<double> createAnimation() => CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd));

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    /*double selectedItemOffset;
    if (initialValue != null) {
      selectedItemOffset = 0.0;
    }*/

    Widget menu = _PopupMenu<T>(route: this, colorStream: colorStream);
    if (theme != null) menu = Theme(data: theme, child: menu);

    return CustomSingleChildLayout(
        delegate: _PopupMenuRouteGridLayout(position /*, selectedItemOffset*/),
        child: menu);
  }

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => "TODO: barrierLabel";
}

/// position the popup
class _PopupMenuRouteGridLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteGridLayout(this.position /*, this.selectedItemOffset*/);

  final RelativeRect position;
  //final double selectedItemOffset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  // Put the child wherever position specifies, so long as it will fit within the
  // specified parent size padded (inset) by 8. If necessary, adjust the child's
  // position so that it fits.
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = position?.left ??
        (position?.right != null
            ? size.width - (position.right + childSize.width)
            : _kMenuScreenPadding);
    double y = position?.top ??
        (position?.bottom != null
            ? size.height - (position.bottom - childSize.height)
            : _kMenuScreenPadding);

    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - 2 * _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - 2 * _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    final pos = Offset(x, y);
    return pos;
  }

  @override
  bool shouldRelayout(_PopupMenuRouteGridLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

class _PopupMenu<T> extends StatefulWidget {
  const _PopupMenu({Key key, this.route, this.colorStream}) : super(key: key);
  final _ColorPickerPopup<T> route;
  final ColorStream colorStream;

  @override
  _PopupMenuState createState() {
    return new _PopupMenuState();
  }
}

class _PopupMenuState extends State<_PopupMenu> {
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < widget.route.items.length; ++i) {
      Widget item = widget.route.items[i];
      children.add(item);
    }

    final Widget colorsGrid = SizedBox(
      width: 480.0,
      height: 320.0,
      child: GridView(
        children: children,
        padding: EdgeInsets.zero,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
      ),
    );

    final opacityBox = SizedBox(
        height: 128,
        width: 480,
        child: StreamBuilder(
            stream: widget.colorStream.color$,
            initialData: Colors.blue,
            builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
              Color currentColor = snapshot.data;
              _opacity = currentColor.opacity;
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 64,
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Text('Opacity'),
                      Slider(
                          divisions: 100,
                          value: _opacity,
                          label: '$_opacity',
                          onChanged: _onOpacityUpdate),
                      Expanded(child: SizedBox()),
                    ]),
                  ),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(
                      width: 64,
                      height: 64,
                      color: currentColor,
                    ),
                    Text(colorToHex32(currentColor)),
                    Expanded(child: SizedBox()),
                    IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      onPressed: () => Navigator.pop(context, snapshot.data),
                    )
                  ]),
                ],
              );
            }));

    return Material(
      type: MaterialType.card,
      elevation: widget.route.elevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[colorsGrid, opacityBox],
      ),
    );
  }

  void _onOpacityUpdate(double opacity) {
    widget.colorStream.setOpacity(opacity);
    setState(() {
      _opacity = opacity;
    });
  }
}

class PopupGridMenuItem<T extends Color> extends PopupMenuEntry<T> {
  /// Creates an item for a popup menu.
  ///
  /// By default, the item is enabled.
  const PopupGridMenuItem({
    Key key,
    this.value,
    this.enabled: true,
    @required this.onSelection,
    @required this.selected,
    @required this.child,
  }) : super(key: key);

  final T value;
  final bool enabled;
  final bool selected;

  /// The widget below this widget in the tree.
  final Widget child;

  final ValueChanged<T> onSelection;

  @override
  double get height => _kMenuItemHeight;

  @override
  _PopupGridMenuItemState<PopupGridMenuItem<T>> createState() =>
      _PopupGridMenuItemState<PopupGridMenuItem<T>>();

  @override
  bool represents(T value) {
    // TODO: implement represents for real (this implementation is just to shut the compiler up)
    return true;
  }
}

class _PopupGridMenuItemState<T extends PopupGridMenuItem<Color>>
    extends State<T> {
  // Override this to put something else in the menu entry.
  Widget buildChild() => widget.child;

  void onTap() {
    //Navigator.pop(context, widget.value);
    print('_PopupGridMenuItemState.onTap... ${widget.value}');
    widget.onSelection(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.subhead;
    if (!widget.enabled) style = style.copyWith(color: theme.disabledColor);

    return InkWell(
      onTap: widget.enabled ? onTap : null,
      child: MergeSemantics(
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: buildChild(),
        ),
      ),
    );
  }
}
