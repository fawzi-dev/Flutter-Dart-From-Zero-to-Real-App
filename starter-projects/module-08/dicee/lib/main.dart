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
      home: Scaffold(
        // TODO: Build the Dicee screen here (Module 8: layout only).
        // Dice images ready: assets/dice-1.png ... assets/dice-6.png
      ),
    );
  }
}
