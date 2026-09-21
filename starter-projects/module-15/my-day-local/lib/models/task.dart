import 'package:flutter/material.dart';

enum Priority { low, medium, high }

// No `default` case needed: the compiler knows the enum's full menu and
// will flag this switch if a fourth priority is ever added.
Color colorForPriority(Priority p) {
  switch (p) {
    case Priority.low:
      return Colors.green;
    case Priority.medium:
      return Colors.orange;
    case Priority.high:
      return Colors.red;
  }
}

class Task {
  final String title;
  final String? note; // optional, so nullable — null genuinely means "no note"
  final Priority priority;
  final DateTime createdAt;
  bool isDone; // not final: completing a task is the point

  Task({
    required this.title,
    this.note,
    this.priority = Priority.medium,
    DateTime? createdAt,
    this.isDone = false,
  }) : createdAt = createdAt ?? DateTime.now();
}
