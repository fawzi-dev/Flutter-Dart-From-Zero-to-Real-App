// End of the first half of lesson 9.5 Part 2 -- "Bad Input".
//
// A tiny "double my number" screen. First it trusts the user and crashes;
// then tryParse and errorText make it polite. The second half of the video,
// the discount code, is the ticket app: ../ticket-booking-v2-interactive/,
// steps/step_4a_discount.dart.

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

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Created once, as a field. Inside build, every rebuild would make a new,
  // empty one.
  final nameController = TextEditingController();
  String greeting = '';

  // The other end of the pair: hand the controller back when the screen goes.
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text field')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Your name',
                hintText: 'e.g. Fawzi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  greeting = 'Hello, ${nameController.text}!';
                });
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 24),
            Text(greeting, style: const TextStyle(fontSize: 24)),
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
