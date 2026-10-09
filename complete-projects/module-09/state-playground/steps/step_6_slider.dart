// End of lesson 9.8 Part 2 -- "Height Must Stay in Range".
//
// A number with limits gets a control with the limits built in. A new screen,
// HeightScreen: one card, a big rounded number, and a Slider held to 120-220.
// Nothing to parse, because nothing outside the walls can come out.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeightScreen(),
    );
  }
}

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  void handleTap() {
    debugPrint('Tapped!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: Center(
        child: ElevatedButton(
          onPressed: handleTap,
          child: const Text('Tap me'),
        ),
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count', style: const TextStyle(fontSize: 64)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: const Text('Add one'),
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleScreen extends StatefulWidget {
  const DoubleScreen({super.key});

  @override
  State<DoubleScreen> createState() => _DoubleScreenState();
}

class _DoubleScreenState extends State<DoubleScreen> {
  final numberController = TextEditingController();
  double? result;
  // null: no message. Text: shown in red under the field.
  String? errorText;

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Double my number')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'A number',
                errorText: errorText,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // tryParse, not parse: "I'll try; if I can't, you get null."
                final number = double.tryParse(numberController.text);
                setState(() {
                  if (number == null) {
                    errorText = 'Please enter a number';
                    result = null;
                  } else {
                    errorText = null;
                    result = number * 2;
                  }
                });
              },
              child: const Text('Double it'),
            ),
            const SizedBox(height: 24),
            Text(
              result == null ? '' : '$result',
              style: const TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  // A slider's values are doubles: the thumb can stop anywhere on the track.
  double height = 175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Height')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
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
                    // Walls, not checks: nothing outside 120-220 can come out.
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
