// Smoke test: the theme toggle cycles System -> Light -> Dark via its tooltip.
import 'package:flutter_test/flutter_test.dart';

import 'package:adaptive_gallery/main.dart';

void main() {
  testWidgets('theme toggle cycles the mode', (tester) async {
    await tester.pumpWidget(const GalleryApp());

    // Starts on System.
    expect(find.byTooltip('Theme: System'), findsOneWidget);

    // Tap it -> Light.
    await tester.tap(find.byTooltip('Theme: System'));
    await tester.pump();
    expect(find.byTooltip('Theme: Light'), findsOneWidget);

    // Again -> Dark.
    await tester.tap(find.byTooltip('Theme: Light'));
    await tester.pump();
    expect(find.byTooltip('Theme: Dark'), findsOneWidget);
  });
}
