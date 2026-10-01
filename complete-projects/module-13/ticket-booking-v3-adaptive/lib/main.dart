// Ticket Booking v3 — the Module 13 lesson project.
//
// Third module on the same screen, and each one did a different job:
//   Module 8   built it
//   Module 9   gave it a memory
//   Module 13  makes it work on hardware you don't own, in a room whose
//              lights he can't see
//
//   13.2  MediaQuery — reading the device
//   13.3  LayoutBuilder — stacked under 600, side by side over it
//   13.4  every colour asked for by role instead of hardcoded
//   13.5  a light palette, a dark palette, and a System/Light/Dark toggle
//
// The ThemeMode lives HERE, above MaterialApp, because MaterialApp is what
// consumes it. A callback goes down; the new value comes back up.

import 'package:flutter/material.dart';

import 'screens/ticket_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // system by default — respect the user's own setting unless they say
  // otherwise inside the app.
  ThemeMode _mode = ThemeMode.system;

  void _cycleTheme() {
    setState(() {
      // System -> Light -> Dark -> System. An if/else chain, because this is
      // a course about Flutter and not about clever Dart.
      if (_mode == ThemeMode.system) {
        _mode = ThemeMode.light;
      } else if (_mode == ThemeMode.light) {
        _mode = ThemeMode.dark;
      } else {
        _mode = ThemeMode.system;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tickets',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: _mode,
      home: TicketScreen(themeMode: _mode, onCycleTheme: _cycleTheme),
    );
  }
}
