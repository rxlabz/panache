// based on Flutter Slider

import 'dart:async';
import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';

abstract class GradientSliderComponentShape {
  const GradientSliderComponentShape();

  Size getPreferredSize(bool isEnabled, bool isDiscrete);
  void paint(
    RenderBox parentBox,
    PaintingContext context,
    bool isDiscrete,
    Offset thumbCenter,
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    TextPainter labelPainter,
    GradientSliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    Color colorValue,
  );
}

class RectSliderThumbShape extends GradientSliderComponentShape {
  const RectSliderThumbShape();
  static const double _thumbRadius = 6.0;
  static const double _disabledThumbRadius = 4.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return new Size.fromRadius(isEnabled ? _thumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    RenderBox parentBox,
    PaintingContext context,
    bool isDiscrete,
    Offset thumbCenter,
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    TextPainter labelPainter,
    GradientSliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    Color colorValue,
  ) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = new ColorTween(
      begin: Colors.white,
      end: colorValue ?? Colors.white,
    );
    canvas.drawRect(
      Rect.fromPoints(Offset(thumbCenter.dx - 3.0, thumbCenter.dy - 6.0),
          Offset(thumbCenter.dx + 3.0, thumbCenter.dy + 6.0)),
      new Paint()..color = colorTween.evaluate(enableAnimation),
    );
  }
}

class RoundColorSliderThumbShape extends GradientSliderComponentShape {
  const RoundColorSliderThumbShape();

  static const double _thumbRadius = 6.0;
  static const double _disabledThumbRadius = 4.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return new Size.fromRadius(isEnabled ? _thumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    RenderBox parentBox,
    PaintingContext context,
    bool isDiscrete,
    Offset thumbCenter,
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    TextPainter labelPainter,
    GradientSliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    Color colorValue,
  ) {
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = new Tween<double>(
      begin: _disabledThumbRadius,
      end: _thumbRadius,
    );

    final ColorTween colorTween = new ColorTween(
      begin: Colors.white,
      end: colorValue ?? Colors.white,
    );
    canvas.drawCircle(
      thumbCenter,
      radiusTween.evaluate(enableAnimation),
      new Paint()..color = colorTween.evaluate(enableAnimation),
    );
    canvas.drawCircle(
        thumbCenter,
        radiusTween.evaluate(enableAnimation),
        new Paint()
          ..color = getContrastColor(colorValue, limit: 650)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0);
  }
}

