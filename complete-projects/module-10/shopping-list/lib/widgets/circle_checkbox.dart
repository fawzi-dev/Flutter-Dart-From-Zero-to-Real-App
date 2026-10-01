import 'package:flutter/material.dart';

import '../app_colors.dart';

/// A custom circular checkbox. An empty ring when unchecked; fills with the
/// accent colour and shows a tick when checked.
///
/// Uses AnimatedContainer — an "implicit animation". You describe the two
/// states and Flutter animates between them for free. Same trick as the BMI
/// marker's AnimatedAlign bonus, this time for a Container.
class CircleCheckbox extends StatelessWidget {
  const CircleCheckbox({super.key, required this.checked, required this.onTap});

  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: checked ? AppColors.accent : Colors.transparent,
          border: Border.all(
            color: checked ? AppColors.accent : AppColors.muted,
            width: 2,
          ),
        ),
        child: checked
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : null,
      ),
    );
  }
}
