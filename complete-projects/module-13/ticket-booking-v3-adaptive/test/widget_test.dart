// Tests for the adaptive ticket card. The reflow and the theme are both things
// you would otherwise only check by dragging a window, so they are worth
// pinning.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ticket_booking_v3/main.dart';
import 'package:ticket_booking_v3/widgets/ticket_parts.dart';

Future<void> pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('13.3 — narrow stacks, wide goes side by side', (tester) async {
    await pumpAt(tester, const Size(400, 1200));

    var poster = tester.getTopLeft(find.byType(EventPoster));
    var tiers = tester.getTopLeft(find.byType(TierRow));
    expect(tiers.dy, greaterThan(poster.dy), reason: 'tiers below the poster');
    expect(tiers.dx, closeTo(poster.dx, 1), reason: 'same column');

    await pumpAt(tester, const Size(1100, 900));

    poster = tester.getTopLeft(find.byType(EventPoster));
    tiers = tester.getTopLeft(find.byType(TierRow));
    expect(tiers.dx, greaterThan(poster.dx + 100),
        reason: 'tiers beside the poster');
  });

  testWidgets('13.3 — both layouts use the same widgets, once each',
      (tester) async {
    for (final size in [const Size(400, 1200), const Size(1100, 900)]) {
      await pumpAt(tester, size);
      expect(find.byType(EventPoster), findsOneWidget);
      expect(find.byType(EventHeading), findsOneWidget);
      expect(find.byType(SoldBar), findsOneWidget);
      expect(find.byType(TierRow), findsOneWidget);
      expect(find.byType(TotalRow), findsOneWidget);
    }
  });

  testWidgets('13.5 — the toggle cycles System, Light, Dark and back',
      (tester) async {
    await pumpAt(tester, const Size(500, 1200));

    expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
    await tester.tap(find.byIcon(Icons.brightness_auto));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.light_mode), findsOneWidget);

    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.brightness_auto), findsOneWidget);
  });

  testWidgets('13.4 — the title colour follows the palette, not a literal',
      (tester) async {
    await pumpAt(tester, const Size(500, 1200));

    Color titleColour() => tester
        .widget<Text>(find.textContaining('Night at the Citadel'))
        .style!
        .color!;

    await tester.tap(find.byIcon(Icons.brightness_auto));
    await tester.pumpAndSettle();
    final light = titleColour();

    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();
    final dark = titleColour();

    expect(light, isNot(dark));
  });

  testWidgets('9.3 still holds — the stepper recomputes the total',
      (tester) async {
    await pumpAt(tester, const Size(500, 1200));

    expect(find.text('120,000 IQD'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('180,000 IQD'), findsOneWidget);
  });
}
