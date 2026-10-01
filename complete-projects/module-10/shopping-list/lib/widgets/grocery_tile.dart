import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/grocery_item.dart';
import 'circle_checkbox.dart';

/// One grocery item as a rounded card. Still built on ListTile (the right tool
/// for list rows) — just wrapped in a styled card with a custom checkbox and a
/// quantity pill. Owns no state: it displays an item and calls the callbacks
/// it was given.
class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.item, required this.onToggle});

  final GroceryItem item;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // A tap ripple needs a Material ancestor to paint on. Colors.transparent
      // keeps the Container's rounded card visible, and the matching
      // borderRadius + clip keeps the ripple inside the rounded corners.
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onToggle,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: CircleCheckbox(checked: item.bought, onTap: onToggle),
          title: Text(
            item.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: item.bought ? AppColors.muted : AppColors.ink,
              decoration: item.bought
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '×${item.quantity}',
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
