// End of lesson 7.12 — "Images, Assets & pubspec.yaml".
//
// Three steps got us here: a folder called assets, a declaration in
// pubspec.yaml, and Image.asset with the exact path. Step two is the one that
// bites — assets: is indented exactly two spaces under flutter:, the list
// items get two more and a dash, and it is spaces, never tabs.
//
// The dish photo sits above the title with BoxFit.cover, which fills the space
// and crops the spare. The cook goes at the bottom in a CircleAvatar, which
// does the circular cropping for you — and wants AssetImage(...) rather than
// a plain path string.
//
// Note there is no SingleChildScrollView here yet — that arrives in 7.15,
// when we cause an overflow on purpose and learn the fix. The finished
// lib/main.dart has it; this snapshot is the card as it stands after 7.12.

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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        // "be only as tall as my children" — without it the white box
        // stretches to the full height of the screen. Named in 7.11;
        // the whole alignment family is Module 8.
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/shakshuka.jpg',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Shakshuka',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2933),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'BREAKFAST  ·  20 MINUTES',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8A8F98),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Eggs poached in a spiced tomato sauce and served straight from '
            'the pan, with bread for scooping.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Color(0xFF8A8F98),
            ),
          ),
          const SizedBox(height: 14),
          const IngredientLine(amount: '4', item: 'eggs'),
          const IngredientLine(amount: '1 tin', item: 'chopped tomatoes'),
          const IngredientLine(amount: '½', item: 'onion, sliced'),
          const SizedBox(height: 18),
          const Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/cook.jpg'),
              ),
              SizedBox(width: 10),
              Text(
                'by Fawzi Gharib',
                style: TextStyle(fontSize: 13, color: Color(0xFF8A8F98)),
              ),
            ],
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        '$amount   $item',
        style: const TextStyle(fontSize: 14, color: Color(0xFF1F2933)),
      ),
    );
  }
}
