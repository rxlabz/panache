import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'converters/theme_converter.dart';
import 'models.dart';
import 'services/persistence_service.dart';
import 'services/screenshot_service.dart';
import 'services/theme_service.dart';
import 'utils/uuid.dart';

typedef Future<Uint8List> ScreenShooter();

class ThemeModel extends Model {
  get dirPath => _service.dir.path;

  static ThemeModel of(BuildContext context) =>
      ScopedModel.of<ThemeModel>(context);

  //final CloudService _cloudService;

  final List<PanacheTheme> _themes;

  final Uuid _uuid = Uuid();

  ThemeService _service;

  PanacheTheme _currentTheme;

  ScreenShooter _screenShooter;

  final LocalStorage localData;

  ThemeData get theme => _service.theme;

  MaterialColor get primarySwatch => _currentTheme.primarySwatch;

  String get themeCode => themeToCode(theme);

  List<PanacheTheme> get themes => _themes;

  String get uuid => _uuid.generateV4();

  User _currentUser;
  User get user => _currentUser;

  Map<String, dynamic> get panelStates => localData.panelStates;

  double get scrollPosition => localData.scrollPosition;

  final ScreenshotService screenService;

  ThemeModel({
    @required ThemeService service,
    @required this.localData,
    //CloudService cloudService,
    this.screenService,
  })  : _service = service,
        //_cloudService = cloudService,
        _themes = localData.themes {
    _service.init(onChange);
    /*if (_cloudService != null)
      _cloudService.currentUser$?.listen((user) {
        _currentUser = user;
        notifyListeners();
      });*/
  }

  void newTheme({
    @required MaterialColor primarySwatch,
    Brightness brightness: Brightness.light,
  }) {
    assert(primarySwatch != null);
    final defaultThemeName = 'new-theme';
    _currentTheme = PanacheTheme(
      id: uuid,
      name: defaultThemeName,
      primarySwatch: primarySwatch,
      brightness: brightness,
    );

    _service.initTheme(primarySwatch: primarySwatch, brightness: brightness);

    _themes.add(_currentTheme);
    localData.updateThemeList(_themes);

    notifyListeners();
  }

  onChange() => notifyListeners();

  void updateTheme(ThemeData updatedTheme) {
    _service.updateTheme(updatedTheme);
    saveTheme();
    notifyListeners();
  }

  void exportTheme({String name: 'theme'}) {
    final code = themeToCode(theme);
    _service.exportTheme(filename: name, code: code);
  }

  void updateColor({String property, Color color}) {
    final args = <Symbol, dynamic>{};
    args[Symbol(property)] = color;
    final updatedTheme = Function.apply(theme.copyWith, null, args);
    updateTheme(updatedTheme);
  }

  void saveTheme() async {
    final filename = _currentTheme.id;

    final pngBytes = await _screenShooter();
    if (pngBytes == null || pngBytes.length == 0) return;

    print('ThemeModel.saveTheme... $screenService ${screenService == null}');
    if (screenService != null) screenService.capture(filename, pngBytes);

    _service.saveTheme(filename);
  }

  Future loadTheme(PanacheTheme theme) async {
    _currentTheme = theme;
    try {
      final result = await _service.loadTheme('${theme.id}.json');
      notifyListeners();
      return result;
    } catch (error) {
      print('ThemeModel.loadTheme... $error');
    }
    return null;
  }

  void initScreenshooter(ScreenShooter screenShooterKey) {
    _screenShooter = screenShooterKey;
    // FIXME ? Future.delayed(aSecond * 2, () => saveTheme());
  }

  deleteTheme(PanacheTheme theme) async {
    localData.deleteTheme(theme);
    _themes.remove(theme);
    /*final screenshot = File('${dir.path}/themes/${theme.id}.png');
    if (await screenshot.exists()) await screenshot.delete();

    final dataFile = File('${dir.path}/themes/${theme.id}.json');
    if (await dataFile.exists()) await dataFile.delete();*/

    notifyListeners();
  }

  String themeDataPath(PanacheTheme theme) =>
      '${_service.dir?.path ?? ''}/themes/${theme.id}.json';

  bool themeExists(PanacheTheme theme) {
    return _service.themeExists(themeDataPath(theme));
  }

  void saveEditorState(Map<String, bool> panelStates, double pixels) =>
      localData.saveEditorState(panelStates, pixels);

  void saveScrollPosition(double pixels) =>
      localData.saveScrollPosition(pixels);
}
