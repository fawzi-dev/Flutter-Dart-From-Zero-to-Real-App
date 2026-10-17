import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/grocery_item.dart';
import '../widgets/grocery_tile.dart';
import '../widgets/progress_header.dart';
import 'add_item_screen.dart';

/// Owns the data and all the logic. Other screens visit and report back.
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final items = <GroceryItem>[];

  Future<void> openAddScreen() async {
    final newItem = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(builder: (context) => const AddItemScreen()),
    );

    // The user may have pressed back instead of saving — handle BOTH exits.
    if (newItem == null) return;

    setState(() => items.add(newItem));
  }

  // Delete straight away, but keep a way back: the undo from 10.4.
  void deleteItem(GroceryItem item) {
    final removedIndex = items.indexOf(item);
    setState(() => items.remove(item));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () => setState(() => items.insert(removedIndex, item)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bought items sink to the bottom. Sorting in build means it's always
    // fresh, because build reruns whenever the data changes.
    items.sort((a, b) {
      if (a.bought == b.bought) return 0;
      return a.bought ? 1 : -1;
    });

    final boughtCount = items.where((item) => item.bought).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Groceries'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const _EmptyState()
          : Column(
              children: [
                ProgressHeader(done: boughtCount, total: items.length),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Dismissible(
                        // Key the ITEM, not the index — otherwise deleting one
                        // makes Flutter remove the wrong tile.
                        key: ValueKey(item),
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
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => deleteItem(item),
                        child: GroceryTile(
                          item: item,
                          onToggle: () =>
                              setState(() => item.bought = !item.bought),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddScreen,
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add item'),
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
          Icon(
            Icons.shopping_basket_outlined,
            size: 88,
            color: AppColors.muted,
          ),
          SizedBox(height: 16),
          Text(
            'Your list is empty',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tap “Add item” to get started',
            style: TextStyle(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
