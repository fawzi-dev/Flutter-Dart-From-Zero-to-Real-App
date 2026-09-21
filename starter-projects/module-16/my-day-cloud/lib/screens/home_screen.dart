import 'package:flutter/material.dart';

import '../models/task.dart';
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
          TextButton(
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
    // Computed in build, so they can never be stale.
    tasks.sort((a, b) {
      if (a.isDone == b.isDone) return 0;
      return a.isDone ? 1 : -1;
    });
    final pending = tasks.where((t) => !t.isDone).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Day'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text('$pending left')),
          ),
        ],
      ),
      body: Column(
        children: [
          const QuoteCard(),
          Expanded(
            child: tasks.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Dismissible(
                        key: ValueKey(task),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
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
      floatingActionButton: FloatingActionButton(
        onPressed: openAddScreen,
        child: const Icon(Icons.add),
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
          Icon(Icons.check_circle_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('No tasks yet',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(height: 4),
          Text('Tap + to add your first one',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
