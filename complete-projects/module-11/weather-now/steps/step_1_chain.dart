// End of solution 11.7 P1 -- "The Chain".
//
// No weather on screen yet, on purpose: fetch first, pixels last. Two debug
// buttons, and everything the service learns goes to the console.
//
//   Cairo   -> "Cairo: 30.06263, 31.24967", then a wall of forecast JSON
//   asdfgh  -> Unhandled Exception: Instance of 'CityNotFoundException'
//
// That second line is the win. Before the named exception it was
// "type 'Null' is not a subtype of type 'List<dynamic>'" -- a crash that says
// nothing useful. Now it says exactly what happened, and 11.7 P3 will catch
// it by name.
//
// In the video the service lives in lib/services/weather_service.dart. It is
// flattened into this file because it isn't finished yet: it prints instead
// of returning anything. 11.7 P2 gives it a model to return.
//
//   flutter run -t steps/step_1_chain.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Now',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Debug: the chain')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => WeatherService.fetchForCity('Cairo'),
                child: const Text('Try Cairo'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => WeatherService.fetchForCity('asdfgh'),
                child: const Text('Try asdfgh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Thrown when the geocoding step finds no city for the search text.
class CityNotFoundException implements Exception {}

class WeatherService {
  static Future<void> fetchForCity(String city) async {
    // --- Step 1: geocode the name ---
    final geoUrl = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1&language=en&format=json',
    );
    final geoResponse = await http.get(geoUrl);
    if (geoResponse.statusCode != 200) {
      throw Exception('Geocoding failed (${geoResponse.statusCode})');
    }

    final geoData = jsonDecode(geoResponse.body) as Map<String, dynamic>;
    final results = geoData['results'] as List?;
    // No 'results' key at all means the city wasn't found.
    if (results == null || results.isEmpty) {
      throw CityNotFoundException();
    }

    final place = results.first as Map<String, dynamic>;
    final lat = place['latitude'];
    final lon = place['longitude'];
    debugPrint('${place['name']}: $lat, $lon');

    // --- Step 2: fetch the forecast for those coordinates ---
    final forecastUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon'
      '&current_weather=true'
      '&hourly=temperature_2m,weathercode'
      '&daily=temperature_2m_max,temperature_2m_min'
      '&timezone=auto&forecast_days=2',
    );
    final forecastResponse = await http.get(forecastUrl);
    if (forecastResponse.statusCode != 200) {
      throw Exception('Server returned ${forecastResponse.statusCode}');
    }

    // Prove it. 11.7 P2 turns this body into a WeatherData.
    debugPrint(forecastResponse.body);
  }
}