class PaddleSliderColorValueIndicatorShape
    extends GradientSliderComponentShape {
  const PaddleSliderColorValueIndicatorShape();

  static const double _topLobeRadius = 16.0;
  static const double _labelTextDesignSize = 14.0;
  static const double _bottomLobeRadius = 6.0;
  static const double _bottomLobeStartAngle = -1.1 * math.pi / 4.0;
  static const double _bottomLobeEndAngle = 1.1 * 5 * math.pi / 4.0;
  static const double _labelPadding = 8.0;
  static const double _distanceBetweenTopBottomCenters = 40.0;
  static const Offset _topLobeCenter =
      const Offset(0.0, -_distanceBetweenTopBottomCenters);
  static const double _topNeckRadius = 14.0;
  static const double _neckTriangleHypotenuse = _topLobeRadius + _topNeckRadius;
  static const double _twoSeventyDegrees = 3.0 * math.pi / 2.0;
  static const double _ninetyDegrees = math.pi / 2.0;
  static const double _thirtyDegrees = math.pi / 6.0;
  static const Size _preferredSize = const Size.fromHeight(
      _distanceBetweenTopBottomCenters + _topLobeRadius + _bottomLobeRadius);
  static const bool _debuggingLabelLocation = false;

  static Path _bottomLobePath; // Initialized by _generateBottomLobe
  static Offset _bottomLobeEnd; // Initialized by _generateBottomLobe

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => _preferredSize;

  static void _addArc(Path path, Offset center, double radius,
      double startAngle, double endAngle) {
    final Rect arcRect = new Rect.fromCircle(center: center, radius: radius);
    path.arcTo(arcRect, startAngle, endAngle - startAngle, false);
  }

  static void _generateBottomLobe() {
    const double bottomNeckRadius = 4.5;
    const double bottomNeckStartAngle = _bottomLobeEndAngle - math.pi;
    const double bottomNeckEndAngle = 0.0;

    final Path path = new Path();
    final Offset bottomKnobStart = new Offset(
      _bottomLobeRadius * math.cos(_bottomLobeStartAngle),
      _bottomLobeRadius * math.sin(_bottomLobeStartAngle),
    );
    final Offset bottomNeckRightCenter = bottomKnobStart +
        new Offset(
          bottomNeckRadius * math.cos(bottomNeckStartAngle),
          -bottomNeckRadius * math.sin(bottomNeckStartAngle),
        );
    final Offset bottomNeckLeftCenter = new Offset(
      -bottomNeckRightCenter.dx,
      bottomNeckRightCenter.dy,
    );
    final Offset bottomNeckStartRight = new Offset(
      bottomNeckRightCenter.dx - bottomNeckRadius,
      bottomNeckRightCenter.dy,
    );
    path.moveTo(bottomNeckStartRight.dx, bottomNeckStartRight.dy);
    _addArc(
      path,
      bottomNeckRightCenter,
      bottomNeckRadius,
      math.pi - bottomNeckEndAngle,
      math.pi - bottomNeckStartAngle,
    );
    _addArc(
      path,
      Offset.zero,
      _bottomLobeRadius,
      _bottomLobeStartAngle,
      _bottomLobeEndAngle,
    );
    _addArc(
      path,
      bottomNeckLeftCenter,
      bottomNeckRadius,
      bottomNeckStartAngle,
      bottomNeckEndAngle,
    );

    _bottomLobeEnd = new Offset(
      -bottomNeckStartRight.dx,
      bottomNeckStartRight.dy,
    );
    _bottomLobePath = path;
  }

  Offset _addBottomLobe(Path path) {
    if (_bottomLobePath == null || _bottomLobeEnd == null) {
      _generateBottomLobe();
    }
    path.extendWithPath(_bottomLobePath, Offset.zero);
    return _bottomLobeEnd;
  }

  double _getIdealOffset(
    RenderBox parentBox,
    double halfWidthNeeded,
    double scale,
    Offset center,
  ) {
    const double edgeMargin = 4.0;
    final Rect topLobeRect = new Rect.fromLTWH(
      -_topLobeRadius - halfWidthNeeded,
      -_topLobeRadius - _distanceBetweenTopBottomCenters,
      2.0 * (_topLobeRadius + halfWidthNeeded),
      2.0 * _topLobeRadius,
    );

    final Offset topLeft = (topLobeRect.topLeft * scale) + center;
    final Offset bottomRight = (topLobeRect.bottomRight * scale) + center;
    double shift = 0.0;
    if (topLeft.dx < edgeMargin) {
      shift = edgeMargin - topLeft.dx;
    }
    if (bottomRight.dx > parentBox.size.width - edgeMargin) {
      shift = parentBox.size.width - bottomRight.dx - edgeMargin;
    }
    shift = (scale == 0.0 ? 0.0 : shift / scale);
    return shift;
  }

  void _drawValueIndicator(
    RenderBox parentBox,
    Canvas canvas,
    Offset center,
    Paint paint,
    double scale,
    TextPainter labelPainter,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final double textScaleFactor = labelPainter.height / _labelTextDesignSize;
    final double overallScale = scale * textScaleFactor;
    canvas.scale(overallScale, overallScale);
    final double inverseTextScale =
        textScaleFactor != 0 ? 1.0 / textScaleFactor : 0.0;
    final double labelHalfWidth = labelPainter.width / 2.0;

    final double halfWidthNeeded = math.max(
      0.0,
      inverseTextScale * labelHalfWidth - (_topLobeRadius - _labelPadding),
    );

    double shift =
        _getIdealOffset(parentBox, halfWidthNeeded, overallScale, center);
    double leftWidthNeeded;
    double rightWidthNeeded;
    if (shift < 0.0) {
      shift = math.max(shift, -halfWidthNeeded);
    } else {
      shift = math.min(shift, halfWidthNeeded);
    }
    rightWidthNeeded = halfWidthNeeded + shift;
    leftWidthNeeded = halfWidthNeeded - shift;

    final Path path = new Path();
    final Offset bottomLobeEnd = _addBottomLobe(path);

    final double neckTriangleBase = _topNeckRadius - bottomLobeEnd.dx;

    final double leftAmount =
        math.max(0.0, math.min(1.0, leftWidthNeeded / neckTriangleBase));
    final double rightAmount =
        math.max(0.0, math.min(1.0, rightWidthNeeded / neckTriangleBase));

    final double leftTheta = (1.0 - leftAmount) * _thirtyDegrees;
    final double rightTheta = (1.0 - rightAmount) * _thirtyDegrees;

    final Offset neckLeftCenter = new Offset(
      -neckTriangleBase,
      _topLobeCenter.dy + math.cos(leftTheta) * _neckTriangleHypotenuse,
    );
    final Offset neckRightCenter = new Offset(
      neckTriangleBase,
      _topLobeCenter.dy + math.cos(rightTheta) * _neckTriangleHypotenuse,
    );
    final double leftNeckArcAngle = _ninetyDegrees - leftTheta;
    final double rightNeckArcAngle = math.pi + _ninetyDegrees - rightTheta;

    final double neckStretchBaseline =
        bottomLobeEnd.dy - math.max(neckLeftCenter.dy, neckRightCenter.dy);
    final double t = math.pow(inverseTextScale, 3.0);
    final double stretch =
        (neckStretchBaseline * t).clamp(0.0, 10.0 * neckStretchBaseline);
    final Offset neckStretch = new Offset(0.0, neckStretchBaseline - stretch);

    assert(!_debuggingLabelLocation ||
        () {
          final Offset leftCenter =
              _topLobeCenter - new Offset(leftWidthNeeded, 0.0) + neckStretch;
          final Offset rightCenter =
              _topLobeCenter + new Offset(rightWidthNeeded, 0.0) + neckStretch;
          final Rect valueRect = new Rect.fromLTRB(
            leftCenter.dx - _topLobeRadius,
            leftCenter.dy - _topLobeRadius,
            rightCenter.dx + _topLobeRadius,
            rightCenter.dy + _topLobeRadius,
          );
          final Paint outlinePaint = new Paint()
            ..color = const Color(0xffff0000)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0;
          canvas.drawRect(valueRect, outlinePaint);
          return true;
        }());

    _addArc(
      path,
      neckLeftCenter + neckStretch,
      _topNeckRadius,
      0.0,
      -leftNeckArcAngle,
    );
    _addArc(
      path,
      _topLobeCenter - new Offset(leftWidthNeeded, 0.0) + neckStretch,
      _topLobeRadius,
      _ninetyDegrees + leftTheta,
      _twoSeventyDegrees,
    );
    _addArc(
      path,
      _topLobeCenter + new Offset(rightWidthNeeded, 0.0) + neckStretch,
      _topLobeRadius,
      _twoSeventyDegrees,
      _twoSeventyDegrees + math.pi - rightTheta,
    );
    _addArc(
      path,
      neckRightCenter + neckStretch,
      _topNeckRadius,
      rightNeckArcAngle,
      math.pi,
    );
    canvas.drawPath(path, paint);

    // Draw the label.
    canvas.save();
    canvas.translate(shift, -_distanceBetweenTopBottomCenters + neckStretch.dy);
    canvas.scale(inverseTextScale, inverseTextScale);
    labelPainter.paint(canvas,
        Offset.zero - new Offset(labelHalfWidth, labelPainter.height / 2.0));
    canvas.restore();
    canvas.restore();
  }

  @override
  void paint(
    RenderBox parentBox,
    PaintingContext context,
    bool isDiscrete,
    Offset thumbCenter,
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    TextPainter labelPainter,
    GradientSliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    Color colorValue,
  ) {
    assert(labelPainter != null);

    final ColorTween enableColor = new ColorTween(
      begin: Colors.white,
      end: colorValue ?? Colors.white,
    );
    _drawValueIndicator(
      parentBox,
      context.canvas,
      thumbCenter,
      new Paint()..color = enableColor.evaluate(enableAnimation),
      activationAnimation.value,
      labelPainter,
    );
  }
}

