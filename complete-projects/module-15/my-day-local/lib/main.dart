// My Day (local) — Module 15 project: MAKING DATA LAST
// Built in solution video 15.6. This is the Module 14 capstone with one thing
// added: the tasks now survive closing the app.
//
// Diff this against complete-projects/module-14/my-day/ — the whole change is
// three small pieces:
//   1. Task gained toJson / fromJson  (lib/models/task.dart)
//   2. a TaskStorage service          (lib/services/task_storage.dart)
//   3. home_screen loads on start and saves after every change
// Module 16 (Firebase) then takes this the last step: off the device entirely.

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
