import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

/// Thrown when the geocoding step finds no city for the search text.
/// A named exception lets the screen show a specific, friendly message.
class CityNotFoundException implements Exception {}

class WeatherService {
  // Fetching a city's weather takes TWO chained calls:
  //   1. geocoding: turn a city NAME into latitude/longitude
  //   2. forecast:  turn those coordinates into weather
  // This is a common real-world pattern — one request's answer feeds the next.
  static Future<WeatherData> fetchForCity(String city) async {
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
    final resolvedName = place['name'] as String;

    // --- Step 2: fetch the forecast for those coordinates ---
    final forecastUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon'
      '&current_weather=true'
      '&hourly=temperature_2m,weathercode'
      '&daily=temperature_2m_max,temperature_2m_min'
      // Two days, not one: at 10pm, "the next 8 hours" runs into tomorrow.
      '&timezone=auto&forecast_days=2',
    );
    final forecastResponse = await http.get(forecastUrl);
    if (forecastResponse.statusCode != 200) {
      throw Exception('Server returned ${forecastResponse.statusCode}');
    }

    return WeatherData.fromJson(
      jsonDecode(forecastResponse.body) as Map<String, dynamic>,
      cityName: resolvedName,
    );
  }
}
