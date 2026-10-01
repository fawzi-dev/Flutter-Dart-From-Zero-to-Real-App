// BMI Calculator -- snapshot at the end of 9.9 Part 1.
//
// The input view works and Calculate gives a correct number (175 cm and
// 65 kg is 21.2). The result view is a plain placeholder: the big number,
// the category, the scale and its marker are Part 2, which ends at
// lib/main.dart.

import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

// A tiny design system: name every colour once, use the names everywhere.
// This is what keeps a UI looking coherent instead of like a ransom note.
class AppColors {
  static const background = Color(0xFFF4F6FB);
  static const card = Colors.white;
  static const primary = Color(0xFF4F6DF5);
  static const ink = Color(0xFF1A1D2E);
  static const muted = Color(0xFF9AA0B4);
}

enum Gender { male, female }

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Colours are set on the widgets themselves, with named parameters you
      // already know. There is an app-wide way to do this (ThemeData) and it
      // is Module 13's subject -- deliberately not used here.
      home: const BmiScreen(),
    );
  }
}

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  // Everything the user can change — the whole subject of Module 9.
  Gender gender = Gender.male;
  double height = 175; // cm
  int weight = 65; // kg

  bool showResult = false;

  // The answer is not a field. Like the ticket's total in 9.3, it is computed
  // from the fields every time it is read, so it can never be out of date.
  double get bmi {
    final metres = height / 100; // the slider is in centimetres
    return weight / (metres * metres);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
      ),
      // The body swaps entirely on one bool. Module 10 turns this into a
      // real second screen with Navigator.push.
      body: SafeArea(
        child: showResult ? buildResultView() : buildInputView(),
      ),
    );
  }

  // ----------------------------------------------------------------- INPUT
  Widget buildInputView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Gender — a Material 3 segmented control (value + onSelectionChanged).
          SegmentedButton<Gender>(
            segments: const [
              ButtonSegment(
                value: Gender.male,
                label: Text('Male'),
                icon: Icon(Icons.male),
              ),
              ButtonSegment(
                value: Gender.female,
                label: Text('Female'),
                icon: Icon(Icons.female),
              ),
            ],
            selected: {gender},
            onSelectionChanged: (selection) =>
                setState(() => gender = selection.first),
          ),
          const SizedBox(height: 16),

          // Height — a slider.
          InputCard(
            label: 'Height',
            child: Column(
              children: [
                // Two Texts in a Row, baseline-ish by eye -- no rich text
                // needed. Row is Module 8; that is the whole trick.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${height.round()}',
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 6, bottom: 8),
                      child: Text(
                        'cm',
                        style: TextStyle(color: AppColors.muted, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: height,
                  min: 120,
                  max: 220,
                  divisions: 100, // whole centimetres, as in 9.6 Part 4
                  activeColor: AppColors.primary,
                  onChanged: (value) => setState(() => height = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Weight — +/- steppers built from a reusable button.
          InputCard(
            label: 'Weight',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StepperButton(
                  icon: Icons.remove,
                  onPressed: () => setState(() {
                    if (weight > 1) weight--;
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$weight',
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 6, bottom: 8),
                      child: Text(
                        'kg',
                        style: TextStyle(color: AppColors.muted, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                StepperButton(
                  icon: Icons.add,
                  onPressed: () => setState(() => weight++),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          PrimaryButton(
            label: 'Calculate BMI',
            onPressed: () => setState(() => showResult = true),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- RESULT
  // A placeholder until Part 2: just the number and a way back.
  Widget buildResultView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Spacer(),
          Text(
            'BMI: ${bmi.toStringAsFixed(1)}',
            style: const TextStyle(color: AppColors.ink, fontSize: 32),
          ),
          const Spacer(),
          PrimaryButton(
            label: 'Re-calculate',
            onPressed: () => setState(() => showResult = false),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
//  REUSABLE WIDGETS — the heart of the module.
//  Each is a small, named class with parameters (and callbacks where it
//  needs them). Used again and again. This is how real UIs are built:
//  small pieces, combined.
// ===================================================================

/// A white rounded card with a label above its content.
class InputCard extends StatelessWidget {
  const InputCard({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

/// A round +/- button. One class, used twice (and easy to reuse anywhere).
class StepperButton extends StatelessWidget {
  const StepperButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // A circular Container (lesson 7.8) with an IconButton inside it
    // (lesson 9.1). IconButton brings its own ripple, so nothing else is
    // needed to make it feel like a real button.
    return Container(
      width: 52,
      height: 52,
      decoration: const BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}

/// The big rounded action button. Used for Calculate AND Re-calculate.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
