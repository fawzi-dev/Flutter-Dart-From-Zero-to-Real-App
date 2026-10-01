import 'package:flutter/material.dart';

import '../theme.dart';

/// The pieces of the ticket card, unchanged in shape since Module 8 — but with
/// every colour now asked for rather than hardcoded.
///
/// These being separate widgets is what makes lesson 13.3 cheap: the two
/// layouts (stacked and side-by-side) share them, so neither branch duplicates
/// a single line of UI.

class EventPoster extends StatelessWidget {
  const EventPoster({super.key, this.height = 210});

  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/event.jpg',
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: kGapM,
          left: kGapM,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'FEW LEFT',
              style: TextStyle(
                // onPrimary — "whatever reads on top of primary". The theme
                // works that out in both palettes so you never have to.
                color: scheme.onPrimary,
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

class EventHeading extends StatelessWidget {
  const EventHeading({
    super.key,
    required this.title,
    required this.when,
    required this.isFavourite,
    required this.onFavourite,
  });

  final String title;
  final String when;
  final bool isFavourite;
  final VoidCallback onFavourite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  // onSurface, not "black" — in a dark theme black would
                  // vanish, and that is the bug this module prevents.
                  color: scheme.onSurface,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: kGapM),
            IconButton(
              onPressed: onFavourite,
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? scheme.primary : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: kGapS),
        Text(
          when,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SoldBar extends StatelessWidget {
  const SoldBar({super.key, required this.sold, required this.total});

  final int sold;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = TextStyle(fontSize: 12, color: scheme.onSurfaceVariant);
    final remaining = total - sold;

    return Row(
      children: [
        Text('$sold sold', style: label),
        const SizedBox(width: kGapM),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: sold,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Expanded(
                flex: remaining < 1 ? 1 : remaining,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
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
    );
  }
}

class TierRow extends StatelessWidget {
  const TierRow({super.key, required this.selected, required this.onChanged});

  final Tier selected;
  final void Function(Tier) onChanged;

  @override
  Widget build(BuildContext context) {
    // Three Expandeds, so the options always split the width evenly.
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

  Widget chipFor(Tier tier) {
    return TierChip(
      tier: tier,
      selected: tier.name == selected.name,
      onTap: () => onChanged(tier),
    );
  }
}

class TierChip extends StatelessWidget {
  const TierChip({
    super.key,
    required this.tier,
    required this.selected,
    required this.onTap,
  });

  final Tier tier;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        child: Column(
          children: [
            Text(
              tier.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected ? scheme.onPrimary : scheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              money(tier.price).replaceAll(' IQD', ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: selected
                    ? scheme.onPrimary.withValues(alpha: 0.8)
                    : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityRow extends StatelessWidget {
  const QuantityRow({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tickets',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        Row(
          children: [
            _StepButton(icon: Icons.remove, onPressed: () => onChanged(-1)),
            SizedBox(
              width: 48,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
            _StepButton(icon: Icons.add, onPressed: () => onChanged(1)),
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
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: scheme.onSurface),
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class TotalRow extends StatelessWidget {
  const TotalRow({super.key, required this.total, required this.discount});

  final String total;
  final int discount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Text(
          discount > 0 ? 'Total  ($discount% off)' : 'Total',
          style: TextStyle(fontSize: 15, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(width: kGapM),
        Expanded(
          child: Text(
            total,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
