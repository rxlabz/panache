export 'button_theme_help.dart';
export 'global_theme_help.dart';

class HelpData {
  final String title;
  final String content;
  final String link;

  const HelpData(this.title, this.content, [this.link = '']);
}
