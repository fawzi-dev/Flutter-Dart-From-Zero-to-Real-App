# Cheat Sheet — State & Interaction (Module 9)

## The loop
> **Change the data → call `setState` → Flutter re-runs `build` → screen matches data.**

## Stateful widget
```dart
class Counter extends StatefulWidget {
  const Counter({super.key});
  @override
  State<Counter> createState() => _CounterState();
}
class _CounterState extends State<Counter> {
  int count = 0;                          // state lives here
  void increment() => setState(() => count++);
  @override
  Widget build(BuildContext context) => Text('$count');
}
```

## Buttons
```dart
ElevatedButton(onPressed: increment, child: const Text('Go'))  // pass, don't call
FilledButton.icon(onPressed: doThing, icon: const Icon(Icons.add), label: const Text('Add'))
IconButton(onPressed: doThing, icon: const Icon(Icons.delete), tooltip: 'Delete')
// onPressed: null  -> disabled button
```

## Text input
```dart
class _FormState extends State<Form_> {
  final controller = TextEditingController();       // FIELD, not in build
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(context) => TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText: 'Amount', errorText: error),
  );
}
final n = double.tryParse(controller.text);   // null-check bad input
```

## The input family (value + onChanged)
```dart
Switch(value: on, onChanged: (v) => setState(() => on = v))
Slider(value: x, min: 0, max: 100, onChanged: (v) => setState(() => x = v))
SegmentedButton(segments: [...], selected: {choice},
  onSelectionChanged: (s) => setState(() => choice = s.first))
```

## Feedback
```dart
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
showDialog(context: context, builder: (_) => AlertDialog(
  title: const Text('Delete?'),
  actions: [ TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
             FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')) ]));
```

## Gotchas
- Changed a variable but the screen didn't update? You forgot `setState`.
- `onPressed: doThing()` fires immediately — drop the `()`.
- Controller created in `build`? Move it to a State field, and `dispose()` it.
