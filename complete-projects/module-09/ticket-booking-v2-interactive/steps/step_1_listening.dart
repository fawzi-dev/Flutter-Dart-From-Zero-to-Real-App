// End of lesson 9.5 P1 -- "The Ticket Card Listens".
//
// *** DELIBERATELY BROKEN AT THE END. RUN IT ANYWAY. ***
//
// The heart and both steppers are real IconButtons. StepButton and
// QuantityRow take a VoidCallback: they report a tap, the screen decides what
// it means. Then quantity is a local inside build -- the counter's bug from
// 9.2, on a real screen. The terminal counts; the screen stays at 2.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// The palette. Five colours, named once, used everywhere.
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

  @override
  Widget build(BuildContext context) {
    // THE BUG, on purpose: a local inside build, made fresh every build.
    int quantity = 2;

    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kGapL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventPoster(),
                SizedBox(height: kGapXL),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Night at the Citadel — Open Air Summer Serie",
                        style: TextStyle(
                          color: kInk,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: kGapS,
                    ),
                    IconButton(
                      onPressed: () {
                        debugPrint('favourite pressed');
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: kMuted,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kGapS),
                EvenDetails(),

                SizedBox(height: kGapXL),

                SoldBar(sold: 142, total: 200),
                SizedBox(height: kGapXL),

                Tiers(),
                SizedBox(height: kGapXL),

                QuantityRow(
                  qty: quantity,
                  onMinus: () {
                    quantity--;
                    debugPrint('quantity is now $quantity');
                  },
                  onPlus: () {
                    quantity++;
                    debugPrint('quantity is now $quantity');
                  },
                ),
                SizedBox(height: kGapXL),

                DividerContainer(),
                SizedBox(height: kGapXL),

                TotalRow(),
                SizedBox(height: kGapXL),

                BookButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EvenDetails extends StatelessWidget {
  const EvenDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SAT  ·  14 SEP  ·  8:00 PM",
          style: TextStyle(
            color: kMuted,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: kGapS),
        Text(
          'An open-air night in the old amphitheatre, with the city '
          'walls behind the stage and doors opening an hour early.',
          style: TextStyle(fontSize: 14, height: 1.45, color: kMuted),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class DividerContainer extends StatelessWidget {
  const DividerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLine,
      height: 2,
      width: double.infinity,
    );
  }
}

class BookButton extends StatelessWidget {
  const BookButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: kAccent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Book now",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TotalRow extends StatelessWidget {
  const TotalRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total",
          style: TextStyle(fontSize: 15, color: kMuted),
        ),
        Text(
          "120,000 IQD",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kInk),
        ),
      ],
    );
  }
}

class QuantityRow extends StatelessWidget {
  const QuantityRow({
    super.key,
    required this.qty,
    required this.onMinus,
    required this.onPlus,
  });

  final int qty;

  // A function that takes nothing and returns nothing. The row doesn't decide
  // what a tap means: it hands the tap to whoever built it.
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tickets",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            StepButton(
              icon: Icons.remove,
              onPressed: onMinus,
            ),

            SizedBox(
              width: 48,
              child: Text(
                qty.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            StepButton(icon: Icons.add, onPressed: onPlus),
          ],
        ),
      ],
    );
  }
}

class StepButton extends StatelessWidget {
  const StepButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

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
      // A real button now, ripple and all. Handed over bare: no brackets.
      // IconButton brings its own padding, so the icon shrinks to fit.
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
      ),
    );
  }
}

class Tiers extends StatelessWidget {
  const Tiers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: kGapS,
      children: [
        Expanded(
          // Object 1
          child: TierChip(
            name: "STANDARD",
            price: "35,00",
          ),
        ),
        // Object 2
        Expanded(
          child: TierChip(
            name: "VIP",
            price: "60,00",
            isSelected: true,
          ),
        ),
        // Object 3
        Expanded(
          child: TierChip(
            name: "BACKSTAGE",
            price: "95,00",
          ),
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
    this.isSelected = false,
  });

  final String name;
  final String price;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? kAccent : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kLine),
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
              color: isSelected ? Colors.white : kInk,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              color: isSelected ? Colors.white : kMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class SoldBar extends StatelessWidget {
  const SoldBar({super.key, required this.sold, required this.total});

  final int sold;
  final int total;

  @override
  Widget build(BuildContext context) {
    final remaining = total - sold;
    return Row(
      children: [
        Text(
          "$sold sold",
          style: TextStyle(color: kMuted, fontSize: 12),
        ),
        SizedBox(
          width: kGapS,
        ),
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
        SizedBox(
          width: kGapS,
        ),
        Text(
          "$total seats",
          style: TextStyle(color: kMuted, fontSize: 12),
        ),
      ],
    );
  }
}

class EventPoster extends StatelessWidget {
  const EventPoster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/event.jpg",
            height: 210,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          top: kGapM,
          left: kGapM,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kAccent,
            ),
            child: Text(
              "FEW LEFT",
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
