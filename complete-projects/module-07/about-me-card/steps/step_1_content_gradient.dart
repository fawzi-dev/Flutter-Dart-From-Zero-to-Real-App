// End of lesson 7.18 (Part 1) — content, gradient, and the two wraps.
//
// This is meant to look bad. Five plain Texts, jammed at the top, black on
// indigo. Everything is on screen and the app runs, which at this stage is the
// only thing being asked of it. Ugly first; styling is the next video.
//
// The gradient is the same BoxDecoration from the recipe card with gradient:
// where color: used to be. One new property, not a new concept.
//
// SafeArea and SingleChildScrollView go on now rather than later, because
// retrofitting them is fiddly and rotating a nearly-empty screen to check
// costs nothing.
//
// Note what is NOT here: no Center, no mainAxisAlignment. Inside a scroll view
// the Column has infinite height to play with, so there is nothing to centre
// against and both would be dead code. The gap at the top is a SizedBox.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutMeScreen(),
    );
  }
}

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
          ),
        ),
        child: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 52),
                Text('Fawzi Gharib'),
                Text('FLUTTER DEVELOPER IN TRAINING'),
                Text('+20 100 000 0000'),
                Text('fawzi@example.com'),
                Text('github.com/fawzi'),
                SizedBox(height: 52),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
