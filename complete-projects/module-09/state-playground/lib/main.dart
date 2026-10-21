// End of lesson 9.9 P2 -- "static, and why static const".
//
// The two labels on ConstScreen move into Labels: static const fields, one
// copy, kept on the class. Every way of writing them except static const
// fails, and the reason each one fails is the lesson.

import 'package:flutter/material.dart';

// Exactly one of two names: an enum, from lesson 5.4.
enum Gender { male, female }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConstScreen(),
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
  Gender gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Height')),
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
                // A Set: nothing in it twice. Ours always holds one value.
                selected: {gender},
                onSelectionChanged: (selection) {
                  setState(() => gender = selection.first);
                },
              ),
            ),
            const SizedBox(height: 16),
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

// Every label on ConstScreen: one copy, kept on the class.
class Labels {
  static const withoutConst = 'without const';
  static const withConst = 'with const';
}

// A label that says so every time Flutter builds it.
class LoudLabel extends StatelessWidget {
  const LoudLabel({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    debugPrint('built: $name');
    return Text(name, style: const TextStyle(fontSize: 20));
  }
}

class ConstScreen extends StatefulWidget {
  const ConstScreen({super.key});

  @override
  State<ConstScreen> createState() => _ConstScreenState();
}

class _ConstScreenState extends State<ConstScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('const')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count', style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 24),
            // The same widget twice. Only one of them is const.
            // ignore: prefer_const_constructors
            LoudLabel(name: Labels.withoutConst),
            const LoudLabel(name: Labels.withConst),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() => count++);
              },
              child: const Text('Add one'),
            ),
          ],
        ),
      ),
    );
  }
}
