// End of lesson 9.7 P2 -- "Some Actions Ask First".
//
// Finished, and identical to lib/main.dart below this header. Start over asks
// first, because clearing every choice cannot be undone.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

/// The three ticket prices, in the same order as the chips.
const prices = [35000, 60000, 95000];

/// 120000 becomes '120,000'. The intl package does the commas.
String money(int amount) => NumberFormat('#,###').format(amount);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tickets',
      // The text field, the switch, the checkbox and the dialog all take
      // their colour from here. Without it, they are purple.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kAccent),
      ),
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
  // Everything a human can change lives here, in one place.
  int tierIndex = 1; // VIP
  int quantity = 2;
  bool isFavourite = false;
  int sold = 142;

  final codeController = TextEditingController();
  String? codeError;
  int discountPercent = 0;

  String delivery = 'Email';
  bool remindMe = true;
  bool acceptedPolicy = false;

  @override
  void dispose() {
    // Create a controller, dispose the controller.
    codeController.dispose();
    super.dispose();
  }

  /// Derived, never stored: worked out on every build, so it can never be
  /// out of date. 9.6 P3 gave it one more input.
  int get total {
    final gross = prices[tierIndex] * quantity;
    return gross - (gross * discountPercent ~/ 100);
  }

  void addTicket() {
    if (quantity < 8) {
      setState(() {
        quantity++;
      });
    }
  }

  void removeTicket() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void book() {
    // One answer at a time: a new tap replaces whatever is showing.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (!acceptedPolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please accept the refund policy.')),
      );
      return;
    }

    if (sold + quantity > 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Only ${200 - sold} seats left.')),
      );
      return;
    }

    // Remember what was booked. UNDO may be tapped after plus.
    final booked = quantity;
    setState(() => sold += booked);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booked $booked tickets · ${money(total)} IQD'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => setState(() => sold -= booked),
        ),
      ),
    );
  }

  /// Clearing every choice cannot be undone, so ask first.
  Future<void> startOver() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start over?'),
        content: Text('This clears every choice on the ticket.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Start over'),
          ),
        ],
      ),
    );

    // Cancel sends false. A tap outside the dialog sends nothing: null.
    if (confirmed != true) return;

    // The heart stays. It is about the event, not about this booking.
    setState(() {
      tierIndex = 1;
      quantity = 2;
      codeController.clear();
      codeError = null;
      discountPercent = 0;
      delivery = 'Email';
      remindMe = true;
      acceptedPolicy = false;
    });
  }

  /// Two guards: is it a code at all, and is it *the* code.
  void applyCode() {
    final code = codeController.text.trim().toUpperCase();
    setState(() {
      if (code.isEmpty) {
        codeError = 'Type a code first';
        discountPercent = 0;
      } else if (code != 'CITADEL20') {
        codeError = "That code isn't valid";
        discountPercent = 0;
      } else {
        codeError = null;
        discountPercent = 20;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: kGapS),
                EvenDetails(),

                SizedBox(height: kGapXL),

                // The bar moves for real when somebody books.
                SoldBar(sold: sold, total: 200),
                SizedBox(height: kGapXL),

                Tiers(
                  selected: tierIndex,
                  onChanged: (i) => setState(() => tierIndex = i),
                ),
                SizedBox(height: kGapXL),

                QuantityRow(
                  qty: quantity,
                  onMinus: removeTicket,
                  onPlus: addTicket,
                ),
                SizedBox(height: kGapXL),

                // Typed by a human, so it might be wrong.
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: codeController,
                        decoration: InputDecoration(
                          labelText: 'Discount code',
                          hintText: 'e.g. CITADEL20',
                          // null means no error is shown.
                          errorText: codeError,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: kGapM),
                    ElevatedButton(
                      onPressed: applyCode,
                      child: Text('Apply'),
                    ),
                  ],
                ),
                SizedBox(height: kGapXL),

                // Value in, onChanged out, setState in between.
                Row(
                  children: [
                    Text('Delivery', style: TextStyle(color: kMuted)),
                    SizedBox(width: kGapM),
                    DropdownButton<String>(
                      value: delivery,
                      underline: SizedBox.shrink(),
                      items: [
                        DropdownMenuItem(value: 'Email', child: Text('Email')),
                        DropdownMenuItem(value: 'SMS', child: Text('SMS')),
                        DropdownMenuItem(
                          value: 'At venue',
                          child: Text('At venue'),
                        ),
                      ],
                      onChanged: (choice) {
                        if (choice == null) return;
                        setState(() => delivery = choice);
                      },
                    ),
                  ],
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Remind me the day before',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: remindMe,
                  onChanged: (v) => setState(() => remindMe = v),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'I accept the refund policy',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: acceptedPolicy,
                  onChanged: (v) => setState(() => acceptedPolicy = v ?? false),
                ),
                SizedBox(height: kGapXL),

                DividerContainer(),
                SizedBox(height: kGapXL),

                TotalRow(total: '${money(total)} IQD'),
                SizedBox(height: kGapXL),

                BookButton(onPressed: book),
                SizedBox(height: kGapS),
                Center(
                  child: TextButton(
                    onPressed: startOver,
                    child: Text('Start over'),
                  ),
                ),
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
    required this.onPressed,
  });

  // Book is never switched off now, so null is not allowed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // A real button, as wide as the Container was.
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kAccent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text("Book now"),
      ),
    );
  }
}

class TotalRow extends StatelessWidget {
  const TotalRow({
    super.key,
    required this.total,
  });

  final String total;

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
          total,
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
    required this.selected,
    required this.onChanged,
  });

  // Which chip is picked: 0, 1 or 2.
  final int selected;

  // A VoidCallback is handed nothing. This row has to say WHICH chip was
  // tapped, so its function is handed the chip's number.
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: kGapS,
      children: [
        Expanded(
          // Object 1
          child: TierChip(
            name: "STANDARD",
            price: money(prices[0]),
            isSelected: selected == 0,
            onTap: () => onChanged(0),
          ),
        ),
        // Object 2
        Expanded(
          child: TierChip(
            name: "VIP",
            price: money(prices[1]),
            isSelected: selected == 1,
            onTap: () => onChanged(1),
          ),
        ),
        // Object 3
        Expanded(
          child: TierChip(
            name: "BACKSTAGE",
            price: money(prices[2]),
            isSelected: selected == 2,
            onTap: () => onChanged(2),
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
    required this.onTap,
  });

  final String name;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // The chip reports the tap. The screen decides what it means.
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      // Ink, not Container: a Container's colour would cover the ripple.
      child: Ink(
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
