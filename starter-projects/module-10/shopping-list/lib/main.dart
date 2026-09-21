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
        // TODO: Build the Shopping List app here (Module 10).
        // You create models/ screens/ widgets/ yourself — that's part of the challenge
      ),
    );
  }
}
