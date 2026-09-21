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
        // TODO: Build the About Me card here (Module 7).
        // Target screenshot: README.md — your photo is at assets/profile.png
      ),
    );
  }
}
