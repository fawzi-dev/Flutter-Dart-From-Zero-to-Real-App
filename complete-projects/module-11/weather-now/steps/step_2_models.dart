// End of solution 11.7 P2 -- "Parsing an Array".
//
// The service now returns a WeatherData instead of printing, and the models
// in lib/models/weather.dart are finished -- including the loop that turns
// three parallel JSON arrays into a List<HourForecast>. Both files are final,
// so this snapshot imports them and holds only the debug screen.
//
// Still no weather UI. The button prints the parsed object, field by field:
//
//   Cairo: 25.3°, code 2, H 33 / L 22
//   8 hours. First: 21:00, 25.1°
//
// If those two lines print, the whole data layer is proven, and 11.7 P3 can
// build a screen on top of it without wondering where a bug lives.
//
//   flutter run -t steps/step_2_models.dart

import 'package:flutter/material.dart';

import 'package:weather_now/services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

Future<void> debugFetch(String city) async {
  final weather = await WeatherService.fetchForCity(city);
  debugPrint('${weather.cityName}: ${weather.temperature}°, '
      'code ${weather.weathercode}, '
      'H ${weather.high.round()} / L ${weather.low.round()}');

  final first = weather.hourly.first;
  debugPrint('${weather.hourly.length} hours. '
      'First: ${first.time.hour}:00, ${first.temperature}°');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Now',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Debug: the models')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => debugFetch('Cairo'),
            child: const Text('Try Cairo'),
          ),
        ),
      ),
    );
  }
}
