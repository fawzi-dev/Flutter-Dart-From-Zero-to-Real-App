// BMI Calculator -- Module 9 exercise. STARTER.
//
// An empty app. Build the BMI calculator from scratch.
// Full brief: challenges/module-09/bmi-calculator.md

import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
