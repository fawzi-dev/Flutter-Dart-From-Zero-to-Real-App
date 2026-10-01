// Dicee — Module 9 project (INTERACTIVE)
// Built in build-along video 9.4. Diff this against
// complete-projects/module-08/dicee-v1-static/ — the diff IS the lesson:
// a StatefulWidget, state fields, interpolated asset paths, one setState,
// and callbacks. The layout below is untouched from Module 8.

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

// CHANGE 1: Stateless -> Stateful, because this screen now changes.
class DiceePage extends StatefulWidget {
  const DiceePage({super.key});

  @override
  State<DiceePage> createState() => _DiceePageState();
}

class _DiceePageState extends State<DiceePage> {
  // CHANGE 2: the data that changes now lives in the State.
  int leftDie = 1;
  int rightDie = 1;
  int rollCount = 0;

  // CHANGE 3: change the data inside setState, and build runs again.
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
                // CHANGE 4: the subtitle now reports state.
                rollCount == 0 ? 'Tap ROLL to play' : 'Rolls: $rollCount',
                style: TextStyle(color: kSubtitle),
              ),
              const Spacer(),

              // The layout is IDENTICAL to Module 8. Only the values and the
              // callbacks are new.
              Row(
                children: [
                  Expanded(child: DieFace(value: leftDie, onTap: rollDice)),
                  Expanded(child: DieFace(value: rightDie, onTap: rollDice)),
                ],
              ),

              // CHANGE 5: a widget that only exists in some states.
              if (isDoubles)
                const Padding(
                  padding: EdgeInsets.only(top: kGapS),
                  child: Text(
                    'DOUBLES!',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),

              const Spacer(),
              ElevatedButton.icon(
                // CHANGE 6: the Container that only LOOKED like a button
                // becomes a real one. Note: rollDice, not rollDice() — pass
                // the recipe, don't cook it (lesson 3.6).
                onPressed: rollDice,
                icon: const Icon(Icons.casino),
                label: const Text('ROLL'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: kFeltDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 44,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
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
/// CHANGE 7: it now takes an onTap, so the die itself is tappable —
/// anything can be a button.
class DieFace extends StatelessWidget {
  const DieFace({super.key, required this.value, required this.onTap});

  final int value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(kGapM),
        padding: const EdgeInsets.all(kGapM),
        decoration: BoxDecoration(
          color: kDiePad,
          borderRadius: BorderRadius.circular(24),
        ),
        // The interpolated path is the trick: state -> which image loads.
        child: Image.asset('assets/dice-$value.png'),
      ),
    );
  }
}