class GradientSlider extends StatefulWidget {
  const GradientSlider({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.startColor,
    @required this.endColor,
    @required this.thumbColor,
    this.colors,
    this.min: 0.0,
    this.max: 1.0,
    this.label,
  })  : assert(value != null),
        assert(min != null),
        assert(max != null),
        assert(min <= max),
        assert(value >= min && value <= max),
        super(key: key);

  final double value;

  final ValueChanged<double> onChanged;

  final double min;

  final double max;

  final String label;

  final Color startColor;
  final Color endColor;
  final Color thumbColor;
  final List<Color> colors;

  @override
  _ColorGradientSliderState createState() => new _ColorGradientSliderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(new DoubleProperty('value', value));
    description.add(new DoubleProperty('min', min));
    description.add(new DoubleProperty('max', max));
    description.add(new StringProperty('startColor', startColor.toString()));
    description.add(new StringProperty('endColor', endColor.toString()));
    description.add(new StringProperty('thumbColor', thumbColor.toString()));
  }
}

class _ColorGradientSliderState extends State<GradientSlider>
    with TickerProviderStateMixin {
  static const Duration enableAnimationDuration =
      const Duration(milliseconds: 75);
  static const Duration valueIndicatorAnimationDuration =
      const Duration(milliseconds: 100);

  AnimationController overlayController;
  AnimationController valueIndicatorController;
  AnimationController enableController;
  AnimationController positionController;
  Timer interactionTimer;

  @override
  void initState() {
    super.initState();
    overlayController = new AnimationController(
      duration: kRadialReactionDuration,
      vsync: this,
    );
    valueIndicatorController = new AnimationController(
      duration: valueIndicatorAnimationDuration,
      vsync: this,
    );
    enableController = new AnimationController(
      duration: enableAnimationDuration,
      vsync: this,
    );
    positionController = new AnimationController(
      duration: Duration.zero,
      vsync: this,
    );

    interactionTimer = new Timer(Duration.zero, () {});
    interactionTimer.cancel();
    enableController.value = widget.onChanged != null ? 1.0 : 0.0;
    positionController.value = _unlerp(widget.value);
  }

  /*@override
  void didUpdateWidget(RGBGradientSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
  }*/

  @override
  void dispose() {
    overlayController.dispose();
    valueIndicatorController.dispose();
    enableController.dispose();
    positionController.dispose();
    interactionTimer?.cancel();
    super.dispose();
  }

  void _handleChanged(double value) {
    assert(widget.onChanged != null);
    final double lerpValue = _lerp(value);
    if (lerpValue != widget.value) {
      widget.onChanged(lerpValue);
    }
  }

  double _lerp(double value) {
    assert(value >= 0.0);
    assert(value <= 1.0);
    return value * (widget.max - widget.min) + widget.min;
  }

  double _unlerp(double value) {
    assert(value <= widget.max);
    assert(value >= widget.min);
    return widget.max > widget.min
        ? (value - widget.min) / (widget.max - widget.min)
        : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMediaQuery(context));

    GradientSliderThemeData sliderTheme = GradientSliderTheme.of(context);

    if (widget.startColor != null || widget.endColor != null) {
      sliderTheme = sliderTheme.copyWith(
        startRailColor: widget.startColor,
        endRailColor: widget.endColor,
        overlayColor: widget.startColor?.withAlpha(0x29),
      );
    }

    return new _GradientSliderRenderObjectWidget(
      value: _unlerp(widget.value),
      thumbColor: widget.thumbColor,
      colors: widget.colors,
      label: widget.label,
      sliderTheme: sliderTheme,
      mediaQueryData: MediaQuery.of(context),
      onChanged: (widget.onChanged != null) && (widget.max > widget.min)
          ? _handleChanged
          : null,
      state: this,
    );
  }
}

