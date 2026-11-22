import 'package:bloc_abstraction_example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens settings from users screen', (tester) async {
    await app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Users'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
  });
}