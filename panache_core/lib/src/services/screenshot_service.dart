import 'dart:typed_data';

abstract class ScreenshotService {
  void capture(String filename, Uint8List pngBytes);
}
