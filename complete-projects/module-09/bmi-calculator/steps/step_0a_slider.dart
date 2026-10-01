// Lesson 9.6 Part 4 — one bounded BMI height input, before the challenge.
// Run with: flutter run -t steps/step_0a_slider.dart
import 'package:flutter/material.dart';

void main() => runApp(const HeightInputDemo());

class HeightInputDemo extends StatelessWidget {
  const HeightInputDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F6DF5)),
      ),
      home: const HeightInputScreen(),
    );
  }
}

class HeightInputScreen extends StatefulWidget {
  const HeightInputScreen({super.key});

  @override
  State<HeightInputScreen> createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {
  double height = 175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(title: const Text('BMI input: height')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
