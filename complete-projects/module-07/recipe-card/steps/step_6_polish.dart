// End of lesson 7.13 (Part 1) — "Shopping on pub.dev", second half.
//
// The finishing touches. Not one new widget in here: every line is something
// from 7.9 or 7.11, used once more on purpose.
//
//   - the palette moves to four named constants at the top of the file, so a
//     colour is written once and changed once
//   - the AppBar gets colours, because they are just named parameters
//   - the Scaffold moves into its own KitchenScreen class — Extract Widget,
//     from 7.8, now that there is enough on it to deserve a name
//   - an INGREDIENTS heading: a Text with letterSpacing, exactly like the
//     BREAKFAST line above it
//   - two hairline rules: a Container with height: 1 and a colour, using
//     only what 7.11 taught
//
// This is the card as it appears in the lesson 7.13 slides.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

// The palette lives up here so a colour is named once and changed once.
const kBackground = Color(0xFFF6F1EA);
const kTomato = Color(0xFFB3341F);
const kInk = Color(0xFF1F2933);
const kMuted = Color(0xFF8A8F98);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kitchen',
      home: const KitchenScreen(),
    );
  }
}

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kTomato,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Kitchen'),
      ),
      body: const Center(child: RecipeCard()),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      padding: const EdgeInsets.all(20),
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

          Text(
            'Shakshuka',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kInk,
            ),
          ),
          const SizedBox(height: 6),

          const Text(
            'BREAKFAST  \u00b7  20 MINUTES',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: kMuted,
            ),
          ),
          const SizedBox(height: 14),

          const Text(
            'Eggs poached in a spiced tomato sauce and served straight from '
            'the pan, with bread for scooping.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, height: 1.45, color: kMuted),
          ),
          const SizedBox(height: 18),

          // A hairline rule — a 1px Container, using only what 7.11 taught.
          Container(height: 1, color: const Color(0xFFE8E2DA)),
          const SizedBox(height: 14),

          const Text(
            'INGREDIENTS',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w700,
              color: kTomato,
            ),
          ),
          const SizedBox(height: 8),

          const IngredientLine(amount: '4', item: 'eggs'),
          const IngredientLine(amount: '1 tin', item: 'chopped tomatoes'),
          const IngredientLine(amount: '\u00bd', item: 'onion, sliced'),
          const SizedBox(height: 18),

          Container(height: 1, color: const Color(0xFFE8E2DA)),
          const SizedBox(height: 14),

          const Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/cook.jpg'),
              ),
              SizedBox(width: 10),
              Text(
                'by Fawzi Gharib',
                style: TextStyle(fontSize: 13, color: kMuted),
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
        style: const TextStyle(fontSize: 14, color: kInk),
      ),
    );
  }
}
