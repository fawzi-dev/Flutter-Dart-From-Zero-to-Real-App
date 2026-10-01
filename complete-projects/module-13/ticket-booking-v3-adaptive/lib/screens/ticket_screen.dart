import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/ticket_parts.dart';

/// The ticket card, reflowing.
///
/// Two layouts, and neither one contains a duplicated widget — because
/// `EventPoster`, `EventHeading`, `SoldBar`, `TierRow`, `QuantityRow` and
/// `TotalRow` have been separate widgets since Module 8. That extraction is
/// what makes this lesson cost twenty lines instead of a second copy of the
/// whole screen.
class TicketScreen extends StatefulWidget {
  const TicketScreen({
    super.key,
    required this.themeMode,
    required this.onCycleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onCycleTheme;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  static const _title = 'Night at the Citadel — Open Air Summer Series';
  static const _when = 'SAT  ·  14 SEP  ·  8:00 PM';
  static const _seats = 200;

  Tier tier = tiers[1]; // VIP
  int quantity = 2;
  int sold = 142;
  bool isFavourite = false;

  /// Derived, never stored — recomputed every build from what it depends on.
  int get total => tier.price * quantity;

  void changeQuantity(int by) {
    final next = quantity + by;
    if (next < 1 || next > 8) return;
    setState(() => quantity = next);
  }

  // A plain if/else chain. There is a shorter way to write this in modern
  // Dart; there is no clearer way.
  IconData get _themeIcon {
    if (widget.themeMode == ThemeMode.system) return Icons.brightness_auto;
    if (widget.themeMode == ThemeMode.light) return Icons.light_mode;
    return Icons.dark_mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        actions: [
          IconButton(
            onPressed: widget.onCycleTheme,
            icon: Icon(_themeIcon),
            tooltip: 'System / Light / Dark',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kGapL),
          // LayoutBuilder asks how much space THIS box has — not how big the
          // screen is. Almost always the question you actually want answered.
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < kWideBreakpoint) {
                return _narrow();
              }
              return _wide();
            },
          ),
        ),
      ),
    );
  }

  /// Phone: poster on top, everything under it. What we've had since Module 8.
  Widget _narrow() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventPoster(),
          const SizedBox(height: kGapXL),
          _details(),
        ],
      ),
    );
  }

  /// Tablet: poster on the left, booking beside it. Same pieces.
  Widget _wide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: EventPoster(height: 420)),
        const SizedBox(width: 40),
        Expanded(child: SingleChildScrollView(child: _details())),
      ],
    );
  }

  Widget _details() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventHeading(
          title: _title,
          when: _when,
          isFavourite: isFavourite,
          onFavourite: () => setState(() => isFavourite = !isFavourite),
        ),
        const SizedBox(height: kGapXL),
        SoldBar(sold: sold, total: _seats),
        const SizedBox(height: kGapXL),
        TierRow(
          selected: tier,
          onChanged: (t) => setState(() => tier = t),
        ),
        const SizedBox(height: kGapXL),
        QuantityRow(quantity: quantity, onChanged: changeQuantity),
        const SizedBox(height: kGapL),
        TotalRow(total: money(total), discount: 0),
      ],
    );
  }
}
