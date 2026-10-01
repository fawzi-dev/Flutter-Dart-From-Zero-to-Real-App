// Tests for Quote of the Day.
//
// The interesting ones use a FAKE server, so they prove the offline behaviour
// without needing a network — which is the whole point of the module.
// `MockClient` comes with the http package, and `http.runWithClient` makes
// every plain `http.get` inside it talk to that fake instead of the internet.
// The app code doesn't change at all to be testable.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:quote_of_the_day/models/quote.dart';
import 'package:quote_of_the_day/screens/quote_screen.dart';
import 'package:quote_of_the_day/services/quote_service.dart';
import 'package:quote_of_the_day/widgets/quote_view.dart';

const _body = '{"id": 619, "quote": "The best way out is always through.", '
    '"author": "Robert Frost"}';

MockClient serverReturning(String body, {int status = 200}) =>
    MockClient((_) async => http.Response(body, status));

MockClient serverThatFails() =>
    MockClient((_) async => throw const SocketishFailure());

/// Stands in for "the network is off". Any thrown object will do.
class SocketishFailure implements Exception {
  const SocketishFailure();
}

Future<void> launch(WidgetTester tester) =>
    tester.pumpWidget(const MaterialApp(home: QuoteScreen()));

void main() {
  test('11.4 P2 — fromJson maps the server\'s key onto our field name', () {
    final quote = Quote.fromJson(jsonDecode(_body) as Map<String, dynamic>);

    expect(quote.id, 619);
    expect(quote.text, 'The best way out is always through.');
    expect(quote.author, 'Robert Frost');
  });

  test('11.4 P3 — a non-200 throws instead of parsing nonsense', () async {
    await http.runWithClient(() async {
      await expectLater(QuoteService.fetchRandom(), throwsException);
    }, () => serverReturning('<html>server on fire</html>', status: 500));
  });

  testWidgets('11.5 P1 — loading, then data', (tester) async {
    await http.runWithClient(() async {
      await launch(tester);

      // First frame: the spinner, before anything has come back.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(QuoteView), findsOneWidget);
      expect(find.text('The best way out is always through.'), findsOneWidget);
      expect(find.text('ROBERT FROST'), findsOneWidget);
    }, () => serverReturning(_body));
  });

  testWidgets('11.5 P2 — the airplane-mode test: a friendly error and a Retry',
      (tester) async {
    await http.runWithClient(() async {
      await launch(tester);
      await tester.pumpAndSettle();

      // No crash, no blank screen, and nothing technical on display.
      expect(find.textContaining("Couldn't reach"), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.textContaining('SocketishFailure'), findsNothing);
    }, serverThatFails);
  });

  testWidgets('11.5 P2 — Retry calls the same method again', (tester) async {
    var calls = 0;
    final server = MockClient((_) async {
      calls++;
      // Fail the first time, succeed the second — exactly what a user does
      // after turning their wi-fi back on.
      if (calls == 1) throw const SocketishFailure();
      return http.Response(_body, 200);
    });

    await http.runWithClient(() async {
      await launch(tester);
      await tester.pumpAndSettle();
      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      expect(find.byType(QuoteView), findsOneWidget);
      expect(calls, 2);
    }, () => server);
  });
}
