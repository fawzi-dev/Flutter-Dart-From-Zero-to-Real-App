import 'package:flutter/material.dart';

import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/weather_view.dart';
import '../widgets/weather_visuals.dart';

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
      return ErrorView(message: error!, onRetry: () => load(currentCity));
    }

    return RefreshIndicator(
      onRefresh: () => load(currentCity),
      child: WeatherView(weather: weather!),
    );
  }
}
