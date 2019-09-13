// ignore: uri_does_not_exist
import 'dart:html' as html;

import 'package:panache_core/panache_core.dart';

class WebLinkService extends LinkService {
  @override
  void open(String url) {
    print('WebLinkService.open... $url');
    html.window.open(url, '_blank');
  }
}
