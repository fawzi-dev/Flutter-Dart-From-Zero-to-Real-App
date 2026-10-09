// End of lesson 9.8 Part 1 -- "Bad Input".
//
// A tiny "double my number" screen. First it trusts the user and crashes;
// then tryParse and errorText make it polite. The ticket card read a typed
// code in 9.6 P1-P2. Now a numeric field must convert text safely.

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
      home: DoubleScreen(),
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
