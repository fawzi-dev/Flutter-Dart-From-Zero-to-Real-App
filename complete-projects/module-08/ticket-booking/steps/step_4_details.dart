// Step 4 -- The date and the description.
//
// Two more Texts under the title. The description is capped at two lines
// with the same ellipsis from the last step.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const kInk = Color(0xFF141220);
const kMuted = Color(0xFF6E6A80);
const kAccent = Color(0xFFB4453A);
const kSurface = Color(0xFFF7F5F2);
const kLine = Color(0xFFE4E0DA);

// The spacing scale. Four numbers, reused everywhere — that discipline is
// most of why the screen reads as designed rather than typed.
const kGapS = 8.0;
const kGapM = 12.0;
const kGapL = 24.0;
const kGapXL = 32.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tickets',
      home: TicketScreen(),
    );
  }
}

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  // A genuinely long title, on purpose. Short ones hide the bug.
  static const _title = 'Night at the Citadel — Open Air Summer Series';
  static const _when = 'SAT  ·  14 SEP  ·  8:00 PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kGapL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EventPoster(),
              const SizedBox(height: kGapXL),

              // Fixed, Expanded, fixed — the shape of half the rows in
              // mobile development.
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: kInk,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: kGapM),
                  const Icon(Icons.favorite_border, color: kMuted),
                ],
              ),
              const SizedBox(height: kGapS),

              const Text(
                _when,
                style: TextStyle(
                  color: kMuted,
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: kGapM),

              const Text(
                'An open-air night in the old amphitheatre, with the city '
                'walls behind the stage and doors opening an hour early.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.45, color: kMuted),
              ),
              const SizedBox(height: kGapXL),

              const Text('seats'),
              const Text('tickets and total'),
            ],
          ),
        ),
      ),
    );
  }
}

/// Lesson 8.6. The poster is the Stack's only non-positioned child, so the
/// Stack takes its size — which is exactly the "my Stack vanished" gotcha,
/// avoided by having one normal child.
class EventPoster extends StatelessWidget {
  const EventPoster({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/event.jpg',
            width: double.infinity,
            height: 210,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: kGapM,
          left: kGapM,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'FEW LEFT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
