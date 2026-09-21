# Cheat Sheet — Lists & Navigation (Module 10)

## ListView.builder (only builds what's visible)
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return ListTile(title: Text(item.name), onTap: () {});
  },
)
```

## ListTile
```dart
ListTile(
  leading: const Icon(Icons.circle),
  title: Text(item.name),
  subtitle: Text(item.note),
  trailing: const Icon(Icons.chevron_right),
  onTap: () {},
)
```

## Swipe to delete
```dart
Dismissible(
  key: ValueKey(item),                    // key the ITEM, not the index
  direction: DismissDirection.endToStart,
  background: Container(color: Colors.red),
  confirmDismiss: (_) => confirmDialog(),
  onDismissed: (_) => setState(() => items.remove(item)),
  child: MyTile(item: item),
)
```

## Navigation (a stack of screens)
```dart
// go forward, and get a result back
final result = await Navigator.push<Item>(context,
  MaterialPageRoute(builder: (_) => const AddScreen()));
if (result == null) return;             // user pressed back
setState(() => items.add(result));

// on the add screen: send a result back
Navigator.pop(context, newItem);
```
- **Pass data forward** via the screen's constructor: `DetailScreen(item: item)`.
- **Send data back** via `pop(result)`.

## Derived-in-build (never store, never stale)
```dart
final done = items.where((i) => i.bought).length;   // recomputed every build
items.sort((a, b) => a.bought == b.bought ? 0 : (a.bought ? 1 : -1));
```

## Project structure (when a file earns its place)
```
lib/
  main.dart
  app_colors.dart        // shared -> its own file
  models/grocery_item.dart
  screens/list_screen.dart, add_item_screen.dart
  widgets/grocery_tile.dart
```

## Gotchas
- `ListView` inside a `Column` with no height → wrap the list in `Expanded`.
- Keyed by index on a `Dismissible` → deletes the wrong row.
- Sharing state between distant screens hurts → that ache is what state management solves (later).
