// A smoke test for the recipe card.
//
// You don't write tests until much later in the course — this exists so
// that anyone cloning the repo can prove the project still builds and renders
// without plugging in a phone.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_card/main.dart';

void main() {
  testWidgets('the card shows the dish, the meta line and three ingredients',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Shakshuka'), findsOneWidget);
    expect(find.text('BREAKFAST  ·  20 MINUTES'), findsOneWidget);

    // One widget class, used three times — the thing the module is teaching.
    expect(find.byType(IngredientLine), findsNWidgets(3));
    // One string now: amount and item interpolated together, exactly as
    // 7.7 types it.
    expect(find.text('4   eggs'), findsOneWidget);

    // The dish photo and the cook.
    expect(find.byType(Image), findsWidgets);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
