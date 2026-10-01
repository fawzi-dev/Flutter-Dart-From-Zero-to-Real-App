// About Me Card — Module 7 project
// Built in solution video 7.18. Matches challenges/module-07/about-me-card.md
//
// The rubric's main point: the info rows come from ONE widget class
// (InfoCard) used three times — not copy-pasted blocks.
//
// Everything here is Module 7 material: Text + TextStyle, Container with
// padding/margin/decoration, an image asset, and one extracted widget class.
// No state anywhere — this screen never changes. That starts in Module 9.

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
      // A gradient instead of one flat colour. Still just a BoxDecoration —
      // the same tool that draws the cards below. Indigo into violet.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4F46E5),
              Color(0xFF7C3AED),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 52),

                  // The avatar sits inside a padded, bordered circle — a
                  // Container wrapping a Container. Nesting for looks.
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

                  // A little "badge" — a pill-shaped Container around a Text.
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
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

                  // ONE class, used three times. Adding a fourth costs one line.
                  const InfoCard(icon: Icons.phone_outlined, text: '+20 100 000 0000'),
                  const InfoCard(icon: Icons.email_outlined, text: 'fawzi@example.com'),
                  const InfoCard(icon: Icons.link, text: 'github.com/fawzi'),

                  const SizedBox(height: 52),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One contact row: an icon in a tinted circle, then the text.
/// Built once, used three times — this is the whole point of the challenge.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
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
          // The icon gets its own tinted circle: the Container from 7.11,
          // with shape: BoxShape.circle instead of a borderRadius.
          Container(
            padding: const EdgeInsets.all(11),
            decoration: const BoxDecoration(
              color: Color(0xFFEEF0FE),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF4F46E5), size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
