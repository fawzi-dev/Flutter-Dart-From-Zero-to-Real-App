// Lesson 9.4, step 3 of 3 -- "Count the Rolls, Call the Doubles".
//
// Finished, and identical to lib/main.dart below this header. One more
// field, a subtitle that reads it, and a widget that only exists when both
// dice match.

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
  int rollCount = 0;

  // Change the data inside setState, and build runs again.
  void rollDice() {
    setState(() {
      leftDie = Random().nextInt(6) + 1;
      rightDie = Random().nextInt(6) + 1;
      rollCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDoubles = leftDie == rightDie && rollCount > 0;

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
                  // The subtitle reports state now.
                  rollCount == 0 ? "Tap ROLL to play" : "Rolls: $rollCount",
                  style: TextStyle(color: kSubtitle),
                ),

                Spacer(),

                Row(
                  children: [
                    Expanded(
                      child: DieFace(value: leftDie, onTap: rollDice),
                    ),
                    Expanded(
                      child: DieFace(
                        value: rightDie,
                        onTap: rollDice,
                      ),
                    ),
                  ],
                ),

                // A widget that only exists in some states: a collection if.
                if (isDoubles)
                  Padding(
                    padding: EdgeInsets.only(top: kGapS),
                    child: Text(
                      "DOUBLES!",
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
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
  const DieFace({super.key, required this.value, required this.onTap});

  final int value;
  // The die doesn't know what rolling is. It calls what it was handed.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(kGapM),
        padding: EdgeInsets.all(kGapM),
        decoration: BoxDecoration(
          color: kDiePad,
          borderRadius: BorderRadius.circular(
            24,
          ),
        ),
        child: Image.asset('assets/dice-$value.png'), // assets/dice-2.png
      ),
    );
  }
}
