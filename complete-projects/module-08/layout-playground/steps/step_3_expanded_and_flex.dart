// End of lesson 8.3 -- "Expanded, Flexible, and flex".
//
// The only step with more than one row on screen, and on purpose: the point
// of Expanded is the difference between the first row and the second, and
// they have to be visible at the same time for that to land.

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
        title: const Text('Expanded & flex'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kGapL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // 1. The problem. The cards are as wide as their words, and the
            //    rest of the row is wasted space.
            Text('without Expanded'),
            SizedBox(height: kGapS),
            Row(
              children: [
                ColorCard(title: 'One', color: kRed),
                SizedBox(width: kGapS),
                ColorCard(title: 'Two', color: kBlue),
                SizedBox(width: kGapS),
                ColorCard(title: 'Three', color: kGold),
              ],
            ),

            SizedBox(height: kGapL),

            // 2. The fix. Expanded means "take what is left". Three of them
            //    share it equally.
            Text('three Expanded, equal share'),
            SizedBox(height: kGapS),
            Row(
              children: [
                Expanded(child: ColorCard(title: 'One', color: kRed)),
                SizedBox(width: kGapS),
                Expanded(child: ColorCard(title: 'Two', color: kBlue)),
                SizedBox(width: kGapS),
                Expanded(child: ColorCard(title: 'Three', color: kGold)),
              ],
            ),

            SizedBox(height: kGapL),

            // 3. flex is the share, not the width. 2 + 1 + 1 is four parts:
            //    the red card takes two of them.
            Text('flex: 2, flex: 1, flex: 1'),
            SizedBox(height: kGapS),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ColorCard(title: 'One', color: kRed),
                ),
                SizedBox(width: kGapS),
                Expanded(child: ColorCard(title: 'Two', color: kBlue)),
                SizedBox(width: kGapS),
                Expanded(child: ColorCard(title: 'Three', color: kGold)),
              ],
            ),
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
