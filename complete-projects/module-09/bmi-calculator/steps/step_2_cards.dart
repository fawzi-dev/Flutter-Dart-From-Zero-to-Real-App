// 9.11 P2 -- Two cards.
// InputCard and BigNumber: Height 175 cm, Weight 65 kg

import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

// ---------------------------------------------------------------------------
//  Given in the starter: every colour, every piece of text, every spacing.
// ---------------------------------------------------------------------------

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

// Every piece of text on the screen.
class AppStrings {
  static const title = 'BMI Calculator';
  static const male = 'Male';
  static const female = 'Female';
  static const height = 'Height';
  static const weight = 'Weight';
  static const cm = 'cm';
  static const kg = 'kg';
  static const calculate = 'Calculate BMI';
  static const recalculate = 'Re-calculate';
  static const you = 'You';

  static const underweight = 'Underweight';
  static const normal = 'Normal';
  static const overweight = 'Overweight';
  static const obese = 'Obese';

  static const underMessage =
      'A little under the healthy range. Eat a bit more.';
  static const normalMessage = 'Right in the healthy range. Nice work!';
  static const overMessage =
      'A little over the healthy range. Move a bit more.';
  static const obeseMessage =
      'Above the healthy range. Small, steady changes add up.';
}

// The spacing scale. Seven numbers, reused everywhere.
class AppSpacing {
  static const tiny = 4.0;
  static const small = 8.0;
  static const medium = 16.0;
  static const card = 20.0;
  static const large = 24.0;
  static const xl = 32.0;
  static const xxl = 40.0;
}

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
        title: const Text(AppStrings.title),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.medium),
            child: Column(
              children: [
                InputCard(
                  label: AppStrings.height,
                  child: BigNumber(value: '175', unit: AppStrings.cm),
                ),
                const SizedBox(height: AppSpacing.medium),
                InputCard(
                  label: AppStrings.weight,
                  child: BigNumber(value: '65', unit: AppStrings.kg),
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
      padding: const EdgeInsets.all(AppSpacing.card),
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
          const SizedBox(height: AppSpacing.small),
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
          padding: const EdgeInsets.only(
            left: AppSpacing.small,
            bottom: AppSpacing.small,
          ),
          child: Text(
            unit,
            style: const TextStyle(color: AppColors.muted, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
