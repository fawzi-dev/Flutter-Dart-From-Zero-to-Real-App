// Weather Now — Module 11 project
// Built in the four solution videos, 11.7 P1 to P4.
//
// Handles loading, error and data — and survives airplane mode. New this
// module: parsing a JSON ARRAY (the hourly forecast) into a List of models,
// and a weather-driven gradient sky.

import 'package:flutter/material.dart';

import 'screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather Now',
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
