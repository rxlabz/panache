import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelConfiguration {
  final String label;
  final String id;
  final Map<String, Type> properties;
  bool closed;

  PanelConfiguration(
    this.label,
    this.id,
    this.properties, {
    this.closed = true,
  });

  PanelConfiguration toggle(bool value) => PanelConfiguration(
        label,
        id,
        properties,
        closed: value,
      );
}

///
/// list of panels list of theme properties
///
final List<PanelConfiguration> themeEditorConfiguration = [
  PanelConfiguration('Main colors', 'mainColors', theme191MainColors),
  PanelConfiguration('Button Theme', 'buttonTheme', theme191ButtonTheme),
  PanelConfiguration(
    'Toggle Button Theme',
    'toggleButtonsTheme',
    theme191ToggleButtonsTheme,
  ),
];
  
final themeMap192 = <String, Type>{
  /*'primarySwatch': MaterialColor ,*/

  /* MAIN COLORS */
  'brightness': Brightness /* int (enum index) */,
  'primaryColor': Color /* int */,
  'primaryColor': Color,
  'primaryColorBrightness': Brightness,
  'primaryColorLight': Color,
  'primaryColorDark': Color,
  'canvasColor': Color,
  'accentColor': Color,
  'accentColorBrightness': Brightness,
  'scaffoldBackgroundColor': Color,
  'bottomAppBarColor': Color,
  'cardColor': Color,
  'dividerColor': Color,
  'focusColor': Color,
  'hoverColor': Color,
  'highlightColor': Color,
  'splashColor': Color,
  'selectedRowColor': Color,
  'unselectedWidgetColor': Color,
  'disabledColor': Color,
  'buttonColor': Color,
  'secondaryHeaderColor': Color,
  'textSelectionColor': Color,
  'cursorColor': Color,
  'textSelectionHandleColor': Color,
  'backgroundColor': Color,
  'dialogBackgroundColor': Color,
  'indicatorColor': Color,
  'hintColor': Color,
  'errorColor': Color,
  'toggleableActiveColor': Color,
  /* FIXME 'fontFamily': String,*/
  /* FIXME 'splashFactory': InteractiveInkFeatureFactory,*/
  /* FIXME 'typography': 'Typography',*/
  /* FIXME 'platform': 'TargetPlatform',*/
  /* FIXME 'materialTapTargetSize': 'MaterialTapTargetSize',*/
  /* FIXME 'applyElevationOverlayColor': 'bool',*/

  /* SUBTHEMES */
  'buttonTheme': ButtonThemeData /*theme191ButtonTheme*/,
  'toggleButtonsTheme': ToggleButtonsThemeData /*theme191ToggleButtonsTheme*/,
  'textTheme': TextTheme,
  'primaryTextTheme': TextTheme,
  'accentTextTheme': TextTheme,
  'inputDecorationTheme': InputDecorationTheme,
  'iconTheme': IconThemeData,
  'primaryIconTheme': IconThemeData,
  'accentIconTheme': IconThemeData,
  'sliderTheme': SliderThemeData,
  'tabBarTheme': TabBarTheme,
  'tooltipTheme': TooltipThemeData,
  'cardTheme': CardTheme,
  'chipTheme': ChipThemeData,
  'appBarTheme': AppBarTheme,
  'bottomAppBarTheme': BottomAppBarTheme,
  'colorScheme': ColorScheme,
  'dialogTheme': DialogTheme,
  'floatingActionButtonTheme': FloatingActionButtonThemeData,
  'cupertinoOverrideTheme': CupertinoThemeData,
  'snackBarTheme': SnackBarThemeData,
  'bottomSheetTheme': BottomSheetThemeData,
  'popupMenuTheme': PopupMenuThemeData,
  'bannerTheme': MaterialBannerThemeData,
  'dividerTheme': DividerThemeData,
  /* TODO 'pageTransitionsTheme': 'PageTransitionsTheme',*/
};

