// The claim 9.9 P1 makes on camera, checked: a const widget is not built
// again when its parent rebuilds; the same widget without const is.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_playground/main.dart';

void main() {
  testWidgets('9.9 P1 -- only the label without const is built again',
      (tester) async {
    final lines = <String>[];
    final old = debugPrint;
    debugPrint = (String? m, {int? wrapWidth}) => lines.add(m ?? '');

    await tester.pumpWidget(const MyApp());
    expect(lines, ['built: without const', 'built: with const']);

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Add one'));
      await tester.pump();
    }
    expect(find.text('3'), findsOneWidget);
    expect(lines.where((l) => l == 'built: without const').length, 4);
    debugPrint = old;
    expect(lines.where((l) => l == 'built: with const').length, 1);
  });
}
