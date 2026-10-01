// Smoke test: an empty submit should surface validation errors, not a crash.
import 'package:flutter_test/flutter_test.dart';

import 'package:signup_form/main.dart';

void main() {
  testWidgets('empty submit shows validation errors', (tester) async {
    await tester.pumpWidget(const SignUpApp());

    // Nothing filled in yet — no errors on screen.
    expect(find.text('Please enter your name'), findsNothing);

    // Tap "Create account" without touching any field.
    await tester.tap(find.text('Create account'));
    await tester.pump();

    // The form validated every field at once.
    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please pick your country'), findsOneWidget);
  });
}
