/// One hour of forecast — the shape of a single item in the hourly array.
class HourForecast {
  final DateTime time;
  final double temperature;
  final int weathercode;

  HourForecast({
    required this.time,
    required this.temperature,
    required this.weathercode,
  });
}

/// The whole weather payload: the current conditions, today's high/low, and a
/// short hourly forecast. The boundary: every JSON key lives in fromJson, so
/// the rest of the app only ever sees typed fields.
class WeatherData {
  final String cityName;
  final double temperature;
  final double windspeed;
  final int weathercode;
  final double high;
  final double low;
  final List<HourForecast> hourly;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.windspeed,
    required this.weathercode,
    required this.high,
    required this.low,
    required this.hourly,
  });

  // cityName comes from the geocoding step, not the forecast response,
  // so the service passes it in.
  factory WeatherData.fromJson(
    Map<String, dynamic> json, {
    required String cityName,
  }) {
    final current = json['current_weather'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;

    // NEW this module: the hourly data comes as parallel JSON ARRAYS.
    // times[i], temps[i] and codes[i] all describe the same hour, so one
    // loop reads all three and builds a List<HourForecast>.
    final times = hourly['time'] as List;
    final temps = hourly['temperature_2m'] as List;
    final codes = hourly['weathercode'] as List;

    // The arrays start at midnight. Skip to the current hour, take 8.
    final startHour = DateTime.parse(current['time'] as String).hour;
    final forecasts = <HourForecast>[];
    for (var i = startHour; i < times.length && i < startHour + 8; i++) {
      forecasts.add(
        HourForecast(
          time: DateTime.parse(times[i] as String),
          temperature: (temps[i] as num).toDouble(),
          weathercode: codes[i] as int,
        ),
      );
    }

    return WeatherData(
      cityName: cityName,
      temperature: (current['temperature'] as num).toDouble(),
      windspeed: (current['windspeed'] as num).toDouble(),
      weathercode: current['weathercode'] as int,
      // daily values are arrays too, one per day. [0] is today.
      high: (daily['temperature_2m_max'][0] as num).toDouble(),
      low: (daily['temperature_2m_min'][0] as num).toDouble(),
      hourly: forecasts,
    );
  }
}
