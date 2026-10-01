// End of lesson 8.1 -- "Row & Column: Two Widgets Everything Is Made Of".
//
// Three cards. That is the entire app, and it stays the entire app for the
// rest of the module -- only the widget holding them changes.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// The palette. Five colours, named once, used everywhere.
const kSurface = Color(0xFFF4F1EC);
const kInk = Color(0xFF141220);
const kRed = Color(0xFFD8584A);
const kBlue = Color(0xFF4A7FB5);
const kGold = Color(0xFFE0A33E);

// The spacing scale. Three numbers, and no raw ones anywhere else.
const kGapS = 8.0;
const kGapM = 16.0;
const kGapL = 24.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlaygroundScreen(),
    );
  }
}

class PlaygroundScreen extends StatelessWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(
        backgroundColor: kSurface,
        title: const Text('Row & Column'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kGapL),
        // Change this one word to Row and save. That is the lesson.
        // Then wrap 'Two' and 'Three' in a Column to see nesting.
        child: Column(
          children: const [
            ColorCard(title: 'One', color: kRed),
            SizedBox(height: kGapS),
            ColorCard(title: 'Two', color: kBlue),
            SizedBox(height: kGapS),
            ColorCard(title: 'Three', color: kGold),
          ],
        ),
      ),
    );
  }
}

// =========================================================== THE COMPONENT ==
// One widget, reused for the whole module. A coloured box with a word in the
// middle of it. Give it a title and a colour -- that is the whole thing.
//
// Nothing below this line changes from lesson to lesson.

class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
    required this.title,
    required this.color,
    this.width,
    this.height,
  });

  final String title;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      // The two factors keep the card hugging its word when nothing is
      // forcing a size on it, and centre the word when something is.
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
