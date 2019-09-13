import 'package:panache_core/panache_core.dart';
import 'package:url_launcher/url_launcher.dart';

class IOLinkService extends LinkService {
  @override
  void open(String url) async {
    print('WebLinkService.open... $url');
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
