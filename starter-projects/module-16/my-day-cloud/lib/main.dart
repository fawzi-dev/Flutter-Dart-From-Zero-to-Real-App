// My Day — the STARTING POINT for Module 16 (Firebase bonus)
//
// This is the finished Module 14 app: tasks live in memory and vanish
// when the app closes. That is the problem Module 16 solves.
//
// This is the one starter in the course that is NOT minimal — the module
// is about ADDING Firebase to an app you already understand. If you built
// your own My Day in Module 14, use YOURS instead of this.

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
