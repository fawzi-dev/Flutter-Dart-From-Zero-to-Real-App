import 'package:flutter/material.dart';

// Pure functions that turn a weather code into what you SEE. No widgets, no
// state — just data in, style out. Keeping them in their own file means the
// look of the app is defined in one place.

IconData iconForCode(int code) {
  if (code <= 1) return Icons.wb_sunny;
  if (code <= 48) return Icons.cloud;
  return Icons.water_drop;
}

String labelForCode(int code) {
  if (code <= 1) return 'Clear';
  if (code <= 48) return 'Cloudy';
  return 'Rainy';
}

/// The background gradient is DERIVED from the weather — the sky literally
/// changes with the conditions. This is the same idea as the BMI scale:
/// mapping a value to something visual.
LinearGradient gradientForCode(int code) {
  if (code <= 1) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    );
  }
  if (code <= 48) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF546E7A), Color(0xFF90A4AE)],
    );
  }
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF37474F), Color(0xFF607D8B)],
  );
}
