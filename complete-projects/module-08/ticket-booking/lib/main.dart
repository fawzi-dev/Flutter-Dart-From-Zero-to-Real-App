// Ticket Booking — the project you build across Module 8.
//
// Every layout idea is met first in layout-playground. This is where they get
// used on something real, built top to bottom, one piece per video:
//   1  the palette, the gap scale, and the Column skeleton
//   2  the poster                  (Stack + Positioned badge)
//   3  the event title + heart     (overflow, patient one: ellipsis; static const)
//   4  the date and the description
//   5  the tickets-sold bar        (fixed, fixed, Expanded, fixed, fixed)
//   6  the three ticket tiers      (one Expanded each)
//   7  the quantity row            (spaceBetween, a Row inside a Row)
//   8  the total row and the Book button
//   9  the polish                  (overflow, patient two: landscape; the divider)
//
// Deliberately narrow: Row, Column, SizedBox, Expanded, Stack, Positioned,
// Padding, SafeArea, Container, Text, Icon, Image. That is the whole module.
//
// NOTHING here is tappable yet — this screen does not move, and that is the
// point. Module 9 makes every number on it real.

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
        // Lesson 8.5, patient two: in landscape the Column is simply too tall.
        // Not "share", not "shrink" — scroll.
        child: SingleChildScrollView(
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

                const QuantityRow(quantity: 2),
                const SizedBox(height: kGapL),

                Container(height: 1, color: kLine),
                const SizedBox(height: kGapL),

                const TotalRow(total: '120,000 IQD'),
                const SizedBox(height: kGapL),

                const BookButton(),
              ],
            ),
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

/// Fixed label, Expanded gap, fixed stepper. The same shape again — third
/// time this module.
class QuantityRow extends StatelessWidget {
  const QuantityRow({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    // Lesson 8.2. Label at one end, stepper at the other — that is
    // spaceBetween, and it is the most-used alignment in mobile UI.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Tickets',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            const _StepButton(icon: Icons.remove),
            SizedBox(
              width: 48,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const _StepButton(icon: Icons.add),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kLine),
      ),
      child: Icon(icon, size: 18, color: kInk),
    );
  }
}

class TotalRow extends StatelessWidget {
  const TotalRow({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    // Fixed label, then the price takes the rest and aligns right. A long
    // price on a small phone is exactly the overflow from 8.5 — Expanded
    // means it can never happen.
    return Row(
      children: [
        const Text('Total', style: TextStyle(fontSize: 15, color: kMuted)),
        const SizedBox(width: kGapM),
        Expanded(
          child: Text(
            total,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kInk,
            ),
          ),
        ),
      ],
    );
  }
}

class BookButton extends StatelessWidget {
  const BookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: kAccent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        'Book now',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
