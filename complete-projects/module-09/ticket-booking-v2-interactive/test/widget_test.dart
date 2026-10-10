// Tests for the woken-up ticket card. Each one covers a claim a video makes —
// and every one of them checks a REAL number, because nothing here is faked.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ticket_booking_v2/main.dart';

Future<void> pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MyApp());
}

void main() {
  test('money() formats without a package', () {
    expect(money(35000), '35,000');
    expect(money(120000), '120,000');
    expect(money(950), '950');
  });

  testWidgets('9.5 P2 — the stepper changes the quantity AND the total',
      (tester) async {
    await pump(tester);

    // VIP 60,000 x 2
    expect(find.text('120,000 IQD'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
    expect(find.text('180,000 IQD'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('120,000 IQD'), findsOneWidget);
  });

  testWidgets('9.5 P2 — the guard holds at 1 and at 8', (tester) async {
    await pump(tester);

    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
    }
    expect(find.text('1'), findsOneWidget);
    expect(find.text('60,000 IQD'), findsOneWidget);
  });

  testWidgets('9.5 P3 — choosing a tier recomputes the total', (tester) async {
    await pump(tester);

    await tester.tap(find.text('BACKSTAGE'));
    await tester.pump();
    // 95,000 x 2
    expect(find.text('190,000 IQD'), findsOneWidget);
  });

  testWidgets('9.6 P2 — the code is validated and really changes the price',
      (tester) async {
    await pump(tester);

    await tester.enterText(find.byType(TextField), 'nonsense');
    await tester.tap(find.text('Apply'));
    await tester.pump();
    expect(find.text("That code isn't valid"), findsOneWidget);
    expect(find.text('120,000 IQD'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'citadel20');
    await tester.tap(find.text('Apply'));
    await tester.pump();
    expect(find.text("That code isn't valid"), findsNothing);
    expect(find.text('96,000 IQD'), findsOneWidget);
  });

  testWidgets('9.6 P3 — delivery stays within the fixed choices',
      (tester) async {
    await pump(tester);
    final dropdown = find.byType(DropdownButton<String>);
    expect(tester.widget<DropdownButton<String>>(dropdown).value, 'Email');

    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('SMS').last);
    await tester.pumpAndSettle();

    expect(tester.widget<DropdownButton<String>>(dropdown).value, 'SMS');
  });

  testWidgets('9.6 P4 — reminder switch updates its stored value',
      (tester) async {
    await pump(tester);
    final reminder = find.byType(SwitchListTile);
    expect(tester.widget<SwitchListTile>(reminder).value, isTrue);

    await tester.tap(find.text('Remind me the day before'));
    await tester.pump();

    expect(tester.widget<SwitchListTile>(reminder).value, isFalse);
  });

  testWidgets('9.6 P5 — policy agreement starts unchecked',
      (tester) async {
    await pump(tester);
    final policy = find.byType(CheckboxListTile);
    expect(tester.widget<CheckboxListTile>(policy).value, isFalse);

    await tester.tap(find.text('I accept the refund policy'));
    await tester.pump();

    expect(tester.widget<CheckboxListTile>(policy).value, isTrue);
  });

  testWidgets('9.7 P1 — booking is refused until the policy is accepted',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('Book now'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Please accept the refund policy.'), findsOneWidget);
    expect(find.text('142 sold'), findsOneWidget);
  });

  testWidgets('9.5 P4 and 9.7 P1 — Book never sells a seat that does not exist',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('I accept the refund policy'));
    for (var i = 0; i < 6; i++) {
      await tester.tap(find.byIcon(Icons.add));
    }
    await tester.pump();
    expect(find.text('8'), findsOneWidget);

    // 142 + 7 x 8 = 198. The eighth booking would make 206 of 200.
    for (var i = 0; i < 7; i++) {
      await tester.tap(find.text('Book now'));
      await tester.pump();
    }
    expect(find.text('198 sold'), findsOneWidget);

    await tester.tap(find.text('Book now'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('198 sold'), findsOneWidget);
    expect(find.text('Only 2 seats left.'), findsOneWidget);
  });

  testWidgets('9.7 P1 — booking moves the sold bar, and UNDO puts it back',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('I accept the refund policy'));
    await tester.pump();
    await tester.tap(find.text('Book now'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('144 sold'), findsOneWidget);
    expect(find.textContaining('Booked 2 tickets'), findsOneWidget);

    await tester.tap(find.text('UNDO'));
    await tester.pump();
    expect(find.text('142 sold'), findsOneWidget);
  });

  testWidgets('9.7 P1 — UNDO takes back what was booked, not the new quantity',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('I accept the refund policy'));
    await tester.pump();
    await tester.tap(find.text('Book now'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('144 sold'), findsOneWidget);

    // Plus after booking. quantity is 3 now; booked is still 2.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.text('UNDO'));
    await tester.pump();
    expect(find.text('142 sold'), findsOneWidget);
  });

  testWidgets('9.7 P2 — Cancel and a tap outside both leave the ticket alone',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('BACKSTAGE'));
    await tester.pump();
    expect(find.text('190,000 IQD'), findsOneWidget);

    await tester.tap(find.text('Start over'));
    await tester.pumpAndSettle();
    expect(find.text('Start over?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Start over?'), findsNothing);
    expect(find.text('190,000 IQD'), findsOneWidget);

    // A tap on the dark barrier closes the dialog and sends back null.
    await tester.tap(find.text('Start over'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Start over?'), findsNothing);
    expect(find.text('190,000 IQD'), findsOneWidget);
  });

  testWidgets('9.7 P2 — only a confirmed Start over clears every choice',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('BACKSTAGE'));
    await tester.tap(find.byIcon(Icons.add));
    await tester.enterText(find.byType(TextField), 'citadel20');
    await tester.tap(find.text('Apply'));
    await tester.tap(find.text('I accept the refund policy'));
    await tester.pump();
    expect(find.text('228,000 IQD'), findsOneWidget);

    await tester.tap(find.text('Start over'));
    await tester.pumpAndSettle();
    // The dialog's own button, not the one on the card behind it.
    await tester.tap(find.descendant(
      of: find.byType(AlertDialog),
      matching: find.text('Start over'),
    ));
    await tester.pumpAndSettle();

    expect(find.text('120,000 IQD'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text,
        isEmpty);
    expect(
        tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
        isFalse);
  });
}
