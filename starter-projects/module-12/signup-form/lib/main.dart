import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F6DF5)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        // TODO: Build the Sign Up form here (Module 12).
        // See README.md for the requirements. Start with a Form + a GlobalKey,
        // then add TextFormFields with validators.
        body: Center(child: Text('Start building your form')),
      ),
    );
  }
}
