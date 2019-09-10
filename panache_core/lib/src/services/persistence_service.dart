import '../models.dart';

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
