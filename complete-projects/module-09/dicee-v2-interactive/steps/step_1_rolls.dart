// Lesson 9.4, step 1 of 3 -- "It Rolls".
//
// The counter's fix, in a real app. DiceePage is Stateful, the two dice are
// fields of the State, and ROLL is a real button that changes them inside
// setState. The layout from Module 8 is untouched.

import 'dart:math';

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

class DiceePage extends StatefulWidget {
  const DiceePage({super.key});

  @override
  State<DiceePage> createState() => _DiceePageState();
}

class _DiceePageState extends State<DiceePage> {
  // The data that changes lives in the State.
  int leftDie = 1;
  int rightDie = 1;

  // Change the data inside setState, and build runs again.
  void rollDice() {
    setState(() {
      leftDie = Random().nextInt(6) + 1;
      rightDie = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kFeltDark,
              kFeltLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  "DICE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "Tap ROLL to play",
                  style: TextStyle(color: kSubtitle),
                ),

                Spacer(),

                Row(
                  children: [
                    Expanded(
                      child: DieFace(value: leftDie),
                    ),
                    Expanded(
                      child: DieFace(
                        value: rightDie,
                      ),
                    ),
                  ],
                ),

                Spacer(),

                // The Container that only LOOKED like a button becomes a
                // real one. rollDice, not rollDice(): hand it over.
                ElevatedButton.icon(
                  onPressed: rollDice,
                  icon: Icon(Icons.casino),
                  label: Text("ROLL"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: kFeltDark,
                    padding: EdgeInsets.symmetric(horizontal: 44, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DieFace extends StatelessWidget {
  const DieFace({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kGapM),
      padding: EdgeInsets.all(kGapM),
      decoration: BoxDecoration(
        color: kDiePad,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Image.asset('assets/dice-$value.png'), // assets/dice-2.png
    );
  }
}
