// End of lesson 11.1 -- "Why Apps Must Wait".
//
// *** THIS FILE FREEZES ON PURPOSE. RUN IT ANYWAY. ***
//
// Tap Load, then tap the counter. Nothing happens for four seconds -- not
// slow, genuinely dead. Then every queued tap fires at once, which is its own
// kind of awful.
//
// Why: your app runs on ONE thread. One worker handling taps, your code, and
// painting sixty frames a second. sleep() holds that worker hostage, so
// nothing else can run.
//
// Waiting is unavoidable -- the network is genuinely slow. Freezing is not.
// Lesson 11.2 is the fix; P3 applies it to this exact screen.

import 'dart:io';

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
      title: 'Quote of the Day',
      home: FreezeDemo(),
    );
  }
}

class FreezeDemo extends StatefulWidget {
  const FreezeDemo({super.key});

  @override
  State<FreezeDemo> createState() => _FreezeDemoState();
}

class _FreezeDemoState extends State<FreezeDemo> {
  int count = 0;
  String status = 'Nothing loaded yet';

  void loadTheHardWay() {
    setState(() => status = 'Loading...');
    // The whole app stops here. This is the bug, on purpose.
    sleep(const Duration(seconds: 4));
    setState(() => status = 'Loaded!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('The freeze')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$count', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => setState(() => count++),
              child: const Text('Count'),
            ),
            const SizedBox(height: 40),
            Text(status),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: loadTheHardWay,
              child: const Text('Load data'),
            ),
          ],
        ),
      ),
    );
  }
}
