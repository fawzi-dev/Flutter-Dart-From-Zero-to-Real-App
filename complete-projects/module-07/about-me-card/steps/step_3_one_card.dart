// End of lesson 7.18 (Part 3) — one info card, written inline.
//
// One. Not three. The copy-paste is what the challenge exists to prevent, and
// the extraction is the next video.
//
// Two things happened in this lesson:
//
//   - the red screen: color: and decoration: on the same Container. It was not
//     staged — it is what your fingers do after a video of typing color:. The
//     fix is that the colour belongs inside the decoration, and it is the same
//     rule from 7.11
//   - Expanded around the Text. It means "you take whatever room is left", and
//     without it a long email runs off the edge and brings back the stripes.
//     It is a Module 8 widget, borrowed early and on purpose
//
// The other two contacts are still plain Texts, waiting for Part 4.

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

                // One card, inline. The colour is inside the decoration,
                // where the red screen insisted it goes.
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 7,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withValues(alpha: 0.14),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(11),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEF0FE),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.phone_outlined,
                          color: Color(0xFF4F46E5),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // "You take the rest." That is the whole meaning.
                      const Expanded(
                        child: Text(
                          '+20 100 000 0000',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Not copy-pasted. Part 4 turns the card above into a class.
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
