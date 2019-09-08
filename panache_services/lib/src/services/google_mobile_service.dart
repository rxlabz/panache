import 'package:panache_core/panache_core.dart';

class MobileUserService implements UserService {
  CloudService _cloudService;

  @override
  Future<dynamic> exportTheme(String content) async {
    bool authenticated = await _cloudService.authenticated;
    if (!authenticated) authenticated = await _cloudService.login();

    if (!authenticated) return false;
    final result = await _cloudService.save(content);
    print('ThemeModel.exportThemeToDrive... $result');
    return result.originalFilename ?? result.name;
  }

  @override
  Future<bool> login() async {
    final result = await _cloudService.login();
    return result;
  }

  @override
  void logout() async {
    await _cloudService.logout();
  }
}
