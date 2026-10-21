// BMI Calculator -- Module 9 exercise, finished.
//
// Built from an empty starter in eight videos, 9.11 P1 to P8. Every stage is
// in steps/. Nothing here is new: every widget was taught in Modules 7-9.

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
  int weight = 65; // kg

  // Which view is showing.
  bool showResult = false;

  // Worked out, never stored.
  double get bmi {
    final metres = height / 100; // the slider is in centimetres
    return weight / (metres * metres);
  }

  void addWeight() {
    setState(() {
      weight++;
    });
  }

  void removeWeight() {
    if (weight > 1) {
      setState(() {
        weight--;
      });
    }
  }

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
        child: showResult
            ? ResultView(
                bmi: bmi,
                onRecalculate: () {
                  setState(() => showResult = false);
                },
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                    children: [
                      SegmentedButton<Gender>(
                        segments: const [
                          ButtonSegment(
                            value: Gender.male,
                            label: Text(AppStrings.male),
                          ),
                          ButtonSegment(
                            value: Gender.female,
                            label: Text(AppStrings.female),
                          ),
                        ],
                        selected: {gender},
                        onSelectionChanged: (selection) {
                          setState(() => gender = selection.first);
                        },
                      ),
                      const SizedBox(height: AppSpacing.medium),
                      InputCard(
                        label: AppStrings.height,
                        child: Column(
                          children: [
                            BigNumber(
                              value: '${height.round()}',
                              unit: AppStrings.cm,
                            ),
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
                      const SizedBox(height: AppSpacing.medium),
                      InputCard(
                        label: AppStrings.weight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StepperButton(
                              icon: Icons.remove,
                              onPressed: removeWeight,
                            ),
                            BigNumber(value: '$weight', unit: AppStrings.kg),
                            StepperButton(
                              icon: Icons.add,
                              onPressed: addWeight,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.large),
                      PrimaryButton(
                        label: AppStrings.calculate,
                        onPressed: () {
                          setState(() => showResult = true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// Boundaries: exactly 18.5 is Normal, exactly 25 is Overweight.
String categoryFor(double bmi) {
  if (bmi < 18.5) return AppStrings.underweight;
  if (bmi < 25) return AppStrings.normal;
  if (bmi < 30) return AppStrings.overweight;
  return AppStrings.obese;
}

Color colorFor(double bmi) {
  if (bmi < 18.5) return AppColors.under;
  if (bmi < 25) return AppColors.normal;
  if (bmi < 30) return AppColors.over;
  return AppColors.high;
}

String interpretationFor(double bmi) {
  if (bmi < 18.5) return AppStrings.underMessage;
  if (bmi < 25) return AppStrings.normalMessage;
  if (bmi < 30) return AppStrings.overMessage;
  return AppStrings.obeseMessage;
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

/// The result view: handed the BMI, and what to do on Re-calculate.
class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.bmi, required this.onRecalculate});

  final double bmi;
  final VoidCallback onRecalculate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.medium),
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
          const SizedBox(height: AppSpacing.xxl),
          BmiScale(category: categoryFor(bmi)),
          const SizedBox(height: AppSpacing.xl),
          Text(
            interpretationFor(bmi),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted, fontSize: 16),
          ),
          const Spacer(),
          PrimaryButton(
            label: AppStrings.recalculate,
            onPressed: onRecalculate,
          ),
        ],
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.tiny,
      ),
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

/// Four coloured bands in a Row. The band you are in is tall and labelled.
class BmiScale extends StatelessWidget {
  const BmiScale({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.small,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ScaleBand(
            color: AppColors.under,
            isYou: category == AppStrings.underweight,
          ),
        ),
        Expanded(
          child: ScaleBand(
            color: AppColors.normal,
            isYou: category == AppStrings.normal,
          ),
        ),
        Expanded(
          child: ScaleBand(
            color: AppColors.over,
            isYou: category == AppStrings.overweight,
          ),
        ),
        Expanded(
          child: ScaleBand(
            color: AppColors.high,
            isYou: category == AppStrings.obese,
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
          isYou ? AppStrings.you : '',
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.tiny),
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
