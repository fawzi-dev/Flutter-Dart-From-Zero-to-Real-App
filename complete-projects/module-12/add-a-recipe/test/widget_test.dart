// Tests for Add a Recipe. Each one covers a claim a video makes.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:add_a_recipe/main.dart';
import 'package:add_a_recipe/screens/recipe_done_screen.dart';

Future<void> pumpForm(WidgetTester tester) async {
  tester.view.physicalSize = const Size(500, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MyApp());
}

Future<void> fillValid(WidgetTester tester,
    {String prep = '15', String total = '40'}) async {
  final fields = find.byType(TextFormField);
  await tester.enterText(fields.at(0), 'Shakshuka');
  await tester.enterText(fields.at(1), prep);
  await tester.enterText(fields.at(2), total);
  await tester.enterText(fields.at(3), '4');

  await tester.tap(find.byType(DropdownButtonFormField<String>));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Easy').last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('12.2 — an empty form starts silent, then complains once',
      (tester) async {
    await pumpForm(tester);

    // Nothing is shouting before the user has done anything.
    expect(find.text('Please enter a dish name'), findsNothing);

    await tester.tap(find.text('Save recipe'));
    await tester.pumpAndSettle();

    // ONE validate() call lit up every failing field at once.
    expect(find.text('Please enter a dish name'), findsOneWidget);
    expect(find.text('Minutes, as a number'), findsWidgets);
    expect(find.text('Please pick a difficulty'), findsOneWidget);
  });

  testWidgets('12.3 — total < prep: ONLY the total field complains',
      (tester) async {
    await pumpForm(tester);
    await fillValid(tester, prep: '20', total: '10');

    await tester.tap(find.text('Save recipe'));
    await tester.pumpAndSettle();

    expect(find.text("Total can't be less than prep time"), findsOneWidget);
    // Prep is perfectly fine on its own — it is the total that is wrong.
    expect(find.text('Minutes, as a number'), findsNothing);
  });

  testWidgets('12.3 — the number guards catch nonsense and silly values',
      (tester) async {
    await pumpForm(tester);
    await fillValid(tester);
    await tester.enterText(find.byType(TextFormField).at(1), 'abc');
    await tester.tap(find.text('Save recipe'));
    await tester.pumpAndSettle();
    expect(find.text('Minutes, as a number'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(1), '9000');
    await tester.pumpAndSettle();
    expect(find.text('Somewhere between 1 and 600'), findsOneWidget);
  });

  testWidgets('12.4 — the checkbox trap: valid form, unticked box, refused',
      (tester) async {
    await pumpForm(tester);
    await fillValid(tester);

    await tester.tap(find.text('Save recipe'));
    await tester.pumpAndSettle();

    // validate() returned true. The box is what stopped it.
    expect(find.text('Please confirm you have cooked this.'), findsOneWidget);
    expect(find.byType(RecipeDoneScreen), findsNothing);
  });

  testWidgets('12.5 — a good submit lands on the done screen with the values',
      (tester) async {
    await pumpForm(tester);
    await fillValid(tester);
    await tester.tap(find.text('I have actually cooked this'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save recipe'));
    await tester.pumpAndSettle();

    expect(find.byType(RecipeDoneScreen), findsOneWidget);
    expect(find.text('Shakshuka'), findsOneWidget);
    expect(find.text('15 min'), findsOneWidget);   // prep
    expect(find.text('25 min'), findsOneWidget);   // cook, derived
    expect(find.text('40 min'), findsOneWidget);   // total
  });
}
