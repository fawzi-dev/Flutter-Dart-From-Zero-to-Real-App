// DAY ZERO — poke this app! (Lesson 0.3)
// You are NOT supposed to understand this code yet. That's the plan.
// Just find the 👉 lines, change them, and press Run. You can't break
// anything permanently — reload the page and the original comes back.

import 'package:flutter/material.dart';

void main() {
  runApp(const DayZeroApp());
}

class DayZeroApp extends StatelessWidget {
  const DayZeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileCard(),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  // 👉 Poke #1: change the name between the quotes to YOUR name
  final myName = 'Fawzi';

  // 👉 Poke #3: change 3 to 1000, then tap the button in the app
  int highFives = 3;

  @override
  Widget build(BuildContext context) {
    // 👉 Poke #2: delete `indigo`, type a dot after Colors, and pick
    //    a new color from the menu that pops up (deepPurple? amber?)
    final backgroundColor = Colors.indigo;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('👋', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              myName,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'High fives: $highFives',
              style: const TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  highFives = highFives + 1;
                });
              },
              child: const Text('High five! ✋'),
            ),
          ],
        ),
      ),
    );
  }
}