// FIXME
const theme191MainConfig = <String, Type>{
  /* TODO 'fontFamily': String,*/
  /* TODO 'splashFactory': InteractiveInkFeatureFactory,*/
  /* TODO 'typography': 'Typography',*/
  /* TODO 'platform': 'TargetPlatform',*/
  /* TODO 'materialTapTargetSize': 'MaterialTapTargetSize',*/
  /* TODO 'applyElevationOverlayColor': 'bool',*/
};

const theme191MainColors = <String, Type>{
  'brightness': Brightness /* int (enum index) */,
  'primaryColor': Color /* int */,
  'primaryColorBrightness': Brightness,
  'primaryColorLight': Color,
  'primaryColorDark': Color,
  'canvasColor': Color,
  'accentColor': Color,
  'accentColorBrightness': Brightness,
  'scaffoldBackgroundColor': Color,
  'bottomAppBarColor': Color,
  'cardColor': Color,
  'dividerColor': Color,
  'focusColor': Color,
  'hoverColor': Color,
  'highlightColor': Color,
  'splashColor': Color,
  'selectedRowColor': Color,
  'unselectedWidgetColor': Color,
  'disabledColor': Color,
  'buttonColor': Color,
  'secondaryHeaderColor': Color,
  'textSelectionColor': Color,
  'cursorColor': Color,
  'textSelectionHandleColor': Color,
  'backgroundColor': Color,
  'dialogBackgroundColor': Color,
  'indicatorColor': Color,
  'hintColor': Color,
  'errorColor': Color,
  'toggleableActiveColor': Color,
};

final theme191ButtonTheme = <String, Type>{
  'textTheme': ButtonTextTheme /*ButtonTextTheme.normal*/,
  'minWidth': double /*88.0*/,
  'height': double /*36.0*/,
  'padding': EdgeInsetsGeometry,
  'shape': ShapeBorder,
  'layoutBehavior': ButtonBarLayoutBehavior /* ButtonBarLayoutBehavior.padded*/,
  'alignedDropdown': bool /*false*/,
  'buttonColor': Color,
  'disabledColor': Color,
  'focusColor': Color,
  'hoverColor': Color,
  'highlightColor': Color,
  'splashColor': Color,
  'colorScheme': ColorScheme,
  'materialTapTargetSize': MaterialTapTargetSize,
};

final theme191ToggleButtonsTheme = <String, Type>{
  'color': Color,
  'selectedColor': Color,
  'disabledColor': Color,
  'fillColor': Color,
  'focusColor': Color,
  'hoverColor': Color,
  'highlightColor': Color,
  'splashColor': Color,
  'borderColor': Color,
  'selectedBorderColor': Color,
  'disabledBorderColor': Color,
  'borderRadius': BorderRadius,
  'borderWidth': double,
};

final theme191TextTheme = <String, Type>{
  'display4': TextStyle /* theme191TextStyle */,
  'display3': TextStyle /* theme191TextStyle */,
  'display2': TextStyle /* theme191TextStyle */,
  'display1': TextStyle /* theme191TextStyle */,
  'headline': TextStyle /* theme191TextStyle */,
  'title': TextStyle /* theme191TextStyle */,
  'subhead': TextStyle /* theme191TextStyle */,
  'body2': TextStyle /* theme191TextStyle */,
  'body1': TextStyle /* theme191TextStyle */,
  'caption': TextStyle /* theme191TextStyle */,
  'button': TextStyle /* theme191TextStyle */,
  'subtitle': TextStyle /* theme191TextStyle */,
  'overline': TextStyle /* theme191TextStyle */
};
final theme191PrimaryTextTheme = theme191TextTheme;
final theme191AccentTextTheme = theme191TextTheme;

