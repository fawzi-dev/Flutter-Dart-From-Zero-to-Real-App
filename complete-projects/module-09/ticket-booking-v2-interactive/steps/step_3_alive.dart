// End of lesson 9.3 P2 -- "On the Ticket Card: One Word, and It Comes Alive".
//
// Real data behind the tiers (Tier, tiers, money), and a memory: tier,
// quantity and isFavourite live in the State class, and every change is
// wrapped in setState.
//
// The thing to notice is the TOTAL. Nothing updates it. It is a
// computed getter, so it cannot be out of date.

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

/// Lesson 9.3 P2. One ticket type: a name and a price. Two facts about one
/// thing, so it is a class -- the Module 5 data-class recipe, unchanged.
class Tier {
  final String name;
  final int price;

  const Tier({required this.name, required this.price});
}

/// The three tiers the event sells. A list of objects, like Module 5's quiz
/// questions.
const tiers = [
  Tier(name: 'Standard', price: 35000),
  Tier(name: 'VIP', price: 60000),
  Tier(name: 'Backstage', price: 95000),
];

/// 120000 becomes '120,000'. A loop, a remainder and string building --
/// Modules 1 and 2, doing a small real job.
String money(int amount) {
  final digits = amount.toString();
  var out = '';

  for (var i = 0; i < digits.length; i++) {
    // Every third digit from the right gets a comma in front of it.
    if (i > 0 && (digits.length - i) % 3 == 0) {
      out = '$out,';
    }
    out = '$out${digits[i]}';
  }

  return out;
}

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

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  // A genuinely long title, on purpose. Short ones hide the bug.
  static const _title = 'Night at the Citadel — Open Air Summer Series';
  static const _when = 'SAT  ·  14 SEP  ·  8:00 PM';

  // Everything a human can change lives here, in one place. The widgets
  // below only read it.
  Tier tier = tiers[1]; // VIP
  int quantity = 2;
  bool isFavourite = false;

  /// Derived, never stored. Recomputed on every build from what it depends
  /// on, so it can never be out of date.
  int get total => tier.price * quantity;

  void changeQuantity(int by) {
    final next = quantity + by;
    if (next < 1 || next > 8) return; // a guard clause, lesson 2.9
    setState(() => quantity = next);
  }

  @override
  Widget build(BuildContext context) {
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
                        setState(() => isFavourite = !isFavourite);
                      },
                      // build remembers nothing. It reads the field and draws.
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: isFavourite ? kAccent : kMuted,
                      ),
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

                TierRow(
                  selected: tier,
                  onChanged: (t) => setState(() => tier = t),
                ),
                const SizedBox(height: kGapXL),

                QuantityRow(
                  quantity: quantity,
                  onMinus: () => changeQuantity(-1),
                  onPlus: () => changeQuantity(1),
                ),
                const SizedBox(height: kGapL),

                Container(height: 1, color: kLine),
                const SizedBox(height: kGapL),

                TotalRow(total: '${money(total)} IQD'),
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
  const TierRow({super.key, required this.selected, required this.onChanged});

  final Tier selected;

  /// Lesson 9.3 P2. VoidCallback is a function that is handed nothing. This
  /// row has to say WHICH tier was tapped, so its callback is handed one.
  final void Function(Tier) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: chipFor(tiers[0])),
        const SizedBox(width: kGapS),
        Expanded(child: chipFor(tiers[1])),
        const SizedBox(width: kGapS),
        Expanded(child: chipFor(tiers[2])),
      ],
    );
  }

  /// A method that returns a Widget: one chip, built from one Tier.
  Widget chipFor(Tier tier) {
    return TierChip(
      name: tier.name,
      price: money(tier.price),
      selected: tier.name == selected.name,
      onTap: () => onChanged(tier),
    );
  }
}

class TierChip extends StatelessWidget {
  const TierChip({
    super.key,
    required this.name,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String price;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // The chip reports the tap. The screen decides what it means.
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      // Ink, not Container: a Container's colour would cover the ripple.
      child: Ink(
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
