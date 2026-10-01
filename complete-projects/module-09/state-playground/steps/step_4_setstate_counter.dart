// End of lesson 9.3 Part 1 -- "StatefulWidget & setState".
//
// The counter from step 3, working. Two problems, one tool each: count moves
// into a State object that survives rebuilds, and setState asks for one.

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
      home: CounterScreen(),
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

// The widget: cheap, thrown away and rebuilt, like every widget since 7.1.
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

// The State: kept alive across rebuilds. The data lives here now.
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
                // Change the data, ask for a rebuild.
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
