# Challenge 2 — Fix the Bugs (Flutter app edition)

Five bugs from the exact territory you just learned: callbacks, `setState`, `Navigator.pop`, `ListView`, and forms. For each one:
1. name the symptom,
2. explain the real cause,
3. write the smallest honest fix.

Not every bug is a red squiggle. Some are layout complaints, some are logic bugs, and some only appear when a human taps the screen. That's the point.

### Bug 1 — The button calls itself too early
```dart
FloatingActionButton.extended(
  onPressed: openAddScreen(),
  icon: const Icon(Icons.add),
  label: const Text('Add item'),
)
```

### Bug 2 — The user pressed back
```dart
Future<void> openAddScreen() async {
  final newItem = await Navigator.push<GroceryItem>(
    context,
    MaterialPageRoute(builder: (context) => const AddItemScreen()),
  );

  setState(() => items.add(newItem));
}
```

### Bug 3 — The list has no height
```dart
body: Column(
  children: [
    ProgressHeader(done: boughtCount, total: items.length),
    ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => GroceryTile(item: items[index]),
    ),
  ],
),
```

### Bug 4 — The data changed, the UI did not
```dart
void toggleItem(GroceryItem item) {
  item.bought = !item.bought;
}
```

### Bug 5 — The keyboard ate the screen
```dart
body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      TextField(controller: nameController),
      const SizedBox(height: 16),
      TextField(controller: noteController, maxLines: 4),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: save,
        child: const Text('Save'),
      ),
    ],
  ),
),
```

## Hint ladder
- Bug 1 is the same bug as `sayHello` vs `sayHello()` in Module 3 and `onPressed` in Module 9.
- Bug 2 is the null-safety interaction bug from lesson 10.10.
- Bug 3 is Module 8.4 colliding with 10.1.
- Bug 4 is not a Dart bug. It's a Flutter rebuild bug.
- Bug 5 only shows up on a real device or a small emulator when the keyboard opens.

Write your answers before opening the solution. One sentence per bug is enough if the sentence is precise.

**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.
