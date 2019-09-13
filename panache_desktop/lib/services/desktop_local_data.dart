import 'dart:convert';

import 'package:panache_core/panache_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'themes';
const _panelsKey = 'panelsState';
const _positionKey = 'scrollPosition';

/// local persistence
class DesktopLocalStorage implements LocalStorage {
  // persistence destination
  SharedPreferences _prefs;

  /// synchronously loads local themes
  List<PanacheTheme> get themes =>
      _prefs
          .getStringList(_themeKey)
          ?.map<PanacheTheme>(_themeDataFromJson)
          ?.toList() ??
      <PanacheTheme>[];

  /// loads ( mobile layout)
  Map<String, dynamic> get panelStates {
    final states = _prefs.getString(_panelsKey);

    if (states == null) return defaultPanelStates;
    return json.decode(states);
  }

  /// get the last scroll position ( mobile layout)
  double get scrollPosition => _prefs.getDouble(_positionKey);

  /// clear local themes list
  PanacheTheme _themeDataFromJson(String data) => PanacheTheme.fromJson(data);

  /// initialisation du stockage
  init() async => _prefs = await SharedPreferences.getInstance();

  /// save the new local themes list
  void updateThemeList(List<PanacheTheme> themes) {
    print('DesktopLocalStorage.updateThemeList... $themes');
    _prefs.setStringList(
      _themeKey,
      themes.map((theme) => theme.toJson()).toList(growable: false),
    );
  }

  /// remove the local theme list
  void clear() => _prefs.remove(_themeKey);

  /// delete a local theme
  void deleteTheme(PanacheTheme theme) async {
    /*
    FIXME
    final screenshot = File('${dir.path}/themes/${theme.id}.png');
    if (await screenshot.exists()) await screenshot.delete();

    final dataFile = File('${dir.path}/themes/${theme.id}.json');
    if (await dataFile.exists()) await dataFile.delete();*/

    updateThemeList(themes.where((t) => t.id != theme.id).toList());
  }

  /// saves panels states and editor scrollposition ( mobile layout )
  void saveEditorState(Map<String, bool> panelStates, double pixels) {
    _prefs.setString(_panelsKey, json.encode(panelStates));
    saveScrollPosition(pixels);
  }

  /// saves editor scrollposition ( mobile layout )
  void saveScrollPosition(double pixels) {
    _prefs.setDouble(_positionKey, pixels);
  }
}
