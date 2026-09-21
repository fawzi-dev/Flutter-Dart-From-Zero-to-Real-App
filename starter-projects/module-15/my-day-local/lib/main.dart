// My Day — Module 14 FOUNDATION CAPSTONE
// Built in solution videos 14.4–14.7.
//
// A daily dashboard: a "Today" header with a progress ring, the quote of the
// day as a hero, then your tasks. No new concepts — Modules 5, 9, 10 and 11
// assembled — but a distinct, product-like feel.

import 'package:flutter/material.dart';

import 'app_colors.dart';
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
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
