import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Controllers are State FIELDS, not locals in build — otherwise they'd be
  // recreated on every rebuild and the user's typing would vanish.
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  Priority priority = Priority.medium;
  String? titleError;

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void save() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      setState(() => titleError = 'Please enter a task title');
      return;
    }
    final note = noteController.text.trim();
    Navigator.pop(
      context,
      Task(
        title: title,
        note: note.isEmpty ? null : note, // empty note -> null, not ''
        priority: priority,
      ),
    );
  }

  InputDecoration _field(String label, {String? error}) => InputDecoration(
    labelText: label,
    errorText: error,
    filled: true,
    fillColor: AppColors.card,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: _field('What needs doing?', error: titleError),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: _field('Notes (optional)'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Priority',
              style: TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              // Priority.values is every value in the enum, mapped to chips.
              children: Priority.values.map((p) {
                return ChoiceChip(
                  label: Text(p.name),
                  selected: priority == p,
                  onSelected: (_) => setState(() => priority = p),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save task',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
