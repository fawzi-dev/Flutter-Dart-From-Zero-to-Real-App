// Lesson 9.6 Part 5 — add two visible choices to the height input demo.
// Run with: flutter run -t steps/step_0b_segmented.dart
import 'package:flutter/material.dart';

enum Gender { male, female }

void main() => runApp(const BmiInputDemo());

class BmiInputDemo extends StatelessWidget {
  const BmiInputDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F6DF5)),
      ),
      home: const BmiInputScreen(),
    );
  }
}

class BmiInputScreen extends StatefulWidget {
  const BmiInputScreen({super.key});

  @override
  State<BmiInputScreen> createState() => _BmiInputScreenState();
}

class _BmiInputScreenState extends State<BmiInputScreen> {
  double height = 175;
  Gender gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(title: const Text('BMI input: two choices')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SegmentedButton<Gender>(
                segments: const [
                  ButtonSegment(value: Gender.male, label: Text('Male')),
                  ButtonSegment(value: Gender.female, label: Text('Female')),
                ],
                selected: {gender},
                onSelectionChanged: (selection) {
                  setState(() => gender = selection.first);
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Height', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${height.round()} cm',
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Slider(
                      value: height,
                      min: 120,
                      max: 220,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() => height = value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
