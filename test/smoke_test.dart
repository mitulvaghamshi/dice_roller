import 'package:dice_roller/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test', (tester) async {
    // Build our game and trigger a frame.
    await tester.pumpWidget(MainApp.inMemory());

    // Verify that the 'Play' button is shown.
    expect(find.text('Play'), findsOneWidget);

    // Verify that the 'Settings' button is shown.
    expect(find.text('Settings'), findsOneWidget);

    // Go to 'Settings'.
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Music'), findsOneWidget);

    // Go back to main menu.
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    // Tap 'Play'.
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();
    expect(find.text('Select level'), findsOneWidget);
  });
}
