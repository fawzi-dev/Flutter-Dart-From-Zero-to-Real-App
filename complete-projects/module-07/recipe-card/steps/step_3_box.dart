// End of lesson 7.11 — "Container, Padding & Margin".
//
// The words have not changed since step 2. What changed is that they now sit
// in a box: white, padding 20, corners rounded 16, and a soft shadow that
// lifts the card off the background.
//
// Rounded corners plus a soft shadow is roughly 90% of modern app design.
//
// Also here: each IngredientLine got vertical padding, so the rows stop
// touching each other.

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
        backgroundColor: const Color(0xFFF6F1EA),
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
    return Container(
      // padding = space inside my edge. margin = space outside my edge.
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      // colour goes INSIDE the decoration. Putting `color:` and `decoration:`
      // on the same Container is the error we triggered on purpose.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        // "be only as tall as my children" — without it the white box
        // stretches to the full height of the screen. Named in 7.11;
        // the whole alignment family is Module 8.
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Shakshuka',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F2933)),
          ),
          SizedBox(height: 6),
          Text(
            'BREAKFAST  ·  20 MINUTES',
            style: TextStyle(fontSize: 12, letterSpacing: 3, fontWeight: FontWeight.w600, color: Color(0xFF8A8F98)),
          ),
          SizedBox(height: 14),
          Text(
            'Eggs poached in a spiced tomato sauce and served straight from '
            'the pan, with bread for scooping.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, height: 1.45, color: Color(0xFF8A8F98)),
          ),
          SizedBox(height: 14),
          IngredientLine(amount: '4', item: 'eggs'),
          IngredientLine(amount: '1 tin', item: 'chopped tomatoes'),
          IngredientLine(amount: '½', item: 'onion, sliced'),
        ],
      ),
    );
  }
}

class IngredientLine extends StatelessWidget {
  const IngredientLine({super.key, required this.amount, required this.item});

  final String amount;
  final String item;

  @override
  Widget build(BuildContext context) {
    // When all you need is padding — no colour, no decoration — use the
    // Padding widget. Container is the Swiss Army knife; this is scissors.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text('$amount   $item', style: const TextStyle(fontSize: 14, color: Color(0xFF1F2933))),
    );
  }
}
