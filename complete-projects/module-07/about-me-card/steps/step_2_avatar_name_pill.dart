// End of lesson 7.18 (Part 2) — the avatar, the name, and the pill badge.
//
// Styling, top to bottom, one property at a time. Three things arrived:
//
//   - the avatar: a Container with shape: BoxShape.circle, a white border and
//     a shadow, wrapped around a CircleAvatar. A Container inside a Container,
//     purely for looks — that is allowed
//   - the name: a Text with a size, a weight and a colour, nothing exotic
//   - the badge: the Container from 7.11 with a see-through fill and the
//     borderRadius turned up until the ends go round. Past about half the
//     height it stops getting rounder and becomes a pill
//
// The three contact lines are still plain Texts. They are the exercise, and
// they get their own video.

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
      home: AboutMeScreen(),
    );
  }
}

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 52),

                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E1B4B).withValues(alpha: 0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 58,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                ),
                const SizedBox(height: 22),

                const Text(
                  'Fawzi Gharib',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                    ),
                  ),
                  child: const Text(
                    'FLUTTER DEVELOPER IN TRAINING',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE0E7FF),
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Still plain. These three are the exercise.
                const Text('+20 100 000 0000'),
                const Text('fawzi@example.com'),
                const Text('github.com/fawzi'),

                const SizedBox(height: 52),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
