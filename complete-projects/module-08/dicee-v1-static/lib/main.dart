// Dicee — Module 8 project (STATIC layout only)
// Built in solution video 8.10. The interactive version lives in
// complete-projects/module-09/dicee-v2-interactive/ — diff them; the diff IS lesson 9.4.
//
// Rubric point: the dice share the width equally on ANY screen size,
// because there is not one hardcoded width in this file. Expanded does it.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// The palette. The felt of the table, top to bottom, and the whites on it.
const kFeltDark = Color(0xFF0D47A1);
const kFeltLight = Color(0xFF1E88E5);
const kSubtitle = Colors.white70;
const kDiePad = Color(0x1FFFFFFF);
const kButtonFill = Colors.white24;
const kButtonText = Colors.white38;
// The spacing scale. Four numbers, reused everywhere.
const kGapS = 8.0;
const kGapM = 16.0;
const kGapL = 24.0;
const kGapXL = 40.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceePage(),
    );
  }
}

class DiceePage extends StatelessWidget {
  const DiceePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // The felt of the table: a gradient, drawn by a BoxDecoration.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kFeltDark, kFeltLight],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'DICEE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap ROLL to play',
                style: TextStyle(color: kSubtitle),
              ),
              const Spacer(),

              // THE layout lesson: two Expanded children split the row
              // evenly. Resize the window — they stay equal, because no
              // width is written anywhere in this file.
              const Row(
                children: [
                  Expanded(child: DieFace(value: 1)),
                  Expanded(child: DieFace(value: 2)),
                ],
              ),

              const Spacer(),
              // The ROLL button -- a styled Container, like the ticket
              // card's Book button. It only LOOKS pressable, and it is dimmed
              // on purpose: nothing can happen yet. In Module 9 it becomes a
              // real ElevatedButton and wakes up.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: kButtonFill,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.casino, color: kButtonText),
                    SizedBox(width: kGapS),
                    Text(
                      'ROLL',
                      style: TextStyle(
                        color: kButtonText,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kGapXL),
            ],
          ),
        ),
      ),
    );
  }
}

/// One die: the image on a soft translucent pad.
/// Extracted so the Row above reads as "two dice, side by side".
class DieFace extends StatelessWidget {
  const DieFace({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kGapM),
      padding: const EdgeInsets.all(kGapM),
      decoration: BoxDecoration(
        color: kDiePad,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Image.asset('assets/dice-$value.png'),
    );
  }
}
