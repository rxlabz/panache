import 'package:flutter_test/flutter_test.dart';
import 'package:panache/main.dart';
import 'package:panache_lib/panache_lib.dart';

void main() {
  testWidgets('Flutter gallery button example code displays',
      (WidgetTester tester) async {
    final themeModel =
        ThemeModel(service: ThemeService(themeExporter: exportTheme));

    await tester.pumpWidget(PanacheApp(themeModel: themeModel));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New theme'));
    await tester.pumpAndSettle();

    expect(find.text('New theme'), findsNothing);
    expect(find.text('Panache'), findsOneWidget);
    expect(find.text('blue'), findsOneWidget);
  });
}
