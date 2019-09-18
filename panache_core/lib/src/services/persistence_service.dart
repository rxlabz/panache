import '../data.dart';

const Map<String, bool> defaultPanelStates = const {
  'colorPanelExpanded': false,
  'buttonThemePanelExpanded': false,
  'iconThemePanelExpanded': false,
  'sliderThemePanelExpanded': false,
  'tabBarThemePanelExpanded': false,
  'chipThemePanelExpanded': false,
  'dialogThemePanelExpanded': false,
  'textPanelExpanded': false,
  'primaryTextPanelExpanded': false,
  'accentTextPanelExpanded': false,
  'inputsPanelExpanded': false,
};

abstract class LocalStorage {
  List<PanacheTheme> get themes;

  Map<String, dynamic> get panelStates;

  double get scrollPosition;

  void updateThemeList(List<PanacheTheme> themes);

  void saveEditorState(Map<String, bool> panelStates, double pixels);

  void saveScrollPosition(double pixels);

  void deleteTheme(PanacheTheme theme);

  void clear();
}

abstract class PanacheStorage {
  Stream<List<PanacheTheme>> get themeList$;

  Map<String, dynamic> get panelStates;

  /// last scroll position
  double get scrollPosition;

  void updateThemeList(List<PanacheTheme> themes);

  void saveEditorState(Map<String, bool> panelStates, double scrollPosition);

  void saveScrollPosition(double scrollPosition);

  void deleteTheme(PanacheTheme theme);

  void clear();
}

/*
PlatformStorage{

  load

}*/
