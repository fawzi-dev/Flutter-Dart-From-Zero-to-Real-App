// Shopping List — Module 10 project
// Built in solution videos 10.9 and 10.10.
//
// The course's first MULTI-FILE app: models/, screens/, widgets/, plus a
// shared app_colors.dart. main.dart holds app setup only.

import 'package:flutter/material.dart';

import 'screens/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Groceries',
      debugShowCheckedModeBanner: false,
      // Colours are set on each Scaffold and AppBar directly, using named
      // parameters you already know. There is an app-wide way to do this
      // (ThemeData) and it is Module 13's subject.
      home: const ListScreen(),
    );
  }
}
