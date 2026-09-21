import 'package:flutter/material.dart';

import '../models/task.dart';

/// Stateless. Receives a task and two callbacks; owns nothing.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  });

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Checkbox(
        value: task.isDone,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
          color: task.isDone ? Colors.grey : null,
        ),
      ),
      // No note? No subtitle. Nullable types shaping the UI.
      subtitle: task.note == null
          ? null
          : Text(task.note!, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: colorForPriority(task.priority),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