class _GradientSliderRenderObjectWidget extends LeafRenderObjectWidget {
  const _GradientSliderRenderObjectWidget({
    Key key,
    this.value,
    this.thumbColor,
    this.colors,
    this.label,
    this.sliderTheme,
    this.mediaQueryData,
    this.onChanged,
    this.state,
  }) : super(key: key);

  final double value;
  final String label;
  final GradientSliderThemeData sliderTheme;
  final MediaQueryData mediaQueryData;
  final ValueChanged<double> onChanged;
  final _ColorGradientSliderState state;
  final Color thumbColor;
  final List<Color> colors;

  @override
  _RenderSlider createRenderObject(BuildContext context) {
    return new _RenderSlider(
      value: value,
      thumbColor: thumbColor,
      colors: colors,
      label: label,
      sliderTheme: sliderTheme,
      theme: Theme.of(context),
      mediaQueryData: mediaQueryData,
      onChanged: onChanged,
      state: state,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSlider renderObject) {
    renderObject
      ..value = value
      ..thumbColor = thumbColor
      ..colors = colors
      ..label = label
      ..sliderTheme = sliderTheme
      ..theme = Theme.of(context)
      ..mediaQueryData = mediaQueryData
      ..onChanged = onChanged
      ..textDirection = Directionality.of(context);
  }
}

class _RenderSlider extends RenderBox {
  _RenderSlider({
    @required double value,
    @required Color thumbColor,
    List<Color> colors,
    String label,
    GradientSliderThemeData sliderTheme,
    ThemeData theme,
    MediaQueryData mediaQueryData,
    ValueChanged<double> onChanged,
    @required _ColorGradientSliderState state,
    @required TextDirection textDirection,
  })  : assert(value != null && value >= 0.0 && value <= 1.0),
        assert(state != null),
        assert(textDirection != null),
        _label = label,
        _value = value,
        _thumbColor = thumbColor,
        _colors = colors,
        _gradientSliderTheme = sliderTheme,
        _theme = theme,
        _mediaQueryData = mediaQueryData,
        _onChanged = onChanged,
        _state = state,
        _textDirection = textDirection {
    _updateLabelPainter();

    final GestureArenaTeam team = new GestureArenaTeam();

    _drag = new HorizontalDragGestureRecognizer()
      ..team = team
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..onCancel = _endInteraction;

    _tap = new TapGestureRecognizer()
      ..team = team
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTapCancel = _endInteraction;

    _overlayAnimation = new CurvedAnimation(
      parent: _state.overlayController,
      curve: Curves.fastOutSlowIn,
    );
    _valueIndicatorAnimation = new CurvedAnimation(
      parent: _state.valueIndicatorController,
      curve: Curves.fastOutSlowIn,
    );
    _enableAnimation = new CurvedAnimation(
      parent: _state.enableController,
      curve: Curves.easeInOut,
    );
  }

