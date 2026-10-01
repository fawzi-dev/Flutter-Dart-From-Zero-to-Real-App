// End of lesson 8.5 -- "The Overflow Error".
//
// The famous yellow and black stripes, caused on purpose and then fixed
// three different ways.

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
        title: const Text('Overflow'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kGapL),
        // Each card is 140 wide. Three of them plus the gaps do not fit on
        // a phone -- run it and read the yellow and black stripes.
        //
        // Fix 1: wrap each card in Expanded, and they share instead.
        // Fix 2: wrap this Row in a SingleChildScrollView, scrollDirection
        //        Axis.horizontal, and let the user slide it.
        // Fix 3: the long word. ColorCard now has maxLines and ellipsis.
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              ColorCard(title: 'One', color: kRed, width: 140),
              SizedBox(width: kGapS),
              ColorCard(title: 'Two', color: kBlue, width: 140),
              SizedBox(width: kGapS),
              ColorCard(
                title: 'Three is far too long',
                color: kGold,
                width: 140,
              ),
            ],
          ),
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
