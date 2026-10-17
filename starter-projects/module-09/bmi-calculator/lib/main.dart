// BMI Calculator -- Module 9 exercise. STARTER.
//
// All of the UI is already here: the colours, the cards, the buttons, the
// scale, and the result view. Every value is typed, and nothing moves. Your
// job is the Module 9 part: give this screen a memory.
//
//   Task 1  Make BmiScreen a StatefulWidget. Add gender, height and weight.
//   Task 2  Wire the segmented button and the slider with setState.
//   Task 3  Make the weight steppers work. Never below 1.
//   Task 4  Add a bmi getter, in metres. Check: 175 cm, 65 kg = 21.2.
//   Task 5  Add a showResult bool. Calculate shows ResultView; Re-calculate
//           comes back.
//   Task 6  Give categoryFor, colorFor and interpretationFor their real ifs.
//
// Full brief: challenges/module-09/bmi-calculator.md

import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

// The palette. Named once, used everywhere.
class AppColors {
  static const background = Color(0xFFF4F6FB);
  static const card = Colors.white;
  static const primary = Color(0xFF4F6DF5);
  static const ink = Color(0xFF1A1D2E);
  static const muted = Color(0xFF9AA0B4);

  // The health scale, low BMI to high.
  static const under = Color(0xFF29B6F6);
  static const normal = Color(0xFF24D876);
  static const over = Color(0xFFFF9F43);
  static const high = Color(0xFFFF5A5F);
}

enum Gender { male, female }

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiScreen(),
    );
  }
}

class BmiScreen extends StatelessWidget {
  const BmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SegmentedButton<Gender>(
                  segments: const [
                    ButtonSegment(
                      value: Gender.male,
                      label: Text('Male'),
                    ),
                    ButtonSegment(
                      value: Gender.female,
                      label: Text('Female'),
                    ),
                  ],
                  selected: {Gender.male},
                  onSelectionChanged: (selection) {},
                ),
                const SizedBox(height: 16),
                InputCard(
                  label: 'Height',
                  child: Column(
                    children: [
                      BigNumber(value: '175', unit: 'cm'),
                      Slider(
                        value: 175,
                        min: 120,
                        max: 220,
                        divisions: 100,
                        activeColor: AppColors.primary,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InputCard(
                  label: 'Weight',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepperButton(
                        icon: Icons.remove,
                        onPressed: () {},
                      ),
                      BigNumber(value: '65', unit: 'kg'),
                      StepperButton(
                        icon: Icons.add,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Calculate BMI',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Task 6: still placeholders -- every BMI is 'Normal' for now.
String categoryFor(double bmi) {
  return 'Normal';
}

Color colorFor(double bmi) {
  return AppColors.normal;
}

String interpretationFor(double bmi) {
  return 'Your message goes here.';
}

// ===================================================================
//  THE PRE-BUILT UI -- in the starter already, ready to be wired.
//  Each piece is told what to show and what to do by the screen.
// ===================================================================

/// The whole result view. It is handed the BMI and what to do on
/// Re-calculate -- values down, taps up, like the ticket's widgets (9.5).
class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.bmi, required this.onRecalculate});

  final double bmi;
  final VoidCallback onRecalculate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Spacer(),
          Text(
            bmi.toStringAsFixed(1),
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 88,
              fontWeight: FontWeight.w900,
            ),
          ),
          CategoryPill(category: categoryFor(bmi), color: colorFor(bmi)),
          const SizedBox(height: 40),
          BmiScale(category: categoryFor(bmi)),
          const SizedBox(height: 32),
          Text(
            interpretationFor(bmi),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 16),
          ),
          const Spacer(),
          PrimaryButton(label: 'Re-calculate', onPressed: onRecalculate),
        ],
      ),
    );
  }
}

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

/// A big number with its unit beside it: 175 cm, 65 kg.
class BigNumber extends StatelessWidget {
  const BigNumber({super.key, required this.value, required this.unit});

  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 44,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6, bottom: 8),
          child: Text(
            unit,
            style: const TextStyle(color: AppColors.muted, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

/// A round +/- button: a circle with an IconButton inside (9.1).
class StepperButton extends StatelessWidget {
  const StepperButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
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

/// The big full-width button: an ElevatedButton styled like Book (9.5 P4).
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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: Text(label),
      ),
    );
  }
}

/// The category in a soft coloured pill: Normal, Overweight...
class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.category, required this.color});

  final String category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// The health scale: four coloured bands in a Row (Expanded, 8.3). The band
/// you are in is tall and labelled. It is told the category, nothing else.
class BmiScale extends StatelessWidget {
  const BmiScale({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ScaleBand(
            color: AppColors.under,
            isYou: category == 'Underweight',
          ),
        ),
        Expanded(
          child: ScaleBand(
            color: AppColors.normal,
            isYou: category == 'Normal',
          ),
        ),
        Expanded(
          child: ScaleBand(
            color: AppColors.over,
            isYou: category == 'Overweight',
          ),
        ),
        Expanded(
          child: ScaleBand(
            color: AppColors.high,
            isYou: category == 'Obese',
          ),
        ),
      ],
    );
  }
}

/// One band of the scale: short and pale, or tall and labelled "You".
class ScaleBand extends StatelessWidget {
  const ScaleBand({super.key, required this.color, required this.isYou});

  final Color color;
  final bool isYou;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isYou ? 'You' : '',
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: isYou ? 22 : 10,
          decoration: BoxDecoration(
            color: isYou ? color : color.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }
}