final theme191InputDecorationTheme = <String, Type>{
  'labelStyle': TextStyle /* theme191TextStyle */,
  'helperStyle': TextStyle /* theme191TextStyle */,
  'hintStyle': TextStyle /* theme191TextStyle */,
  'errorStyle': TextStyle /* theme191TextStyle */,
  'errorMaxLines': int,
  'hasFloatingPlaceholder': bool /*: true*/,
  'isDense': bool /*: false*/,
  'contentPadding': EdgeInsetsGeometry,
  'isCollapsed': bool /*: false*/,
  'prefixStyle': TextStyle /* theme191TextStyle */,
  'suffixStyle': TextStyle /* theme191TextStyle */,
  'counterStyle': TextStyle /* theme191TextStyle */,
  'filled': bool /*: false*/,
  'fillColor': Color,
  'focusColor': Color,
  'hoverColor': Color,
  'errorBorder': InputBorder,
  'focusedBorder': InputBorder,
  'focusedErrorBorder': InputBorder,
  'disabledBorder': InputBorder,
  'enabledBorder': InputBorder,
  'border': InputBorder,
  'alignLabelWithHint': bool /*: false*/
};

final theme191IconTheme = <String, Type>{
  'color': Color,
  'opacity': double,
  'size': double,
};
final theme191PrimaryIconTheme = theme191IconTheme;
final theme191AcentIconTheme = theme191IconTheme;

final theme191SliderTheme = <String, Type>{
  'trackHeight': double,
  'activeTrackColor': Color,
  'inactiveTrackColor': Color,
  'disabledActiveTrackColor': Color,
  'disabledInactiveTrackColor': Color,
  'activeTickMarkColor': Color,
  'inactiveTickMarkColor': Color,
  'disabledActiveTickMarkColor': Color,
  'disabledInactiveTickMarkColor': Color,
  'thumbColor': Color,
  'overlappingShapeStrokeColor': Color,
  'disabledThumbColor': Color,
  'overlayColor': Color,
  'valueIndicatorColor': Color,
  'minThumbSeparation': double,
  'overlayShape': SliderComponentShape,
  'tickMarkShape': SliderTickMarkShape,
  'thumbShape': SliderComponentShape,
  'trackShape': SliderTrackShape,
  'valueIndicatorShape': SliderComponentShape,
  'rangeTickMarkShape': RangeSliderTickMarkShape,
  'rangeThumbShape': RangeSliderThumbShape,
  'rangeTrackShape': RangeSliderTrackShape,
  'rangeValueIndicatorShape': RangeSliderValueIndicatorShape,
  'showValueIndicator': ShowValueIndicator,
  'valueIndicatorTextStyle': TextStyle,
  'thumbSelector': RangeThumbSelector
};

final theme191TabBarTheme = <String, Type>{
  'indicator': Decoration,
  'indicatorSize': TabBarIndicatorSize,
  'labelColor': Color,
  'labelPadding': EdgeInsetsGeometry,
  'labelStyle': TextStyle,
  'unselectedLabelColor': Color,
  'unselectedLabelStyle': TextStyle,
};

final theme191TooltipTheme = <String, Type>{
  'height': double,
  'padding': EdgeInsetsGeometry,
  'margin': EdgeInsetsGeometry,
  'verticalOffset': double,
  'preferBelow': bool,
  'excludeFromSemantics': bool,
  'decoration': Decoration,
  'textStyle': TextStyle,
  'waitDuration': Duration,
  'showDuration': Duration,
};

final theme191CardTheme = <String, Type>{
  'clipBehavior': Clip,
  'color': Color,
  'elevation': double,
  'margin': EdgeInsetsGeometry,
  'shape': ShapeBorder,
};

final theme191ChipTheme = <String, Type>{
  'backgroundColor': Color /* @required*/,
  'deleteIconColor': Color,
  'disabledColor': Color /* @required*/,
  'selectedColor': Color /* @required*/,
  'secondarySelectedColor': Color /* @required*/,
  'shadowColor': Color,
  'selectedShadowColor': Color,
  'labelPadding': EdgeInsetsGeometry /* @required*/,
  'padding': EdgeInsetsGeometry /* @required*/,
  'shape': ShapeBorder /* @required*/,
  'labelStyle': TextStyle /* @required*/,
  'secondaryLabelStyle': TextStyle /* @required*/,
  'brightness': Brightness /* @required*/,
  'elevation': double,
  'pressElevation': double
};

