// 9.10 P2 -- Two cards.
// InputCard and BigNumber: Height 175 cm, Weight 65 kg

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
                InputCard(
                  label: 'Height',
                  child: BigNumber(value: '175', unit: 'cm'),
                ),
                const SizedBox(height: 16),
                InputCard(
                  label: 'Weight',
                  child: BigNumber(value: '65', unit: 'kg'),
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
