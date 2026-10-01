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

  // Task -> Map, for saving. The mirror image of fromJson below.
  // Two fields can't go into JSON as-is: an enum and a DateTime. So we turn
  // the enum into its name ('high') and the date into a string.
  Map<String, dynamic> toJson() => {
    'title': title,
    'note': note,
    'priority': priority.name,
    'createdAt': createdAt.toIso8601String(),
    'isDone': isDone,
  };

  // Map -> Task, for loading. Same recipe as the weather app's fromJson
  // (Module 11) — raw stored data stops here and the app only sees a Task.
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'] as String,
    note: json['note'] as String?,
    priority: Priority.values.firstWhere(
      (p) => p.name == json['priority'],
      orElse: () => Priority.medium,
    ),
    createdAt: DateTime.parse(json['createdAt'] as String),
    isDone: json['isDone'] as bool? ?? false,
  );
}
