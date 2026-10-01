// End of lesson 11.2 P3 -- "The Freeze, Fixed".
//
// The same four-second wait, and the app stays completely alive. Tap the
// counter while it loads: it counts. Frames still paint. Nothing queues up.
//
// One word did that. `sleep` held the worker hostage; `await` politely lets it
// go and do other things until the answer arrives.
//
// Read the anatomy:
//   Future<void>   -- this does some waiting and gives back no value
//   async          -- marks a function that contains an await
//   await          -- wait for this, without blocking
//
// And the line after the await: the user may have left the screen during
// those four seconds. `mounted` asks "am I still on screen?" before setState.

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

  Future<void> loadTheGoodWay() async {
    setState(() => status = 'Loading...');
    // The worker goes and does other things for four seconds.
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;   // they may have left the screen while we waited
    setState(() => status = 'Loaded!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('No freeze')),
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
              onPressed: loadTheGoodWay,
              child: const Text('Load data'),
            ),
          ],
        ),
      ),
    );
  }
}
