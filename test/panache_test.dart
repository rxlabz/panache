import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:panache/main.dart';
import 'package:panache_lib/panache_lib.dart';

class MockLocalData extends Mock implements LocalData {}

void main() {
  testWidgets('Simple smoke test', (WidgetTester tester) async {
    final localData = MockLocalData();
    when(localData.themes).thenReturn(<PanacheTheme>[]);

    final themeModel = ThemeModel(
        localData: localData,
        service: ThemeService(
          themeExporter: exportTheme,
          dirProvider: () => Future.delayed(Duration.zero,
              () => Directory('/Users/rxlabz/dev/projects/_open/panache/tmp')),
        ));

    await tester.pumpWidget(PanacheApp(themeModel: themeModel));
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text('Panache'), findsOneWidget);
    expect(find.text('New theme'), findsOneWidget);
    expect(find.text('Customize'), findsOneWidget);
    expect(find.text('Brightness'), findsOneWidget);

    // FIXME expect(find.text('blue'), findsOneWidget);
  });
}
