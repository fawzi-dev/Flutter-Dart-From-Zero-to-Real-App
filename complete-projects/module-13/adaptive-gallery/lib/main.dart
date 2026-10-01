// Adaptive Gallery — Module 13 project: RESPONSIVE LAYOUT & DARK MODE
// Built in the solution video. One screen that reflows from a phone list to a
// tablet grid, in a theme that follows the system's light/dark setting — with a
// toggle to override it.
//
// The whole point of the module:
//   1. One layout that fits every screen — LayoutBuilder + a breakpoint.
//   2. Colors that come from the theme (Theme.of(context)), never hardcoded — so
//      light and dark both look right for free.

import 'package:flutter/material.dart';

import 'gallery_screen.dart';

void main() {
  runApp(const GalleryApp());
}

class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  // themeMode lives ABOVE MaterialApp, because MaterialApp is what reads it.
  // Start on 'system' — respect the user's phone setting until they say otherwise.
  ThemeMode _themeMode = ThemeMode.system;

  void _cycleThemeMode() {
    setState(() {
      _themeMode = switch (_themeMode) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    // One seed color generates a whole matching palette — for BOTH brightnesses.
    const seed = Color(0xFF4F6DF5);

    return MaterialApp(
      title: 'Adaptive Gallery',
      debugShowCheckedModeBanner: false,
      // Two themes from the same seed. Flutter picks between them using themeMode.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: GalleryScreen(
        themeMode: _themeMode,
        onCycleTheme: _cycleThemeMode,
      ),
    );
  }
}
