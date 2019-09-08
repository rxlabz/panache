import 'dart:io';
import 'dart:typed_data';
import 'package:panache_core/panache_core.dart';

class MobileScreenshotService extends ScreenshotService {
  final Directory dir;

  MobileScreenshotService(this.dir);

  @override
  void capture(String filename, Uint8List pngBytes) async {
    final screenshotName = '$filename.png';
    final screenshotFile = File('${dir.path}/themes/$screenshotName');
    await screenshotFile.create(recursive: true);
    await screenshotFile.writeAsBytes(pngBytes);
    print('ThemeService.screenshot => $screenshotFile');
  }
}
