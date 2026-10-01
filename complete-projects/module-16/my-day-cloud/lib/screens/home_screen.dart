import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/task.dart';
import '../services/auth_service.dart';
import '../services/task_service.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/quote_card.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'favorites_screen.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> openAddScreen(BuildContext context) async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );
    if (newTask == null) return;
    await TaskService.add(newTask); // no setState — the stream rebuilds
  }

  Future<void> openTask(BuildContext context, Task task) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );
    if (result == 'toggle') {
      await TaskService.toggle(task.id!, !task.isDone);
    } else if (result == 'delete') {
      await TaskService.delete(task.id!);
    }
  }

  Future<bool> confirmDelete(BuildContext context, Task task) async {
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
    return Scaffold(
      // Minimal bar — just the account actions. The dashboard header is the
      // real header, in the body.
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.primary),
            tooltip: 'Favorite quotes',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') AuthService.logOut();
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                enabled: false,
                child: Text(AuthService.currentUser?.email ?? ''),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Log out'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<Task>>(
          stream: TaskService.watchTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Could not load your tasks'));
            }

            final tasks = snapshot.data ?? [];
            tasks.sort((a, b) {
              if (a.isDone == b.isDone) return 0;
              return a.isDone ? 1 : -1;
            });
            final done = tasks.where((t) => t.isDone).length;

            return Column(
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
                              key: ValueKey(task.id),
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
                              confirmDismiss: (_) =>
                                  confirmDelete(context, task),
                              onDismissed: (_) => TaskService.delete(task.id!),
                              child: TaskTile(
                                task: task,
                                onToggle: () =>
                                    TaskService.toggle(task.id!, !task.isDone),
                                onTap: () => openTask(context, task),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openAddScreen(context),
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