final theme191AppBarTheme = <String, Type>{
  'brightness': Brightness,
  'color': Color,
  'elevation': double,
  'iconTheme': IconThemeData,
  'actionsIconTheme': IconThemeData,
  'textTheme': TextTheme,
};

final theme191BottomAppBarTheme = <String, Type>{
  'color': Color,
  'elevation': double,
  'shape': NotchedShape,
};

final theme191DialogTheme = <String, Type>{
  'backgroundColor': Color,
  'elevation': double,
  'shape': ShapeBorder,
  'titleTextStyle': TextStyle,
  'contentTextStyle': TextStyle,
};

final theme191FloatingActionButtonTheme = <String, Type>{
  'foregroundColor': Color,
  'backgroundColor': Color,
  'focusColor': Color,
  'hoverColor': Color,
  'splashColor': Color,
  'elevation': double,
  'focusElevation': double,
  'hoverElevation': double,
  'disabledElevation': double,
  'highlightElevation': double,
  'shape': ShapeBorder,
};

final theme191CuppertinoTheme = <String, Type>{
  'brightness': Brightness,
  'primaryColor': Color,
  'primaryContrastingColor': Color,
  'textTheme': CupertinoTextThemeData,
  'barBackgroundColor': Color,
  'scaffoldBackgroundColo': Color,
};

final theme191SnackBarTheme = <String, Type>{
  'backgroundColor': Color,
  'actionTextColor': Color,
  'disabledActionTextColor': Color,
  'elevation': double,
  'contentTextStyle': TextStyle,
  'shape': ShapeBorder,
  'behavior': SnackBarBehavior,
};

final theme191BottomSheetTheme = <String, Type>{
  'backgroundColor': Color,
  'actionTextColor': Color,
  'shape': ShapeBorder,
};

final theme191PopupMenuTheme = <String, Type>{
  'backgroundColor': Color,
  'actionTextColor': Color,
  'shape': ShapeBorder,
  'textStyle': TextStyle,
};

final theme191MaterialBannerTheme = <String, Type>{
  'backgroundColor': Color,
  'contentTextStyle': TextStyle,
  'padding': EdgeInsetsGeometry,
  'leadingPadding': EdgeInsetsGeometry,
};

final theme191DividerTheme = <String, Type>{
  'color': Color,
  'space': double,
  'thickness': double,
  'indent': double,
  'endIndent': double,
};

final theme191ColorScheme = <String, Type>{
  'primary': Color /* required */,
  'primaryVariant': Color /* required */,
  'secondary': Color /* required */,
  'secondaryVariant': Color /* required */,
  'surface': Color /* required */,
  'background': Color /* required */,
  'error': Color /* required */,
  'onPrimary': Color /* required */,
  'onSecondary': Color /* required */,
  'onSurface': Color /* required */,
  'onBackground': Color /* required */,
  'onError': Color /* required */,
  'brightness': Brightness /* required */,
};

final theme191TextStyle = <String, Type>{
  'inherit': bool /* true*/,
  'color': Color,
  'backgroundColor': Color,
  'fontSize': double,
  'fontWeight': FontWeight,
  'fontStyle': FontStyle,
  'letterSpacing': double,
  'wordSpacing': double,
  'textBaseline': TextBaseline,
  'height': double,
  'locale': Locale,
  'foreground': Paint,
  'background': Paint,
  'shadows': List/*<Shadow>*/ /* FIXME */,
  'fontFeatures': List/*<FontFeature>*/ /* FIXME */,
  'decoration': TextDecoration,
  'decorationColor': Color,
  'decorationStyle': TextDecorationStyle,
  'decorationThickness': double,
  'fontFamily': String,
  'fontFamilyFallback': List/*<String>*/ /* FIXME */,
  'package': String
  /*'debugLabel':'String',*/
};