  static const Duration _positionAnimationDuration =
      const Duration(milliseconds: 75);
  static const double _overlayRadius = 16.0;
  static const double _overlayDiameter = _overlayRadius * 2.0;
  static const double _railHeight = 12.0;
  static const double _preferredRailWidth = 144.0;
  static const double _preferredTotalWidth =
      _preferredRailWidth + _overlayDiameter;
  static const Duration _minimumInteractionTime =
      const Duration(milliseconds: 500);
  static const double _adjustmentUnit =
      0.1; // Matches iOS implementation of material slider.
  static final Tween<double> _overlayRadiusTween =
      new Tween<double>(begin: 0.0, end: _overlayRadius);

  _ColorGradientSliderState _state;
  Animation<double> _overlayAnimation;
  Animation<double> _valueIndicatorAnimation;
  Animation<double> _enableAnimation;
  final TextPainter _labelPainter = new TextPainter();
  HorizontalDragGestureRecognizer _drag;
  TapGestureRecognizer _tap;
  bool _active = false;
  double _currentDragValue = 0.0;

  double get _railLength => size.width - _overlayDiameter;

  bool get isInteractive => onChanged != null;

  bool get isDiscrete => false;

  double get value => _value;
  double _value;
  set value(double newValue) {
    assert(newValue != null && newValue >= 0.0 && newValue <= 1.0);
    final double convertedValue = newValue;
    if (convertedValue == _value) {
      return;
    }
    _value = convertedValue;
    if (isDiscrete) {
      final double distance = (_value - _state.positionController.value).abs();
      _state.positionController.duration =
          distance != 0.0 ? _positionAnimationDuration * (1.0 / distance) : 0.0;
      _state.positionController
          .animateTo(convertedValue, curve: Curves.easeInOut);
    } else {
      _state.positionController.value = convertedValue;
    }
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value) {
    if (value == _thumbColor) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  List<Color> get colors => _colors;
  List<Color> _colors;
  set colors(List<Color> value) {
    if (value == _colors) {
      return;
    }
    _colors = value;
    markNeedsPaint();
  }

  int get channelValue => _channelValue;
  int _channelValue;
  set channelValue(int value) {
    if (value == _channelValue) {
      return;
    }
    _channelValue = value;
    markNeedsPaint();
  }

  String get label => _label;
  String _label;
  set label(String value) {
    if (value == _label) {
      return;
    }
    _label = value;
    _updateLabelPainter();
  }

  GradientSliderThemeData get sliderTheme => _gradientSliderTheme;
  GradientSliderThemeData _gradientSliderTheme;
  set sliderTheme(GradientSliderThemeData value) {
    if (value == _gradientSliderTheme) {
      return;
    }
    _gradientSliderTheme = value;
    markNeedsPaint();
  }

  ThemeData get theme => _theme;
  ThemeData _theme;
  set theme(ThemeData value) {
    if (value == _theme) {
      return;
    }
    _theme = value;
    markNeedsPaint();
  }

  MediaQueryData get mediaQueryData => _mediaQueryData;
  MediaQueryData _mediaQueryData;
  set mediaQueryData(MediaQueryData value) {
    if (value == _mediaQueryData) {
      return;
    }
    _mediaQueryData = value;
    _updateLabelPainter();
  }

  ValueChanged<double> get onChanged => _onChanged;
  ValueChanged<double> _onChanged;
  set onChanged(ValueChanged<double> value) {
    if (value == _onChanged) {
      return;
    }
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      if (isInteractive) {
        _state.enableController.forward();
      } else {
        _state.enableController.reverse();
      }
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (value == _textDirection) {
      return;
    }
    _textDirection = value;
    _updateLabelPainter();
  }

  bool get showValueIndicator {
    bool showValueIndicator;
    switch (_gradientSliderTheme.showValueIndicator) {
      case ShowValueIndicator.onlyForDiscrete:
        showValueIndicator = isDiscrete;
        break;
      case ShowValueIndicator.onlyForContinuous:
        showValueIndicator = !isDiscrete;
        break;
      case ShowValueIndicator.always:
        showValueIndicator = true;
        break;
      case ShowValueIndicator.never:
        showValueIndicator = false;
        break;
    }
    return showValueIndicator;
  }

  void _updateLabelPainter() {
    if (label != null) {
      _labelPainter
        ..text = new TextSpan(
            style: _theme.accentTextTheme.body2
                .copyWith(color: getContrastColor(_thumbColor)),
            text: label)
        ..textDirection = textDirection
        ..textScaleFactor = _mediaQueryData.textScaleFactor
        ..layout();
    } else {
      _labelPainter.text = null;
    }
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _overlayAnimation.addListener(markNeedsPaint);
    _valueIndicatorAnimation.addListener(markNeedsPaint);
    _enableAnimation.addListener(markNeedsPaint);
    _state.positionController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _overlayAnimation.removeListener(markNeedsPaint);
    _valueIndicatorAnimation.removeListener(markNeedsPaint);
    _enableAnimation.removeListener(markNeedsPaint);
    _state.positionController.removeListener(markNeedsPaint);
    super.detach();
  }

  double _getValueFromVisualPosition(double visualPosition) {
    switch (textDirection) {
      case TextDirection.rtl:
        return 1.0 - visualPosition;
      case TextDirection.ltr:
        return visualPosition;
    }
    return null;
  }

  double _getValueFromGlobalPosition(Offset globalPosition) {
    final double visualPosition =
        (globalToLocal(globalPosition).dx - _overlayRadius) / _railLength;
    return _getValueFromVisualPosition(visualPosition);
  }

  void _startInteraction(Offset globalPosition) {
    if (isInteractive) {
      _active = true;
      _currentDragValue = _getValueFromGlobalPosition(globalPosition);
      onChanged(min(max(0.0, _currentDragValue), 1.0));
      _state.overlayController.forward();
      if (showValueIndicator) {
        _state.valueIndicatorController.forward();
        if (_state.interactionTimer.isActive) {
          _state.interactionTimer.cancel();
        }
        _state.interactionTimer =
            new Timer(_minimumInteractionTime * timeDilation, () {
          if (!_active &&
              _state.valueIndicatorController.status ==
                  AnimationStatus.completed) {
            _state.valueIndicatorController.reverse();
          }
          _state.interactionTimer.cancel();
        });
      }
    }
  }

  void _endInteraction() {
    if (_active) {
      _active = false;
      _currentDragValue = 0.0;
      _state.overlayController.reverse();
      if (showValueIndicator && !_state.interactionTimer.isActive) {
        _state.valueIndicatorController.reverse();
      }
    }
  }

  void _handleDragStart(DragStartDetails details) =>
      _startInteraction(details.globalPosition);

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      final double valueDelta = details.primaryDelta / _railLength;
      switch (textDirection) {
        case TextDirection.rtl:
          _currentDragValue -= valueDelta;
          break;
        case TextDirection.ltr:
          _currentDragValue += valueDelta;
          break;
      }
      onChanged(min(max(0.0, _currentDragValue), 1.0));
    }
  }

