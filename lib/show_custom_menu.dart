import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Duration _kMenuDuration = const Duration(milliseconds: 300);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
//const double _kMenuHorizontalPadding = 40.0;
const double _kMenuItemHeight = 48.0;
const double _kMenuItemWidth = 48.0;
const double _kMenuMaxWidth = 12.0 * _kMenuWidthStep;
const double _kMenuMinWidth = 2.0 * _kMenuWidthStep;
const double _kMenuVerticalPadding = 50.0;
const double _kMenuWidthStep = 52.0;
const double _kMenuScreenPadding = 12.0;

/// fait pousser une route au Navigator
/// la position est attendue
Future<T> showGridMenu<T>(
    {@required BuildContext context,
    RelativeRect position,
    @required List<PopupMenuEntry<T>> items,
    T initialValue,
    double elevation: 8.0}) {
  assert(context != null);
  assert(items != null && items.isNotEmpty);
  return Navigator.push(
      context,
      new _PopupMenuRoute<T>(
        position: position,
        items: items,
        initialValue: initialValue,
        elevation: elevation,
        theme: Theme.of(context, shadowThemeOnly: true),
      ));
}

/// route d'affichage de la popup
/// position
/// items
/// initialValue
/// elevation + theme
class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute(
      {this.position,
      this.items,
      this.initialValue,
      this.elevation,
      this.theme});

  final RelativeRect position;
  final List<PopupMenuEntry<T>> items;
  final dynamic initialValue;
  final double elevation;
  final ThemeData theme;

  @override
  Animation<double> createAnimation() {
    return new CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd));
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    double selectedItemOffset;
    if (initialValue != null) {
      selectedItemOffset = 0.0;
    }

    Widget menu = new _PopupMenu<T>(route: this);
    if (theme != null) menu = new Theme(data: theme, child: menu);

    return new CustomSingleChildLayout(
        delegate: new _PopupMenuRouteGridLayout(position, selectedItemOffset),
        child: menu);
  }
}

/// positionne la popup
class _PopupMenuRouteGridLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteGridLayout(this.position, this.selectedItemOffset);

  final RelativeRect position;
  final double selectedItemOffset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  // Put the child wherever position specifies, so long as it will fit within the
  // specified parent size padded (inset) by 8. If necessary, adjust the child's
  // position so that it fits.
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    print(
        '_PopupMenuRouteGridLayout.getPositionForChild  size ${size} / childSize ${childSize}');
    double x = position?.left ??
        (position?.right != null
            ? size.width - (position.right + childSize.width)
            : _kMenuScreenPadding);
    double y = position?.top ??
        (position?.bottom != null
            ? size.height - (position.bottom - childSize.height)
            : _kMenuScreenPadding);

    /*if (selectedItemOffset != null)
      y -= selectedItemOffset + _kMenuVerticalPadding + _kMenuItemHeight / 2.0;*/

    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - 2 * _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - 2 * _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    final pos = new Offset(x, y);
    print('_PopupMenuRouteGridLayout.getPositionForChild => pos ${pos}');
    return pos;
  }

  @override
  bool shouldRelayout(_PopupMenuRouteGridLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

class _PopupMenu<T> extends StatelessWidget {
  const _PopupMenu({Key key, this.route}) : super(key: key);

  final _PopupMenuRoute<T> route;

  @override
  Widget build(BuildContext context) {
    /*final double unit = 1.0 /
        (route.items.length +
            1.5);*/ // 1.0 for the width and 0.5 for the last item's fade.
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < route.items.length; ++i) {
      Widget item = route.items[i];
      /*final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = new CurvedAnimation(
          parent: route.animation, curve: new Interval(start, end));
      if (route.initialValue != null &&
          route.initialValue == route.items[i].value) {
        item =
            new Container(color: Theme.of(context).highlightColor, child: item);
      }*/
      children.add(item);
      //children.add(new FadeTransition(opacity: opacity, child: item));
    }

    /*final CurveTween opacity =
        new CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = new CurveTween(curve: new Interval(0.0, unit));
    final CurveTween height =
        new CurveTween(curve: new Interval(0.0, unit * route.items.length));
*/
    final Widget child = new SizedBox(
        width: 480.0,
        height: 320.0,
        child: new GridView(
          children: children,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        ));

    return new Material(
      type: MaterialType.card,
      elevation: route.elevation,
      child: child,
    );
  }
}

class PopupGridMenuItem<T> extends PopupMenuEntry<T> {
  /// Creates an item for a popup menu.
  ///
  /// By default, the item is enabled.
  const PopupGridMenuItem({
    Key key,
    this.value,
    this.enabled: true,
    @required this.child,
  })
      : super(key: key);

  @override
  final T value;

  @override
  final bool enabled;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  double get height => _kMenuItemHeight;

  @override
  _PopupGridMenuItemState<PopupGridMenuItem<T>> createState() =>
      new _PopupGridMenuItemState<PopupGridMenuItem<T>>();
}

class _PopupGridMenuItemState<T extends PopupGridMenuItem<dynamic>>
    extends State<T> {
  // Override this to put something else in the menu entry.
  Widget buildChild() => widget.child;

  void onTap() {
    Navigator.pop(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.subhead;
    if (!widget.enabled) style = style.copyWith(color: theme.disabledColor);

    /*Widget item = new AnimatedDefaultTextStyle(
        style: style,
        duration: kThemeChangeDuration,
        child: new Baseline(
            baseline: widget.height,
            baselineType: TextBaseline.alphabetic,
            child: buildChild()));
    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      Widget item = IconTheme.merge(
          data: new IconThemeData(opacity: isDark ? 0.5 : 0.38),
          child: buildChild());
    }*/

    return new InkWell(
        onTap: widget.enabled ? onTap : null,
        child: new MergeSemantics(
            child: new Container(
                height: widget.height,
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: buildChild())));
  }
}
