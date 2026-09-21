import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/task.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/quote_card.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tasks = <Task>[];

  Future<void> openAddScreen() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );
    if (newTask == null) return; // user pressed back instead of saving
    setState(() => tasks.add(newTask));
  }

  Future<void> openTask(Task task) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );
    if (result == 'toggle') {
      setState(() => task.isDone = !task.isDone);
    } else if (result == 'delete') {
      setState(() => tasks.remove(task));
    }
  }

  Future<bool> confirmDelete(Task task) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete "${task.title}"?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Derived in build, so they can never be stale.
    tasks.sort((a, b) {
      if (a.isDone == b.isDone) return 0;
      return a.isDone ? 1 : -1;
    });
    final done = tasks.where((t) => t.isDone).length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardHeader(done: done, total: tasks.length),
            const QuoteCard(),
            const SizedBox(height: 4),
            Expanded(
              child: tasks.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 90),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Dismissible(
                          key: ValueKey(task),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            padding: const EdgeInsets.only(right: 24),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (_) => confirmDelete(task),
                          onDismissed: (_) =>
                              setState(() => tasks.remove(task)),
                          child: TaskTile(
                            task: task,
                            onToggle: () =>
                                setState(() => task.isDone = !task.isDone),
                            onTap: () => openTask(task),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddScreen,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New task'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny_outlined, size: 80, color: AppColors.muted),
          SizedBox(height: 16),
          Text(
            'Nothing planned yet',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tap “New task” to plan your day',
            style: TextStyle(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
