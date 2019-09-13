import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:panache/export/drive_service.dart';
import 'package:panache/main.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/panache_ui.dart';
import 'package:panache_services/panache_services.dart';

class MockLocalData extends Mock implements LocalData {}

class MockDriveService extends Mock implements DriveService {}

void main() {
  group('panache app smoke...', () {
    /*final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();*/

    final mockDriveService = MockDriveService();
    when(mockDriveService.currentUser$)
        .thenAnswer((_) => Stream.fromIterable([]));

    /*setUp(() {
      WidgetsBinding.instance.renderView.configuration =
          TestViewConfiguration(size: const Size(1024.0, 768.0));
    });*/

    testWidgets('Simple smoke test', (WidgetTester tester) async {
      //await binding.setSurfaceSize(Size(1024, 768));

      final localData = MockLocalData();
      when(localData.themes).thenReturn(<PanacheTheme>[]);

      final themeModel = ThemeModel(
        localData: localData,
        service: IOThemeService(
          themeExporter: exportTheme,
          dirProvider: () => Future.delayed(Duration.zero,
              () => Directory('/Users/rxlabz/dev/projects/_open/panache/tmp')),
        ),
        /*cloudService: mockDriveService,*/
      );

      await tester.pumpWidget(SizedBox(
          width: 1024, height: 768, child: PanacheApp(themeModel: themeModel)));
      await tester.pumpAndSettle();

      expect(find.text('Panache'), findsOneWidget);
      expect(find.text('New theme'), findsOneWidget);
      expect(find.text('Customize'), findsOneWidget);

      expect(find.byType(ColorSelector), findsOneWidget);
      expect(find.text('Primary swatch\nblue'), findsOneWidget);
      expect(find.byType(BrightnessSelector), findsOneWidget);
      expect(find.text('Brightness'), findsOneWidget);

      await tester.tap(find.text('Customize'));

      await tester.pumpAndSettle();

      expect(find.text('Panache'), findsNothing);
      expect(find.text('Colors'), findsOneWidget);
    });
  });
}
