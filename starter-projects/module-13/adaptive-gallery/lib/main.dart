import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F6DF5)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        // TODO: Build the Adaptive Gallery here (Module 13).
        // See README.md for the requirements. The content list is provided for
        // you in the brief — your job is the layout (LayoutBuilder + a
        // breakpoint) and the theming (light + dark + a toggle).
        body: Center(child: Text('Build your responsive gallery')),
      ),
    );
  }
}