  void _handleDragEnd(DragEndDetails details) => _endInteraction();

  void _handleTapDown(TapDownDetails details) =>
      _startInteraction(details.globalPosition);

  void _handleTapUp(TapUpDetails details) => _endInteraction();

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _drag.addPointer(event);
      _tap.addPointer(event);
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return math.max(
      _overlayDiameter,
      _gradientSliderTheme.thumbShape
          .getPreferredSize(isInteractive, isDiscrete)
          .width,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _preferredTotalWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) => _overlayDiameter;

  @override
  double computeMaxIntrinsicHeight(double width) => _overlayDiameter;

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    size = new Size(
      constraints.hasBoundedWidth ? constraints.maxWidth : _preferredTotalWidth,
      constraints.hasBoundedHeight ? constraints.maxHeight : _overlayDiameter,
    );
  }

  void _paintOverlay(Canvas canvas, Offset center) {
    if (!_overlayAnimation.isDismissed) {
      final Paint overlayPaint = new Paint()
        ..color = _gradientSliderTheme.overlayColor;
      final double radius = _overlayRadiusTween.evaluate(_overlayAnimation);
      canvas.drawCircle(center, radius, overlayPaint);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final double railLength = size.width - 2 * _overlayRadius;
    final double value = _state.positionController.value;

    double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - value;
        break;
      case TextDirection.ltr:
        visualPosition = value;
        break;
    }

    const double railRadius = _railHeight / 2.0;

    final double railVerticalCenter = offset.dy + (size.height) / 2.0;
    final double railLeft = offset.dx + _overlayRadius;
    final double railTop = railVerticalCenter - railRadius;
    final double railBottom = railVerticalCenter + railRadius;
    final double railRight = railLeft + railLength;
    final double railActive = railLeft + railLength * visualPosition;

    final Offset thumbCenter = new Offset(railActive, railVerticalCenter);

    final Gradient gradient = new LinearGradient(
      colors: colors ??
          [
            _gradientSliderTheme.startRailColor,
            _gradientSliderTheme.endRailColor
          ],
    );
    Rect gradientRect = Rect.fromPoints(
        Offset(railLeft, railTop), Offset(railRight, railBottom));
    final gradientPaint = Paint()..shader = gradient.createShader(gradientRect);

    final Rect globalRect =
        new Rect.fromLTRB(railLeft, railTop, railRight, railBottom);
    canvas.drawRect(globalRect, gradientPaint);

    _paintOverlay(canvas, thumbCenter);

    if (isInteractive &&
        label != null &&
        _valueIndicatorAnimation.status != AnimationStatus.dismissed) {
      if (showValueIndicator) {
        _gradientSliderTheme.valueIndicatorShape.paint(
            this,
            context,
            isDiscrete,
            thumbCenter,
            _valueIndicatorAnimation,
            _enableAnimation,
            _labelPainter,
            _gradientSliderTheme,
            _textDirection,
            value,
            _thumbColor);
      }
    }

    _gradientSliderTheme.thumbShape.paint(
        this,
        context,
        isDiscrete,
        thumbCenter,
        _overlayAnimation,
        _enableAnimation,
        label != null ? _labelPainter : null,
        _gradientSliderTheme,
        _textDirection,
        value,
        _thumbColor);
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    config.isSemanticBoundary = isInteractive;
    if (isInteractive) {
      config.onIncrease = _increaseAction;
      config.onDecrease = _decreaseAction;
    }
  }

  double get _semanticActionUnit => _adjustmentUnit;

  void _increaseAction() {
    if (isInteractive) {
      onChanged((value + _semanticActionUnit).clamp(0.0, 1.0));
    }
  }

  void _decreaseAction() {
    if (isInteractive) {
      onChanged((value - _semanticActionUnit).clamp(0.0, 1.0));
    }
  }
}

