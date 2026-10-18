// 9.10 P4 -- Gender and height.
// Stateful; gender and height in the State; the segmented button and the slider work

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

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  // Everything a person can change.
  Gender gender = Gender.male;
  double height = 175; // cm

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
                    ButtonSegment(value: Gender.male, label: Text('Male')),
                    ButtonSegment(value: Gender.female, label: Text('Female')),
                  ],
                  selected: {gender},
                  onSelectionChanged: (selection) {
                    setState(() => gender = selection.first);
                  },
                ),
                const SizedBox(height: 16),
                InputCard(
                  label: 'Height',
                  child: Column(
                    children: [
                      BigNumber(value: '${height.round()}', unit: 'cm'),
                      Slider(
                        value: height,
                        min: 120,
                        max: 220,
                        divisions: 100,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() => height = value);
                        },
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
                      StepperButton(icon: Icons.remove, onPressed: () {}),
                      BigNumber(value: '65', unit: 'kg'),
                      StepperButton(icon: Icons.add, onPressed: () {}),
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

/// A round +/- button: a circle with an IconButton inside.
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

/// The big full-width button: an ElevatedButton styled like Book.
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
