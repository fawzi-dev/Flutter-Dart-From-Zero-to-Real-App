// End of lesson 9.2 -- "Why Won't the Screen Change?"
//
// *** THIS FILE IS DELIBERATELY BROKEN. RUN IT ANYWAY. ***
//
// Tap plus. The terminal says 3, 4, 5, 6. The screen still says 2. No error,
// no red screen -- the same bug as the counter, on a real screen:
//   1. Nothing tells Flutter to run build again.
//   2. quantity lives inside build, so a rebuild would reset it anyway.
//
// 9.3 P2 fixes both. Write your own explanation down first.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const kInk = Color(0xFF141220);
const kMuted = Color(0xFF6E6A80);
const kAccent = Color(0xFFB4453A);
const kSurface = Color(0xFFF7F5F2);
const kLine = Color(0xFFE4E0DA);

// The spacing scale. Four numbers, reused everywhere.
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
    // THE BUG, on purpose. A local inside build is made fresh on every build,
    // and nothing ever asks build to run again anyway.
    int quantity = 2;

    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kGapL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EventPoster(),
                const SizedBox(height: kGapXL),

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
                    IconButton(
                      onPressed: () {
                        debugPrint('favourite pressed');
                      },
                      icon: const Icon(Icons.favorite_border, color: kMuted),
                    ),
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

                QuantityRow(
                  quantity: quantity,
                  onMinus: () {
                    quantity--;
                    debugPrint('quantity is now $quantity');
                  },
                  onPlus: () {
                    quantity++;
                    debugPrint('quantity is now $quantity');
                  },
                ),
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

/// Still a StatelessWidget, and it should be: it owns nothing, it is handed
/// two numbers. The bar is derived from them, so it cannot disagree.
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
                  // Slices of a pie, not measurements.
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

/// Three equal options share the width, one Expanded each. Exactly one accent:
/// the selected tier.
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

/// Label at one end, stepper at the other: spaceBetween.
class QuantityRow extends StatelessWidget {
  const QuantityRow({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;

  // Lesson 9.1 P3. The row does not decide what a tap means. It reports the
  // tap, and the screen that owns the number decides.
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Tickets',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            _StepButton(icon: Icons.remove, onPressed: onMinus),
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
            _StepButton(icon: Icons.add, onPressed: onPlus),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

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
      // Lesson 9.1 P3. A picture of a button becomes a real one, ripple and
      // all. onPressed is handed over bare: no brackets.
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: kInk),
      ),
    );
  }
}

class TotalRow extends StatelessWidget {
  const TotalRow({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    // Fixed label, then the price takes the rest and aligns right.
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

/// Still a picture of a button. Lesson 9.6 P3 makes it a real one.
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
