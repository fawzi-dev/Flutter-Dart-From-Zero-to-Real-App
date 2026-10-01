// End of lesson 7.9 — "Text & Styling".
//
// Same widgets as step 1. The only thing that changed is TextStyle: size,
// weight, colour, letterSpacing, and one long line taught to cut itself off
// with maxLines + ellipsis.
//
// Stand back from the screen. Your eye should be able to tell in one second
// which line is the title. That is hierarchy, and it is what styling is for.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Kitchen')),
        body: const Center(child: RecipeCard()),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Shakshuka',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2933),
          ),
        ),
        SizedBox(height: 6),

        // Spacing out uppercase text instantly makes it look intentional
        // rather than shouted. One property, a real design upgrade.
        Text(
          'BREAKFAST  ·  20 MINUTES',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8A8F98),
          ),
        ),
        SizedBox(height: 14),

        // The real exercise: a long line that gets cut with a … instead of
        // breaking the layout.
        SizedBox(
          width: 300,
          child: Text(
            'Eggs poached in a spiced tomato sauce and served straight from '
            'the pan, with bread for scooping.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Color(0xFF8A8F98)),
          ),
        ),
        SizedBox(height: 14),

        IngredientLine(amount: '4', item: 'eggs'),
        IngredientLine(amount: '1 tin', item: 'chopped tomatoes'),
        IngredientLine(amount: '½', item: 'onion, sliced'),
      ],
    );
  }
}

class IngredientLine extends StatelessWidget {
  const IngredientLine({super.key, required this.amount, required this.item});

  final String amount;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$amount   $item',
      style: const TextStyle(fontSize: 14, color: Color(0xFF1F2933)),
    );
  }
}
