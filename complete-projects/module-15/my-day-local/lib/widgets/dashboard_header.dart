import 'package:flutter/material.dart';

import '../app_colors.dart';

/// The "today" header: the date on the left, and a progress RING on the right
/// showing how much of today is done. The ring is a CircularProgressIndicator
/// with a value, stacked under centred text — a nice pattern to know.
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final fraction = total == 0 ? 0.0 : done / total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                friendlyDate(DateTime.now()),
                style: const TextStyle(color: AppColors.muted, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: CircularProgressIndicator(
                    value: fraction,
                    strokeWidth: 7,
                    backgroundColor: const Color(0xFFE6E8F2),
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '$done/$total',
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
