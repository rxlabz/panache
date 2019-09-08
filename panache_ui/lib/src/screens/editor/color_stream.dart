import 'dart:async';
import 'dart:ui';

class ColorStream {
  ColorStream(this._currentColor);

  StreamController<Color> _colorStreamer = new StreamController<Color>();

  Color _currentColor;

  Stream<Color> get color$ => _colorStreamer.stream;

  void selectColor(Color color) {
    _currentColor = color;
    _colorStreamer.add(_currentColor);
  }

  void setOpacity(double opacity) {
    _currentColor = _currentColor.withOpacity(opacity);
    _colorStreamer.add(_currentColor);
  }

  void dispose() {
    _colorStreamer.close();
  }
}
