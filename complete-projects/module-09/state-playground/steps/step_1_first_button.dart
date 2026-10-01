// End of lesson 9.1 Part 1 -- "Your First Button".
//
// One screen, one button. The only idea: the code inside onPressed waits for
// a finger.

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
      home: ButtonScreen(),
    );
  }
}

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: Center(
        child: ElevatedButton(
          // What it DOES. Kept, and run every time a finger arrives.
          onPressed: () {
            debugPrint('Tapped!');
          },
          // What it SHOWS.
          child: const Text('Tap me'),
        ),
      ),
    );
  }
}
