// End of lesson 9.1 Part 2 -- "Pass the Function, Don't Call It".
//
// The same button. The function inside onPressed moves out and gets a name,
// and the name is handed over bare. Lesson 3.6's recipe and meal, on a button.

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

  void handleTap() {
    debugPrint('Tapped!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: Center(
        child: ElevatedButton(
          // The recipe, not the meal: no parentheses.
          onPressed: handleTap,
          child: const Text('Tap me'),
        ),
      ),
    );
  }
}
