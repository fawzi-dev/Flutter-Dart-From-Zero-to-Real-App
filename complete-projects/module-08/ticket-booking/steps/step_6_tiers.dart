// Step 6 -- The ticket tiers.
//
// Three options, one Expanded each, so they split the width evenly on any
// phone. Exactly one of them gets the accent.

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

              const SoldBar(sold: 142, total: 200),
              const SizedBox(height: kGapXL),

              const TierRow(),
              const SizedBox(height: kGapXL),

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

/// Lesson 8.3. The two labels keep their natural size; the bar takes what is
/// left. Rotate the device and nothing moves — because nothing is measured.
///
/// And the bar is DERIVED: sold / total. It cannot disagree with the numbers
/// either side of it, because it is computed from them.
class SoldBar extends StatelessWidget {
  const SoldBar({super.key, required this.sold, required this.total});

  final int sold;
  final int total;

  @override
  Widget build(BuildContext context) {
    const label = TextStyle(fontSize: 12, color: kMuted);
    final remaining = total - sold;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('$sold sold', style: label),
            const SizedBox(width: kGapM),
            Expanded(
              child: Row(
                children: [
                  // Slices of a pie, not measurements — lesson 8.3's flex,
                  // doing a real job.
                  Expanded(
                    flex: sold,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: kAccent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: remaining,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: kLine,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: kGapM),
            Text('$total seats', style: label),
          ],
        ),
      ],
    );
  }
}

/// Lesson 8.3. Three equal options SHARE the width — one Expanded each, so
/// they stay equal on any phone. Hardcode their widths instead and the row
/// overflows on a small screen, which is exactly what 8.3 warns about.
///
/// Exactly one accent: the selected tier. Highlight a second and the eye
/// stops knowing where to go.
class TierRow extends StatelessWidget {
  const TierRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: TierChip(name: 'Standard', price: '35,000', selected: false),
        ),
        SizedBox(width: kGapS),
        Expanded(
          child: TierChip(name: 'VIP', price: '60,000', selected: true),
        ),
        SizedBox(width: kGapS),
        Expanded(
          child: TierChip(name: 'Backstage', price: '95,000', selected: false),
        ),
      ],
    );
  }
}

class TierChip extends StatelessWidget {
  const TierChip({
    super.key,
    required this.name,
    required this.price,
    required this.selected,
  });

  final String name;
  final String price;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? kAccent : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selected ? kAccent : kLine),
      ),
      child: Column(
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : kInk,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            price,
            style: TextStyle(
              fontSize: 11,
              color: selected ? Colors.white70 : kMuted,
            ),
          ),
        ],
      ),
    );
  }
}
