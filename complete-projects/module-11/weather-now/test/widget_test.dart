// Tests for Weather Now.
//
// A fake server answers both halves of the chain, so these run offline and
// prove the three things the rubric grades: the chain, the named exception,
// and the hourly array. `http.runWithClient` points every `http.get` inside
// it at the fake; the app code doesn't change to be testable.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:weather_now/screens/weather_screen.dart';
import 'package:weather_now/services/weather_service.dart';
import 'package:weather_now/widgets/weather_view.dart';

const _cairo = '{"results": [{"name": "Cairo", "latitude": 30.06, '
    '"longitude": 31.25}]}';

const _nowhere = '{"generationtime_ms": 0.2}';

// 48 hours of parallel arrays, starting at midnight, like the real API.
final _hours = List.generate(48, (i) => i);
final _forecast = '{'
    '"current_weather": {"time": "2026-09-28T21:45", "temperature": 25.3, '
    '"windspeed": 9.8, "weathercode": 2},'
    '"daily": {"temperature_2m_max": [33.1, 32.0], '
    '"temperature_2m_min": [22.4, 21.9]},'
    '"hourly": {'
    '"time": [${_hours.map((i) => '"2026-09-${28 + i ~/ 24}T${(i % 24).toString().padLeft(2, '0')}:00"').join(',')}],'
    '"temperature_2m": [${_hours.map((i) => '${20 + i % 10}').join(',')}],'
    '"weathercode": [${_hours.map((i) => i.isEven ? '0' : '61').join(',')}]'
    '}}';

MockClient server({bool cityExists = true}) => MockClient((request) async {
      if (request.url.host.startsWith('geocoding')) {
        return http.Response(cityExists ? _cairo : _nowhere, 200);
      }
      return http.Response(_forecast, 200);
    });

MockClient offline() =>
    MockClient((_) async => throw http.ClientException('no network'));

void main() {
  test('11.7 P1 — the chain: a name in, a forecast out', () async {
    await http.runWithClient(() async {
      final weather = await WeatherService.fetchForCity('Cairo');
      expect(weather.cityName, 'Cairo');
      expect(weather.temperature, 25.3);
      expect(weather.high, 33.1);
    }, server);
  });

  test('11.7 P1 — no results is a CityNotFoundException, by name', () async {
    await http.runWithClient(() async {
      await expectLater(
        WeatherService.fetchForCity('asdfgh'),
        throwsA(isA<CityNotFoundException>()),
      );
    }, () => server(cityExists: false));
  });

  test('11.7 P2 — the hourly array: 8 hours from NOW, even at 9pm', () async {
    await http.runWithClient(() async {
      final weather = await WeatherService.fetchForCity('Cairo');
      expect(weather.hourly.length, 8);
      expect(weather.hourly.first.time.hour, 21);
      // The last two come from tomorrow — that's why forecast_days=2.
      expect(weather.hourly.last.time.day, 29);
      expect(weather.hourly.last.time.hour, 4);
    }, server);
  });

  testWidgets('11.7 P3 — a missing city gets its own sentence',
      (tester) async {
    await http.runWithClient(() async {
      await tester.pumpWidget(const MaterialApp(home: WeatherScreen()));
      await tester.pumpAndSettle();
      expect(find.textContaining("Couldn't find"), findsOneWidget);
      expect(find.textContaining('connection'), findsNothing);
    }, () => server(cityExists: false));
  });

  testWidgets('11.7 P4 — the airplane-mode test', (tester) async {
    await http.runWithClient(() async {
      await tester.pumpWidget(const MaterialApp(home: WeatherScreen()));
      await tester.pumpAndSettle();
      expect(find.textContaining("Couldn't reach"), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    }, offline);
  });

  testWidgets('11.7 P4 — data: the hourly strip, "Now" first', (tester) async {
    await http.runWithClient(() async {
      await tester.pumpWidget(const MaterialApp(home: WeatherScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(WeatherView), findsOneWidget);
      expect(find.text('Cairo'), findsOneWidget);
      expect(find.text('Now'), findsOneWidget);
    }, server);
  });
}
