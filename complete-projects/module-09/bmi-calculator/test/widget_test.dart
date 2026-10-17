// Each test checks a claim from one step of the BMI exercise, on the
// finished app -- with real numbers, because nothing here is faked.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator/main.dart';

Future<void> pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(440, 1400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const BmiApp());
}

void main() {
  test('Task 6 -- the boundaries land where the brief says', () {
    expect(categoryFor(18.4), 'Underweight');
    expect(categoryFor(18.5), 'Normal');
    expect(categoryFor(24.9), 'Normal');
    expect(categoryFor(25), 'Overweight');
    expect(categoryFor(30), 'Obese');
  });

  testWidgets('Task 3 -- weight never goes below 1', (tester) async {
    await pump(tester);
    for (var i = 0; i < 70; i++) {
      await tester.tap(find.byIcon(Icons.remove));
    }
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Tasks 4 and 5 -- 175 cm, 65 kg is 21.2, Normal, and back',
      (tester) async {
    await pump(tester);
    await tester.tap(find.text('Calculate BMI'));
    await tester.pumpAndSettle();
    expect(find.text('21.2'), findsOneWidget);
    expect(find.text('Normal'), findsOneWidget);
    expect(find.text('You'), findsOneWidget);

    await tester.tap(find.text('Re-calculate'));
    await tester.pumpAndSettle();
    expect(find.text('175'), findsOneWidget);
    expect(find.text('65'), findsOneWidget);
  });

  testWidgets('Task 2 -- the segmented button stores its choice',
      (tester) async {
    await pump(tester);
    await tester.tap(find.text('Female'));
    await tester.pump();
    final seg = tester.widget<SegmentedButton<Gender>>(
        find.byType(SegmentedButton<Gender>));
    expect(seg.selected, {Gender.female});
  });
}
