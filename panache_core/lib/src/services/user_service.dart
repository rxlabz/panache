abstract class UserService {
  Future<bool> login();
  /*async {
    final result = await _cloudService.login();
    notifyListeners();
    return result;
  }*/

  void logout();
  /*async {
    await _cloudService.logout();
    notifyListeners();
  }*/

  Future<dynamic> exportTheme(String theme);
  /* async {
    bool authenticated = await _cloudService.authenticated;
    if (!authenticated) authenticated = await _cloudService.login();

    if (!authenticated) return false;
    final result = await _cloudService.save(themeToCode(_service.theme));
    print('ThemeModel.exportThemeToDrive... $result');
    return result.originalFilename ?? result.name;
  }*/

}
