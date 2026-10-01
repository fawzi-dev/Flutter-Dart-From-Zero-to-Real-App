import 'package:flutter/material.dart';

import '../models/weather.dart';
import 'weather_visuals.dart';

/// The data view: a full-screen gradient sky that changes with the weather,
/// the current conditions, today's high/low, and an hourly strip.
class WeatherView extends StatelessWidget {
  const WeatherView({super.key, required this.weather});

  final WeatherData weather;

  @override
  Widget build(BuildContext context) {
    // A ListView (not a Column) so RefreshIndicator has something to scroll.
    // The gradient background is owned by the screen.
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 8),
        Text(
          weather.cityName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Icon(iconForCode(weather.weathercode), size: 96, color: Colors.white),
        const SizedBox(height: 16),
        Text(
          '${weather.temperature.round()}°',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 96,
            fontWeight: FontWeight.w200,
            height: 1,
          ),
        ),
        Text(
          labelForCode(weather.weathercode),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        const SizedBox(height: 8),
        Text(
          'H:${weather.high.round()}°   L:${weather.low.round()}°   ·   Wind ${weather.windspeed.round()} km/h',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 40),

        // The hourly strip: a HORIZONTAL ListView.builder over the List we
        // parsed from the JSON array.
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weather.hourly.length,
            itemBuilder: (context, index) {
              final hour = weather.hourly[index];
              return HourCard(forecast: hour, isNow: index == 0);
            },
          ),
        ),
      ],
    );
  }
}

/// One card in the hourly strip. A reusable widget, used once per hour.
class HourCard extends StatelessWidget {
  const HourCard({super.key, required this.forecast, required this.isNow});

  final HourForecast forecast;
  final bool isNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isNow ? 0.30 : 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isNow
                ? 'Now'
                : '${forecast.time.hour.toString().padLeft(2, '0')}:00',
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          Icon(
            iconForCode(forecast.weathercode),
            color: Colors.white,
            size: 26,
          ),
          Text(
            '${forecast.temperature.round()}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shown when the fetch fails. Takes a message and a retry callback;
/// it doesn't know what fetching is.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // White, like everything else on the sky.
            const Icon(Icons.cloud_off, size: 64, color: Colors.white70),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
