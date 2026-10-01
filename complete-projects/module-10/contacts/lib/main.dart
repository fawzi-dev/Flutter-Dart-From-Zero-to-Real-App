// Contacts — the project you build across Module 10.
//
// main.dart does app setup and nothing else. That is the point of lesson
// 10.7: when this file is twenty lines, you can find anything in the project
// by reading three folder names.

import 'package:flutter/material.dart';

import 'screens/contacts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      // Colours are set on each Scaffold and AppBar directly, using named
      // parameters you already know. There is an app-wide way to do this
      // (ThemeData) and it is Module 13's subject.
      home: const ContactsScreen(),
    );
  }
}