class GradientSliderThemeData extends Diagnosticable {
  const GradientSliderThemeData({
    @required this.startRailColor,
    @required this.endRailColor,
    @required this.disabledStartRailColor,
    @required this.disabledEndRailColor,
    @required this.overlayColor,
    @required this.thumbShape,
    @required this.valueIndicatorShape,
    @required this.showValueIndicator,
  })  : assert(startRailColor != null),
        assert(endRailColor != null),
        assert(disabledStartRailColor != null),
        assert(disabledEndRailColor != null),
        assert(overlayColor != null),
        assert(thumbShape != null),
        assert(valueIndicatorShape != null),
        assert(showValueIndicator != null);

  factory GradientSliderThemeData.fromPrimaryColors({
    @required Color primaryColor,
    @required Color primaryColorDark,
    @required Color primaryColorLight,
  }) {
    assert(primaryColor != null);
    assert(primaryColorDark != null);
    assert(primaryColorLight != null);

    const int activeRailAlpha = 0xff;
    const int inactiveRailAlpha = 0x3d; // 24% opacity
    const int disabledActiveRailAlpha = 0x52; // 32% opacity
    const int disabledInactiveRailAlpha = 0x1f; // 12% opacity

    const int overlayLightAlpha = 0x29; // 16% opacity

    return new GradientSliderThemeData(
      startRailColor: primaryColor.withAlpha(activeRailAlpha),
      endRailColor: primaryColor.withAlpha(inactiveRailAlpha),
      disabledStartRailColor:
          primaryColorDark.withAlpha(disabledActiveRailAlpha),
      disabledEndRailColor:
          primaryColorDark.withAlpha(disabledInactiveRailAlpha),
      overlayColor: primaryColor.withAlpha(overlayLightAlpha),
      thumbShape: const RoundColorSliderThumbShape(),
      valueIndicatorShape: const PaddleSliderColorValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.always,
    );
  }

  final Color startRailColor;

  final Color endRailColor;

  final Color disabledStartRailColor;

  final Color disabledEndRailColor;

  final Color overlayColor;

  /// [GradientSliderComponentShape].
  final GradientSliderComponentShape thumbShape;

  /// [GradientSliderComponentShape].
  final GradientSliderComponentShape valueIndicatorShape;

  final ShowValueIndicator showValueIndicator;

  GradientSliderThemeData copyWith({
    Color startRailColor,
    Color endRailColor,
    Color disabledStartRailColor,
    Color disabledEndRailColor,
    Color overlayColor,
    GradientSliderComponentShape thumbShape,
    GradientSliderComponentShape valueIndicatorShape,
    ShowValueIndicator showValueIndicator,
  }) {
    return new GradientSliderThemeData(
      startRailColor: startRailColor ?? this.startRailColor,
      endRailColor: endRailColor ?? this.endRailColor,
      disabledStartRailColor:
          disabledStartRailColor ?? this.disabledStartRailColor,
      disabledEndRailColor: disabledEndRailColor ?? this.disabledEndRailColor,
      overlayColor: overlayColor ?? this.overlayColor,
      thumbShape: thumbShape ?? this.thumbShape,
      valueIndicatorShape: valueIndicatorShape ?? this.valueIndicatorShape,
      showValueIndicator: showValueIndicator ?? this.showValueIndicator,
    );
  }

