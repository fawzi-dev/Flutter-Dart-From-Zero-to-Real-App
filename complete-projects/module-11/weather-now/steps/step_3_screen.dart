// End of solution 11.7 P3 -- "Two Catches and a Sky".
//
// The real screen, with the plumbing finished and the faces still plain:
//
//   - the trio from 11.5, plus the city we're showing
//   - load() with TWO catches: a missing city gets its own sentence
//   - a search bar that calls the same load()
//   - the sky: gradientForCode, derived from the weather, behind everything
//
// The error face is a single line of text and the data face is three. 11.7 P4
// replaces them with ErrorView (Retry) and WeatherView (the hourly strip).
//
// The planned bug in this video: put `catch (e)` ABOVE
// `on CityNotFoundException`. Dart tries catches top to bottom, the general
// one grabs everything, and "asdfgh" says "check your connection". The
// analyzer even warns you -- the specific catch below it is dead code.
//
//   flutter run -t steps/step_3_screen.dart

import 'package:flutter/material.dart';

import 'package:weather_now/models/weather.dart';
import 'package:weather_now/services/weather_service.dart';
import 'package:weather_now/widgets/weather_visuals.dart';

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

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final searchController = TextEditingController();

  // The universal trio.
  bool isLoading = true;
  String? error;
  WeatherData? weather;

  String currentCity = 'Cairo'; // remembered so pull-to-refresh reloads it

  @override
  void initState() {
    super.initState();
    load(currentCity);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> load(String city) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await WeatherService.fetchForCity(city);
      if (!mounted) return;
      setState(() {
        weather = result;
        currentCity = city;
        isLoading = false;
      });
    } on CityNotFoundException {
      // A specific catch for a specific problem — friendlier than a generic error.
      if (!mounted) return;
      setState(() {
        error = 'Couldn\'t find "$city". Try another city name.';
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = "Couldn't reach the weather service. Check your connection.";
        isLoading = false;
      });
    }
  }

  void submitSearch() {
    final city = searchController.text.trim();
    if (city.isEmpty) return;
    searchController.clear();
    FocusScope.of(context).unfocus(); // dismiss the keyboard
    load(city);
  }

  @override
  Widget build(BuildContext context) {
    // The sky is owned here so it stays behind the search bar in every state.
    final gradient = weather != null
        ? gradientForCode(weather!.weathercode)
        : gradientForCode(0);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Column(
            children: [
              buildSearchBar(),
              Expanded(child: buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => submitSearch(),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for a city…',
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: submitSearch,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (error != null) {
      return Center(
        child: Text(error!, style: const TextStyle(color: Colors.white)),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weather!.cityName,
          style: const TextStyle(color: Colors.white, fontSize: 28),
        ),
        Text(
          '${weather!.temperature.round()}°',
          style: const TextStyle(color: Colors.white, fontSize: 96),
        ),
        Text(
          labelForCode(weather!.weathercode),
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ],
    );
  }
}
