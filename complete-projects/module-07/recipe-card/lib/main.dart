// Recipe Card — the project you build across lessons 7.8 to 7.13,
// with one last change in 7.15.
//
// This file is the FINISHED card: everything the build videos add, in one
// piece. If you want to see it part-way through, the /steps folder has a
// snapshot of the file at the end of each stage, and steps/README.md says
// which lesson each one belongs to.
//
// Deliberately narrow: every widget here is one that gets taught in Module 7.
// No state anywhere — this screen never changes, and that is the point. State
// arrives in Module 9.
//
// Your challenge (7.17, the About Me Card) is a DIFFERENT shape on purpose.
// Same skills, different screen — so you have to apply, not copy.

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

/// The page. Its build method is four lines, because everything it is made of
/// has a name. That is the lesson from 7.5, kept honest to the last video.
class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Colours set straight on the widgets, with named parameters. There is
      // an app-wide way to do this (ThemeData) and it is Module 13's subject.
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kTomato,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Kitchen'),
      ),
      // The standard opening for a screen, from 7.15 to the end of the
      // course: SafeArea outside, SingleChildScrollView inside, content within.
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Center(child: RecipeCard()),
        ),
      ),
    );
  }
}

/// The card itself: a white box with a photo, a heading, a few ingredient
/// lines, and the cook at the bottom.
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin pushes OTHER things away; padding pushes my own edges out.
      // Lesson 7.8, in one widget.
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
        // "Which side things line up on" - left, here. Named in 7.5 and taken
        // apart properly in Module 8.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ClipRRect rounds the photo's corners to match the card's.
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/shakshuka.jpg',
              height: 180,
              width: double.infinity,
              // cover fills the space and crops the spare. Photos want cover;
              // logos want contain; nothing sane wants fill.
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

          // Spaced-out uppercase is the cheapest way to make a line of text
          // look deliberate rather than shouted.
          const Text(
            'BREAKFAST  ·  20 MINUTES',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: kMuted,
            ),
          ),
          const SizedBox(height: 14),

          // maxLines + ellipsis: long text gets cut with a … instead of
          // wrecking the layout. Every real list in every real app does this.
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

          // ONE class, used three times, different data each time. Adding a
          // fourth ingredient costs one line — that is what a custom widget is
          // for, and it is the requirement in this module's challenge.
          const IngredientLine(amount: '4', item: 'eggs'),
          const IngredientLine(amount: '1 tin', item: 'chopped tomatoes'),
          const IngredientLine(amount: '½', item: 'onion, sliced'),
          const SizedBox(height: 18),

          Container(height: 1, color: const Color(0xFFE8E2DA)),
          const SizedBox(height: 14),

          Row(
            children: const [
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

/// One ingredient row: how much, then what.
///
/// Final fields, required named parameters, super.key — this is the Module 5
/// data-class recipe unchanged, with a build method bolted on.
class IngredientLine extends StatelessWidget {
  const IngredientLine({super.key, required this.amount, required this.item});

  final String amount;
  final String item;

  @override
  Widget build(BuildContext context) {
    // Exactly what gets typed in 7.8, plus the vertical padding from 7.11.
    // The grown-up version of this line is two Texts in a Row with Expanded
    // between them — that is Module 8, and an ingredient row can wait.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        '$amount   $item',
        style: const TextStyle(fontSize: 14, color: kInk),
      ),
    );
  }
}