  static GradientSliderThemeData lerp(
      GradientSliderThemeData a, GradientSliderThemeData b, double t) {
    assert(a != null);
    assert(b != null);
    assert(t != null);
    return new GradientSliderThemeData(
      startRailColor: Color.lerp(a.startRailColor, b.startRailColor, t),
      endRailColor: Color.lerp(a.endRailColor, b.endRailColor, t),
      disabledStartRailColor:
          Color.lerp(a.disabledStartRailColor, b.disabledStartRailColor, t),
      disabledEndRailColor:
          Color.lerp(a.disabledEndRailColor, b.disabledEndRailColor, t),
      overlayColor: Color.lerp(a.overlayColor, b.overlayColor, t),
      thumbShape: t < 0.5 ? a.thumbShape : b.thumbShape,
      valueIndicatorShape:
          t < 0.5 ? a.valueIndicatorShape : b.valueIndicatorShape,
      showValueIndicator: t < 0.5 ? a.showValueIndicator : b.showValueIndicator,
    );
  }

  @override
  int get hashCode {
    return hashValues(
      startRailColor,
      endRailColor,
      disabledStartRailColor,
      disabledEndRailColor,
      overlayColor,
      thumbShape,
      valueIndicatorShape,
      showValueIndicator,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final GradientSliderThemeData otherData = other;
    return otherData.startRailColor == startRailColor &&
        otherData.endRailColor == endRailColor &&
        otherData.disabledStartRailColor == disabledStartRailColor &&
        otherData.disabledEndRailColor == disabledEndRailColor &&
        otherData.overlayColor == overlayColor &&
        otherData.thumbShape == thumbShape &&
        otherData.valueIndicatorShape == valueIndicatorShape &&
        otherData.showValueIndicator == showValueIndicator;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    final ThemeData defaultTheme = new ThemeData.fallback();
    final GradientSliderThemeData defaultData =
        new GradientSliderThemeData.fromPrimaryColors(
      primaryColor: defaultTheme.primaryColor,
      primaryColorDark: defaultTheme.primaryColorDark,
      primaryColorLight: defaultTheme.primaryColorLight,
    );
    description.add(new DiagnosticsProperty<Color>(
        'activeRailColor', startRailColor,
        defaultValue: defaultData.startRailColor));
    description.add(new DiagnosticsProperty<Color>(
        'inactiveRailColor', endRailColor,
        defaultValue: defaultData.endRailColor));
    description.add(new DiagnosticsProperty<Color>(
        'disabledActiveRailColor', disabledStartRailColor,
        defaultValue: defaultData.disabledStartRailColor,
        level: DiagnosticLevel.debug));
    description.add(new DiagnosticsProperty<Color>(
        'disabledInactiveRailColor', disabledEndRailColor,
        defaultValue: defaultData.disabledEndRailColor,
        level: DiagnosticLevel.debug));
    description.add(new DiagnosticsProperty<Color>('overlayColor', overlayColor,
        defaultValue: defaultData.overlayColor, level: DiagnosticLevel.debug));
    description.add(new DiagnosticsProperty<GradientSliderComponentShape>(
        'thumbShape', thumbShape,
        defaultValue: defaultData.thumbShape, level: DiagnosticLevel.debug));
    description.add(new DiagnosticsProperty<GradientSliderComponentShape>(
        'valueIndicatorShape', valueIndicatorShape,
        defaultValue: defaultData.valueIndicatorShape,
        level: DiagnosticLevel.debug));
    description.add(new EnumProperty<ShowValueIndicator>(
        'showValueIndicator', showValueIndicator,
        defaultValue: defaultData.showValueIndicator));
  }
}

class GradientSliderTheme extends InheritedWidget {
  const GradientSliderTheme({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  final SliderThemeData data;

  static GradientSliderThemeData of(BuildContext context) {
    final SliderTheme inheritedTheme =
        context.inheritFromWidgetOfExactType(SliderTheme);
    return inheritedTheme != null
        ? inheritedTheme.data
        : sliderToGradientSliderTheme(Theme.of(context).sliderTheme);
  }

  @override
  bool updateShouldNotify(SliderTheme old) => data != old.data;

  static GradientSliderThemeData sliderToGradientSliderTheme(
          SliderThemeData sliderTheme) =>
      new GradientSliderThemeData(
          startRailColor: sliderTheme.disabledActiveTrackColor ?? Colors.black,
          endRailColor: sliderTheme.disabledActiveTrackColor ?? Colors.black,
          disabledStartRailColor:
              sliderTheme.disabledActiveTrackColor ?? Colors.black,
          disabledEndRailColor:
              sliderTheme.disabledActiveTrackColor ?? Colors.black,
          overlayColor: sliderTheme.overlayColor ?? Colors.black,
          thumbShape: RoundColorSliderThumbShape(),
          valueIndicatorShape: PaddleSliderColorValueIndicatorShape(),
          showValueIndicator: ShowValueIndicator.always);
}
