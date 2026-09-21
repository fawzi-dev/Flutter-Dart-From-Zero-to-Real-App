import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/task.dart';

/// One task as a card with a coloured priority stripe down the left edge.
/// Stateless — it displays a task and calls the callbacks it was given.
class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onToggle, required this.onTap});

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          // The priority stripe.
          Container(
            width: 6,
            height: 64,
            decoration: BoxDecoration(
              color: colorForPriority(task.priority),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            ),
          ),
          Expanded(
            child: Material(
              child: ListTile(
                onTap: onTap,
                leading: IconButton(
                  icon: Icon(task.isDone ? Icons.check_circle : Icons.circle_outlined, color: task.isDone ? AppColors.primary : AppColors.muted),
                  onPressed: onToggle,
                ),
                title: Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.w600, color: task.isDone ? AppColors.muted : AppColors.ink, decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none),
                ),
                subtitle: task.note == null ? null : Text(task.note!, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
