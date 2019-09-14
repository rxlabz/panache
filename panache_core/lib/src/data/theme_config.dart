import 'dart:convert';

class ThemeConfiguration {
  final bool mainColors;
  final bool buttonTheme;
  final bool textTheme;
  final bool primaryTextTheme;
  final bool accentTextTheme;
  final bool inputDecorationTheme;
  final bool iconTheme;
  final bool primaryIconTheme;
  final bool accentIconTheme;
  final bool sliderTheme;
  final bool tabBarTheme;
  final bool chipTheme;
  final bool dialogTheme;

  const ThemeConfiguration({
    this.mainColors = true,
    this.buttonTheme = false,
    this.textTheme = false,
    this.primaryTextTheme = false,
    this.accentTextTheme = false,
    this.inputDecorationTheme = false,
    this.iconTheme = false,
    this.primaryIconTheme = false,
    this.accentIconTheme = false,
    this.sliderTheme = false,
    this.tabBarTheme = false,
    this.chipTheme = false,
    this.dialogTheme = false,
  });

  factory ThemeConfiguration.fromJson(String data) {
    final jsonConfig = json.decode(data);
    return ThemeConfiguration(
      mainColors: jsonConfig['mainColors'] == 1,
      buttonTheme: jsonConfig['buttonTheme'] == 1,
      textTheme: jsonConfig['textTheme'] == 1,
      primaryTextTheme: jsonConfig['primaryTextTheme'] == 1,
      accentTextTheme: jsonConfig['accentTextTheme'] == 1,
      inputDecorationTheme: jsonConfig['inputDecorationTheme'] == 1,
      iconTheme: jsonConfig['iconTheme'] == 1,
      primaryIconTheme: jsonConfig['primaryIconTheme'] == 1,
      accentIconTheme: jsonConfig['accentIconTheme'] == 1,
      sliderTheme: jsonConfig['sliderTheme'] == 1,
      tabBarTheme: jsonConfig['tabBarTheme'] == 1,
      chipTheme: jsonConfig['chipTheme'] == 1,
      dialogTheme: jsonConfig['dialogTheme'] == 1,
    );
  }

  ThemeConfiguration copyWith({
    bool mainColors,
    bool buttonTheme,
    bool textTheme,
    bool primaryTextTheme,
    bool accentTextTheme,
    bool inputDecorationTheme,
    bool iconTheme,
    bool primaryIconTheme,
    bool accentIconTheme,
    bool sliderTheme,
    bool tabBarTheme,
    bool chipTheme,
    bool dialogTheme,
  }) {
    return ThemeConfiguration(
      mainColors: mainColors ?? this.mainColors,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      textTheme: textTheme ?? this.textTheme,
      primaryTextTheme: primaryTextTheme ?? this.primaryTextTheme,
      accentTextTheme: accentTextTheme ?? this.accentTextTheme,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      iconTheme: iconTheme ?? this.iconTheme,
      primaryIconTheme: primaryIconTheme ?? this.primaryIconTheme,
      accentIconTheme: accentIconTheme ?? this.accentIconTheme,
      sliderTheme: sliderTheme ?? this.sliderTheme,
      tabBarTheme: tabBarTheme ?? this.tabBarTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeConfiguration &&
          runtimeType == other.runtimeType &&
          mainColors == other.mainColors &&
          buttonTheme == other.buttonTheme &&
          textTheme == other.textTheme &&
          primaryTextTheme == other.primaryTextTheme &&
          accentTextTheme == other.accentTextTheme &&
          inputDecorationTheme == other.inputDecorationTheme &&
          iconTheme == other.iconTheme &&
          primaryIconTheme == other.primaryIconTheme &&
          accentIconTheme == other.accentIconTheme &&
          sliderTheme == other.sliderTheme &&
          tabBarTheme == other.tabBarTheme &&
          chipTheme == other.chipTheme &&
          dialogTheme == other.dialogTheme;

  @override
  int get hashCode =>
      mainColors.hashCode ^
      buttonTheme.hashCode ^
      textTheme.hashCode ^
      primaryTextTheme.hashCode ^
      accentTextTheme.hashCode ^
      inputDecorationTheme.hashCode ^
      iconTheme.hashCode ^
      primaryIconTheme.hashCode ^
      accentIconTheme.hashCode ^
      sliderTheme.hashCode ^
      tabBarTheme.hashCode ^
      chipTheme.hashCode ^
      dialogTheme.hashCode;

  @override
  String toString() {
    return 'ThemeConfiguration{mainColors: $mainColors, buttonTheme: $buttonTheme, textTheme: $textTheme, primaryTextTheme: $primaryTextTheme, accentTextTheme: $accentTextTheme, inputDecorationTheme: $inputDecorationTheme, iconTheme: $iconTheme, primaryIconTheme: $primaryIconTheme, accentIconTheme: $accentIconTheme, sliderTheme: $sliderTheme, tabBarTheme: $tabBarTheme, chipTheme: $chipTheme, dialogTheme: $dialogTheme}';
  }
}
