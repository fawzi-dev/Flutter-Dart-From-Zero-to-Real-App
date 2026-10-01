// End of lesson 7.13 (Part 1) — "Shopping on pub.dev", first half.
//
// One command, flutter pub add google_fonts, and two things happened: a line
// appeared in pubspec.yaml, and this import became legal. That is the whole
// transaction — somebody else wrote the font-loading code, and you rented it.
//
// Watch the const. The dish name was a const Text; GoogleFonts.playfairDisplay
// is a function call, so its result is not known at compile time and the const
// has to come off. That is the 7.10 rule biting for real rather than in an
// exercise.
//
// Try three faces before settling — playfairDisplay, lora, bitter all suit
// a recipe — and be able to say why you picked the one you picked.
//
// Note google_fonts downloads the font the first time the app runs, so the
// very first launch needs an internet connection.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

          // The only line that changed in this half of the lesson — and the
          // const in front of it had to go.
          Text(
            'Shakshuka',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2933),
            ),
          ),
          const SizedBox(height: 6),

          const Text(
            'BREAKFAST  \u00b7  20 MINUTES',
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
          const IngredientLine(amount: '\u00bd', item: 'onion, sliced'),
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
