// Smoke tests for the static ticket card.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ticket_booking/main.dart';

Future<void> pumpCard(WidgetTester tester, {Size size = const Size(440, 1600)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MyApp());
}

void main() {
  testWidgets('the card shows the poster, the tiers and the total',
      (tester) async {
    await pumpCard(tester);

    expect(find.byType(EventPoster), findsOneWidget);
    expect(find.text('FEW LEFT'), findsOneWidget);
    expect(find.byType(TierChip), findsNWidgets(3));
    expect(find.text('VIP'), findsOneWidget);
    expect(find.text('142 sold'), findsOneWidget);
    expect(find.text('200 seats'), findsOneWidget);
    expect(find.text('120,000 IQD'), findsOneWidget);
  });

  testWidgets('8.2 — exactly one tier is highlighted', (tester) async {
    await pumpCard(tester);

    final selected = tester
        .widgetList<TierChip>(find.byType(TierChip))
        .where((c) => c.selected);
    expect(selected.length, 1, reason: 'one accent, never two');
  });

  testWidgets('8.5 — the long title ellipsises instead of overflowing',
      (tester) async {
    await pumpCard(tester, size: const Size(320, 1600));

    final title = tester.widget<Text>(find.textContaining('Night at the Citadel'));
    expect(title.overflow, TextOverflow.ellipsis);
    expect(title.maxLines, 1);
  });
}
