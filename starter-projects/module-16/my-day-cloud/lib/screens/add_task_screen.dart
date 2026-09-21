import 'package:flutter/material.dart';

import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Controllers are State FIELDS, not locals in build. Created in build,
  // they would be recreated on every rebuild and the user's typing would vanish.
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
        // Empty note becomes null, not '' — null honestly means "no note".
        note: note.isEmpty ? null : note,
        priority: priority,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'What needs doing?',
                errorText: titleError,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Priority'),
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
              child: FilledButton(
                onPressed: save,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Save task'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
