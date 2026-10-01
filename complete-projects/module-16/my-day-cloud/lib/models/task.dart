import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Priority { low, medium, high }

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
  final String? id; // the Firestore document id — needed to update and delete
  final String title;
  final String? note;
  final Priority priority;
  final DateTime createdAt;
  bool isDone;

  Task({
    this.id,
    required this.title,
    this.note,
    this.priority = Priority.medium,
    DateTime? createdAt,
    this.isDone = false,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Same boundary as fromJson: raw cloud data stops here.
  /// Note the defensive defaults — a document written by an older version
  /// of the app might not have every field.
  factory Task.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] as String? ?? '',
      note: data['note'] as String?,
      priority: Priority.values.firstWhere(
        (p) => p.name == data['priority'],
        orElse: () => Priority.medium,
      ),
      isDone: data['isDone'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
