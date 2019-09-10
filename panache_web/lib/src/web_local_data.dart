import 'dart:convert';
import 'package:panache_core/panache_core.dart';

import 'web_persistence_bridge.dart';

const _themeKey = 'themes';
const _panelsKey = 'panelsState';
const _positionKey = 'scrollPosition';

/// local persistence
class WebLocalData implements LocalStorage {
  /// synchronously loads local themes
  List<PanacheTheme> get themes => []
      /*_prefs
          .getStringList(_themeKey)
          ?.map<PanacheTheme>(_themeDataFromJson)
          ?.toList() ??
      <PanacheTheme>[]*/
      ;

  /// loads ( mobile layout)
  Map<String, dynamic> get panelStates {
    final persistedStates = jsGet(_panelsKey);

    if (persistedStates == null) return defaultPanelStates;
    return json.decode(persistedStates);
  }

  /// get the last scroll position ( mobile layout)
  double get scrollPosition => double.parse(jsGet(_positionKey) ?? '0');

  /// clear local themes list
  PanacheTheme _themeDataFromJson(String data) => PanacheTheme.fromJson(data);

  // FIXME
  /// initialisation du stockage
  init() async {} /* => print('WebLocalData.init()')*/

  /// save the new local themes list
  void updateThemeList(List<PanacheTheme> themes) {
    /* FIXME
      _prefs.setStringList(
        _themeKey,
        themes.map((theme) => theme.toJson()).toList(growable: false),
      );*/
  }

  /// remove the local theme list
  void clear() => print('WebLocalData.clear()') /*_prefs.remove(_themeKey)*/;

  /// delete a local theme
  void deleteTheme(PanacheTheme theme) {
    updateThemeList(themes.where((t) => t.id != theme.id).toList());
  }

  /// saves panels states and editor scrollposition ( mobile layout )
  void saveEditorState(Map<String, bool> panelStates, double pixels) {
    jsSet(_panelsKey, json.encode(panelStates));
    saveScrollPosition(pixels);
  }

  /// saves editor scrollposition ( mobile layout )
  void saveScrollPosition(double pixels) {
    jsSet(_positionKey, pixels);
  }
}

void clearPersisted() {
  jsSet(_positionKey, null);
  jsSet(_panelsKey, null);
}
